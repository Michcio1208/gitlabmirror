// Deklaracja modułu ALU z parametrem WIDTH (domyślnie 8 bitów).
module alu #(
    parameter WIDTH = 8
) (
    input  wire                    i_clk,    // Wejście zegarowe
    input  wire                    i_rstn,   // Wejście asynchronicznego resetu (aktywne zerem - 'n' od negative)
    input  wire signed [WIDTH-1:0] i_arg0,   // Argument A (ze znakiem, w kodzie U2)
    input  wire signed [WIDTH-1:0] i_arg1,   // Argument B (ze znakiem, w kodzie U2)
    input  wire        [3:0]       i_oper,   // 4-bitowy wybór operacji
    output reg  signed [WIDTH-1:0] o_result, // Wyjście wyniku (reg, bo pamiętane w przerzutniku)
    output reg         [5:0]       o_flag    // Wyjście flag statusowych: {O, C, Z, N, E, T}
);

    // Stałe lokalne nadające czytelne nazwy kodom operacji (i_oper):
    localparam OP_AND   = 4'd0; // Иloczyn bitowy (AND)
    localparam OP_OR    = 4'd1; // Suma bitowa (OR)
    localparam OP_XOR   = 4'd2; // Różnica symetryczna (XOR)
    localparam OP_SUB   = 4'd3; // Odejmowanie (i_arg0 - i_arg1)
    localparam OP_ADD   = 4'd4; // Dodawanie (i_arg0 + i_arg1)
    localparam OP_SHL   = 4'd5; // Przesunięcie logiczne (w lewo gdy i_arg1 > 0, w prawo gdy i_arg1 < 0)
    localparam OP_SHA   = 4'd6; // Przesunięcie arytmetyczne (zachowuje bit znaku przy przesunięciu w prawo)
    localparam OP_TONES = 4'd7; // Zliczanie jedynek w kodzie termometrowym (od LSB do pierwszego zera)
    localparam OP_ZHOT  = 4'd8; // Dekoder Zero-Hot (zwraca indeks bitu, na którym stoi jedyne zero)

    // Sygnały wewnętrzne (zadeklarowane jako 'reg', ponieważ przypisujemy im wartości wewnątrz bloku always @(*),
    // ale fizycznie po syntezie tworzą zwykłą logikę kombinacyjną, a nie przerzutniki!):
    reg signed [WIDTH-1:0]   s_result; // Roboczy wynik operacji przed zatrzaśnięciem w rejestrze wyjściowym
    reg        [5:0]         s_flag;   // Roboczy wektor wszystkich 6 flag
    reg        [2*WIDTH-1:0] s_ab;     // Złączony 16-bitowy wektor obu argumentów: {i_arg0, i_arg1}
    reg        [WIDTH:0]     s_ext;    // 9-bitowy wektor pomocniczy (WIDTH+1 bitów) do wykrywania przeniesienia (Carry)
    
    // Pojedyncze flagi:
    // O (Overflow - nadmiar ze znakiem), C (Carry - przeniesienie bez znaku), Z (Zero - wynik równy 0),
    // N (Negative - wynik ujemny), E (Error - błąd kodu Zero-Hot), T (Thermometer - poprawny kod termometrowy)
    reg                      s_flag_O, s_flag_C, s_flag_Z, s_flag_N, s_flag_E, s_flag_T;
    
    reg                      s_was0;   // Flaga pomocnicza pętli Zero-Hot: czy napotkano już pierwsze zero?
    reg                      s_stop;   // Flaga pomocnicza pętli OP_TONES: zatrzymuje zliczanie po napotkaniu zera
    reg        [WIDTH-1:0]   s_zh_pos; // Przechowuje pozycję (indeks) zera znalezionego w wektorze s_ab
    integer                  i;        // Zmienna iteracyjna dla pętli 'for' (rozwijanych w sprzęt podczas syntezy)

    // =========================================================================
    // BLOK LOGIKI KOMBINACYJNEJ (always @(*) reaguje na zmianę dowolnego wejścia)
    // =========================================================================
    always @(*) begin
        // 1. Inicjalizacja wartościami domyślnymi na samym początku bloku.
        // BARDZO WAŻNE NA OBRONĘ: Przypisanie wartości domyślnych na początku always @(*)
        // zapobiega powstawaniu niechcianych zatrzasków (tzw. inferred latches) podczas syntezy!
        s_result = {WIDTH{1'b0}};       // Operator replikacji: tworzy 8 bitów wypełnionych zerami (8'b00000000)
        s_ab     = {i_arg0, i_arg1};    // Konkatenacja: bity [15:8] to i_arg0, a bity [7:0] to i_arg1
        s_ext    = {(WIDTH+1){1'b0}};   // Wyzerowanie 9-bitowego wektora pomocniczego
        s_flag_O = 1'b0;
        s_flag_C = 1'b0;
        s_flag_Z = 1'b0;
        s_flag_N = 1'b0;
        s_flag_E = 1'b0;                // Zakładamy brak błędu Zero-Hot na starcie
        s_flag_T = 1'b1;                // Zakładamy, że wektor JEST poprawnym kodem termometrowym (szukamy kontrprzykładu)
        s_was0   = 1'b0;
        s_stop   = 1'b0;
        s_zh_pos = {WIDTH{1'b0}};

        // 2. Dekoder Zero-Hot oraz wyznaczanie flagi E (Error) dla 16-bitowego wektora s_ab = {i_arg0, i_arg1}.
        // Kod Zero-Hot jest poprawny wtedy i tylko wtedy, gdy w całym 16-bitowym wektorze znajduje się
        // DOKŁADNIE JEDNO zero (np. 11111111_11110111).
        for (i = 0; i < 2*WIDTH; i = i + 1) begin
            if (s_ab[i] == 1'b0) begin      // Jeśli badany bit 'i' jest zerem:
                if (s_was0 == 1'b1)         // Sprawdzamy, czy wcześniej widzieliśmy już inne zero.
                    s_flag_E = 1'b1;        // Jeśli tak -> w wektorze są co najmniej dwa zera -> BŁĄD (E = 1)!
                else begin
                    s_was0   = 1'b1;        // To jest pierwsze znalezione zero -> zapamiętujemy ten fakt
                    s_zh_pos = i;           // i zapisujemy jego pozycję (indeks 'i') jako wynik dekodera.
                end
            end
        end
        // Jeśli po przejściu całej pętli nie znaleziono ani jednego zera (same jedynki: 1111...1111),
        // to również nie jest to kod Zero-Hot -> ustawiamy flagę błędu E = 1.
        if (s_was0 == 1'b0)
            s_flag_E = 1'b1;

        // 3. Sprawdzanie flagi T (kod termometrowy wektora s_ab = {i_arg0, i_arg1}).
        // Poprawny kod termometrowy ma na dole (od LSB, bit 0) ciąg jedynek, a powyżej nich ciąg zer
        // (np. 00000000_00011111, dopuszczalne są też same zera lub same jedynki).
        // Błąd w kodzie termometrowym występuje wtedy, gdy po zerze (na bicie i) pojawia się jedynka
        // na bicie bardziej znaczącym (i+1), czyli wzorzec "...10...".
        for (i = 0; i < 2*WIDTH - 1; i = i + 1) begin
            if (s_ab[i] == 1'b0 && s_ab[i+1] == 1'b1)
                s_flag_T = 1'b0; // Znaleziono przejście z 0 na 1 w stronę MSB -> to NIE jest kod termometrowy
        end

        // 4. Wybór właściwej operacji ALU na podstawie kodu i_oper:
        case (i_oper)
            OP_AND: begin
                s_result = i_arg0 & i_arg1; // Bitowe AND na odpowiadających sobie bitach
            end
            OP_OR: begin
                s_result = i_arg0 | i_arg1; // Bitowe OR
            end
            OP_XOR: begin
                s_result = i_arg0 ^ i_arg1; // Bitowe XOR
            end
            OP_SUB: begin
                // Doklejamy z przodu bit 1'b0, co w Verilogu zamienia operację na 9-bitową BEZ ZNAKU (unsigned).
                // Dzięki temu 9-ty bit (s_ext[WIDTH], czyli bit nr 8) przechwytuje pożyczkę (Borrow / Carry).
                s_ext    = {1'b0, i_arg0} - {1'b0, i_arg1};
                s_result = i_arg0 - i_arg1; // Właściwe odejmowanie 8-bitowe
                s_flag_C = s_ext[WIDTH];    // Flaga C = 1, gdy od mniejszej liczby bez znaku odejmujemy większą
                
                // Flaga przepełnienia ze znakiem (Overflow - O) przy odejmowaniu (A - B):
                // Nadmiar w kodzie U2 przy odejmowaniu zachodzi TYLKO wtedy, gdy argumenty mają RÓŻNE znaki
                // (np. dodatnia minus ujemna albo ujemna minus dodatnia), a znak wyniku wyszedł inny niż znak A.
                s_flag_O = (i_arg0[WIDTH-1] != i_arg1[WIDTH-1]) && (s_result[WIDTH-1] != i_arg0[WIDTH-1]);
            end
            OP_ADD: begin
                // Analogicznie: rozszerzenie o '0' z przodu pozwala złapać przeniesienie z najstarszego bitu (Carry)
                // na bicie s_ext[WIDTH] (bit nr 8).
                s_ext    = {1'b0, i_arg0} + {1'b0, i_arg1};
                s_result = i_arg0 + i_arg1;
                s_flag_C = s_ext[WIDTH];
                
                // Flaga przepełnienia ze znakiem (Overflow - O) przy dodawaniu (A + B):
                // Nadmiar w U2 przy dodawaniu zachodzi TYLKO wtedy, gdy oba argumenty mają TEN SAM znak
                // (dwie dodatnie lub dwie ujemne), a wynik ma znak przeciwny do nich.
                s_flag_O = (i_arg0[WIDTH-1] == i_arg1[WIDTH-1]) && (s_result[WIDTH-1] != i_arg0[WIDTH-1]);
            end
            OP_SHL: begin
                // Przesunięcie logiczne (wprowadza zera na zwalniane pozycje z obu stron).
                // Kierunek zależy od znaku drugiego argumentu (i_arg1):
                if (i_arg1 > 0)
                    s_result = i_arg0 << i_arg1;      // Dodatni i_arg1 -> przesunięcie w lewo o i_arg1 bitów
                else if (i_arg1 < 0)
                    s_result = i_arg0 >> (-i_arg1);   // Ujemny i_arg1 -> przesunięcie w prawo o wartość bezwzględną (-i_arg1)
                else
                    s_result = i_arg0;                // Gdy i_arg1 == 0 -> brak przesunięcia
            end
            OP_SHA: begin
                // Przesunięcie arytmetyczne (operatory <<< oraz >>>).
                // Przy przesunięciu w lewo (<<<) działa identycznie jak logiczne (wsuwa zera od prawej).
                // Przy przesunięciu w prawo (>>>) powiela najstarszy bit (bit znaku i_arg0[7]) od lewej strony,
                // dzięki czemu zachowuje znak liczby ujemnej w kodzie U2!
                if (i_arg1 > 0)
                    s_result = i_arg0 <<< i_arg1;
                else if (i_arg1 < 0)
                    s_result = i_arg0 >>> (-i_arg1);
                else
                    s_result = i_arg0;
            end
            OP_TONES: begin
                // Zliczanie nieprzerwanego ciągu jedynek od najmłodszego bitu (LSB, bit 0) w wektorze s_ab.
                s_result = {WIDTH{1'b0}};
                s_stop   = 1'b0;
                for (i = 0; i < 2*WIDTH; i = i + 1) begin
                    // Dopóki napotykamy jedynki i nie wystąpiło wcześniej żadne zero (s_stop == 0), zwiększamy licznik:
                    if (s_ab[i] == 1'b1 && s_stop == 1'b0)
                        s_result = s_result + 1'b1;
                    else
                        s_stop = 1'b1; // Pierwsze napotkane zero ustawia blokadę s_stop = 1 do końca pętli
                end
            end
            OP_ZHOT: begin
                // Przypisanie pozycji pierwszego zera obliczonej wcześniej w pętli dekodera Zero-Hot.
                s_result = s_zh_pos;
            end
            default: begin
                // Dla nieznanych kodów operacji (9..15) wynik jest zerowany.
                s_result = {WIDTH{1'b0}};
            end
        endcase

        // 5. Wyznaczenie flag globalnych zależnych od wyniku (Z oraz N) i złożenie wektora flag:
        // Operator '|s_result' to tzw. OR redukcji — wykonuje operację OR wszystkich 8 bitów wyniku ze sobą.
        // Daje 0 tylko wtedy, gdy wszystkie bity są zerami. Negacja '~' zamienia to na 1 (flaga Zero = 1).
        s_flag_Z = ~(|s_result);
        
        // Flaga N (Negative) to po prostu najstarszy bit wyniku (bit znaku w kodzie U2).
        s_flag_N = s_result[WIDTH-1];
        
        // Złożenie pojedynczych bitów w 6-bitową szynę wyjściową (od najstarszego bitu nr 5 do nr 0):
        s_flag   = {s_flag_O, s_flag_C, s_flag_Z, s_flag_N, s_flag_E, s_flag_T};
    end

    // =========================================================================
    // BLOK SEKWENCYJNY (Rejestry wyjściowe wyzwalane zboczem zegara)
    // =========================================================================
    // Lista czułości zawiera 'posedge i_clk' oraz 'negedge i_rstn' -> oznacza to przerzutniki D
    // z ASYNCHRONICZNYM resetem aktywnym stanem niskim (zerem).
    always @(posedge i_clk, negedge i_rstn) begin
        if (i_rstn == 1'b0) begin
            // Gdy reset jest aktywny (0), natychmiast zerujemy wyjścia niezależnie od zegara:
            o_result <= {WIDTH{1'b0}};
            o_flag   <= 6'b000000;
        end else begin
            // Na narastającym zboczu zegara przepisujemy obliczone kombinacyjnie wartości na wyjście.
            // Używamy przypisania nieblokującego (<=), co jest obowiązkową zasadą dla logiki sekwencyjnej.
            o_result <= s_result;
            o_flag   <= s_flag;
        end
    end

endmodule