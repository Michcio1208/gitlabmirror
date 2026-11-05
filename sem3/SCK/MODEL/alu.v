// =============================================================================
// Plik: MODEL/alu.v
// Opis: Model RTL jednostki ALU (Zestaw nr 4) z rejestrowanymi wyjsciami.
// Zgodnosc z wykladami SCK:
// - Struktura dwublokowa (kombinacyjny + rejestrowy): Wyklad 3, str. 27, 30-31
// - Konstrukcje case, if-else, for: Wyklad 2, str. 11-28
// =============================================================================

module alu #(
    // Parametryzacja rozmiaru slowa (Wyklad 1, str. 30; Wyklad 2, str. 28).
    // JESLI CHCESZ ZMIENIC ROZMIAR ALU (np. na 16 bitow na obronie):
    // zmien ponizsze 8 na 16. Reszta kodu dostosuje sie automatycznie!
    parameter WIDTH = 8
) (
    input  wire                   i_clk,    // Zegar systemowy (aktywne zbocze narastajace)
    input  wire                   i_rstn,   // Asynchroniczny reset aktywny stanem niskim (0)
    input  wire signed [WIDTH-1:0] i_arg0,  // Argument wejsciowy A w kodzie U2 ze znakiem
    input  wire signed [WIDTH-1:0] i_arg1,  // Argument wejsciowy B w kodzie U2 ze znakiem
    input  wire        [3:0]       i_oper,  // Kod wybierajacy operacje (9 operacji -> 4 bity)
    output reg  signed [WIDTH-1:0] o_result,// Rejestrowane wyjscie wyniku Y (kod U2)
    output reg         [5:0]       o_flag   // Rejestrowane wyjscie flag: {O, C, Z, N, E, T}
);

    // -------------------------------------------------------------------------
    // Stale lokalne (localparam - Wyklad 2, str. 24; Wyklad 5, str. 29)
    // JESLI PROWADZACY POPROSI O ZMIANE KOLEJNOSCI OPERACJI:
    // wystarczy zmienic ponizsze numery przypisane do nazw OP_...
    // -------------------------------------------------------------------------
    localparam OP_AND   = 4'd0; // Y = A and B
    localparam OP_OR    = 4'd1; // Y = A or B
    localparam OP_XOR   = 4'd2; // Y = A xor B
    localparam OP_SUB   = 4'd3; // Y = A - B
    localparam OP_ADD   = 4'd4; // Y = A + B
    localparam OP_SHL   = 4'd5; // Y = A << >> B (przesuniecie logiczne)
    localparam OP_SHA   = 4'd6; // Y = A <<< >>> B (przesuniecie arytmetyczne)
    localparam OP_TONES = 4'd7; // Y = Liczba koncowych jedynek wektora {A,B} od LSB
    localparam OP_ZHOT  = 4'd8; // Y = Dekoder zero-hot wektora {A,B}

    // -------------------------------------------------------------------------
    // Sygnaly wewnetrzne (prefiks s_ zgodnie z konwencja z Wykladu 3, str. 27)
    // -------------------------------------------------------------------------
    reg signed [WIDTH-1:0]   s_result; // Wyjscie bloku kombinacyjnego dla wyniku
    reg        [5:0]         s_flag;   // Wyjscie bloku kombinacyjnego dla flag
    reg        [2*WIDTH-1:0] s_ab;     // Zlanczony 16-bitowy wektor {A, B}
    reg        [WIDTH:0]     s_ext;    // 9-bitowy wektor pomocniczy do wyznaczenia flagi Carry (C)

    // Pojedyncze bity flag wyznaczane w bloku kombinacyjnym:
    reg s_flag_O; // Przepelnienie (Overflow) w kodzie U2
    reg s_flag_C; // Przeniesienie (Carry)
    reg s_flag_Z; // Zero (gdy wynik == 0)
    reg s_flag_N; // Ujemne (Negative - gdy wynik < 0, czyli MSB == 1)
    reg s_flag_E; // Blad kodu zero-hot wektora {A,B}
    reg s_flag_T; // Kod temperaturowy (termometrowy) wektora {A,B}

    // Sygnaly pomocnicze do petli for (wzorzec z Wykladu 2, str. 25):
    reg            s_was0;   // Informuje, czy w petli znaleziono juz pierwsze zero
    reg            s_stop;   // Zatrzymuje zliczanie koncowych jedynek po pierwszym zerze
    reg [WIDTH-1:0] s_zh_pos;// Zapamietuje pozycje zera dla dekodera zero-hot
    integer        i;        // Zmienna iteracyjna petli for (Wyklad 2, str. 21-22)

    // =========================================================================
    // BLOK 1: LOGIKA KOMBINACYJNA (Wyklad 2, str. 7, 14, 27; Wyklad 3, str. 30)
    // Uzywamy wylacznie przypisan blokujacych (=).
    // =========================================================================
    always @(*) begin
        // 1. Przypisanie wartosci domyslnych WSZYSTKIM sygnalom sterowanym w bloku.
        // Chroni to przed niezamierzona generacja zatrzaskow (latchy) podczas
        // syntezy logicznej (Wyklad 2, str. 13-14, 27; Opis projektu, str. 2).
        s_result = {WIDTH{1'b0}};
        s_ab     = {i_arg0, i_arg1}; // Scalenie A (starsze bity 15:8) i B (mlodsze 7:0)
        s_ext    = {(WIDTH+1){1'b0}};
        s_flag_O = 1'b0;
        s_flag_C = 1'b0;
        s_flag_Z = 1'b0;
        s_flag_N = 1'b0;
        s_flag_E = 1'b0;
        s_flag_T = 1'b1; // Zakladamy poprawny kod termometrowy, szukamy kontrprzykladu
        s_was0   = 1'b0;
        s_stop   = 1'b0;
        s_zh_pos = {WIDTH{1'b0}};

        // ---------------------------------------------------------------------
        // 2. Dekoder ZERO-HOT oraz wyznaczenie flagi E dla wektora {A,B}
        // Adaptacja ukladu onehot2nkb_decoder z Wykladu 2, str. 25.
        // Kod zero-hot jest poprawny, gdy w 16-bitowym wektorze {A,B} dokladnie
        // JEDEN bit ma wartosc 0, a pozostale 15 bitow ma wartosc 1.
        // JESLI CHCESZ ZMIENIC NA ONE-HOT (Zestawy 1-3):
        // zmien warunek (s_ab[i] == 1'b0) na (s_ab[i] == 1'b1).
        // ---------------------------------------------------------------------
        for (i = 0; i < 2*WIDTH; i = i + 1) begin
            if (s_ab[i] == 1'b0) begin
                if (s_was0 == 1'b1) begin
                    // Znaleziono drugie (lub kolejne) zero -> blad kodu zero-hot!
                    s_flag_E = 1'b1;
                end else begin
                    // Znaleziono pierwsze zero -> zapamietaj fakt i numer bitu 'i'
                    s_was0   = 1'b1;
                    s_zh_pos = i;
                end
            end
        end
        // Jesli po przejsciu calego wektora nie bylo ani jednego zera (same 1):
        if (s_was0 == 1'b0)
            s_flag_E = 1'b1;

        // ---------------------------------------------------------------------
        // 3. Wyznaczenie flagi T (Kod temperaturowy / termometrowy wektora {A,B})
        // Prawidlowy kod termometrowy ma jedynki od LSB w gore, a potem zera
        // (np. 0000_0111). Niedozwolone jest przejscie z 0 na 1 idac od LSB do MSB.
        // ---------------------------------------------------------------------
        for (i = 0; i < 2*WIDTH - 1; i = i + 1) begin
            if (s_ab[i] == 1'b0 && s_ab[i+1] == 1'b1)
                s_flag_T = 1'b0;
        end

        // ---------------------------------------------------------------------
        // 4. Wybor operacji ALU za pomoca instrukcji case (Wyklad 2, str. 15-17)
        // ---------------------------------------------------------------------
        case (i_oper)
            // Operacja 0: Iloczyn bitowy AND (Wyklad 1, str. 18)
            OP_AND: begin
                s_result = i_arg0 & i_arg1;
            end

            // Operacja 1: Suma bitowa OR (Wyklad 1, str. 18)
            OP_OR: begin
                s_result = i_arg0 | i_arg1;
            end

            // Operacja 2: Suma wylaczna XOR (Wyklad 1, str. 18)
            OP_XOR: begin
                s_result = i_arg0 ^ i_arg1;
            end

            // Operacja 3: Odejmowanie A - B (Wyklad 1, str. 14)
            OP_SUB: begin
                // Obliczenie 9-bitowe bez znaku w celu wylapania bitu pozyczki/przeniesienia C
                s_ext    = {1'b0, i_arg0} - {1'b0, i_arg1};
                s_result = i_arg0 - i_arg1;
                s_flag_C = s_ext[WIDTH];
                // Przepelnienie U2 przy odejmowaniu: A i B maja rozne znaki, a wynik ma znak != A
                s_flag_O = (i_arg0[WIDTH-1] != i_arg1[WIDTH-1]) && (s_result[WIDTH-1] != i_arg0[WIDTH-1]);
            end

            // Operacja 4: Dodawanie A + B (Wyklad 1, str. 14)
            OP_ADD: begin
                // Obliczenie 9-bitowe bez znaku w celu wylapania bitu przeniesienia C
                s_ext    = {1'b0, i_arg0} + {1'b0, i_arg1};
                s_result = i_arg0 + i_arg1;
                s_flag_C = s_ext[WIDTH];
                // Przepelnienie U2 przy dodawaniu: A i B maja ten sam znak, a wynik ma znak przeciwny
                s_flag_O = (i_arg0[WIDTH-1] == i_arg1[WIDTH-1]) && (s_result[WIDTH-1] != i_arg0[WIDTH-1]);
            end

            // Operacja 5: Przesuniecie logiczne A << >> B (uzupelniane zerami)
            // Jesli B > 0 -> w lewo o B; jesli B < 0 -> w prawo o -B; jesli B == 0 -> A
            OP_SHL: begin
                if (i_arg1 > 0)
                    s_result = i_arg0 << i_arg1;
                else if (i_arg1 < 0)
                    s_result = i_arg0 >> (-i_arg1);
                else
                    s_result = i_arg0;
            end

            // Operacja 6: Przesuniecie arytmetyczne A <<< >>> B
            // W prawo (>>>) powiela bit znaku i_arg0[7] ze wzgledu na typ 'signed'
            OP_SHA: begin
                if (i_arg1 > 0)
                    s_result = i_arg0 <<< i_arg1;
                else if (i_arg1 < 0)
                    s_result = i_arg0 >>> (-i_arg1);
                else
                    s_result = i_arg0;
            end

            // Operacja 7: Liczba koncowych jedynek wektora {A,B} (od LSB w strone MSB)
            // JESLI CHCESZ ZMIENIC NA LICZBE WIODACYCH ZER OD MSB (Zestawy 1-3):
            // zmien petle na: for (i = 2*WIDTH-1; i >= 0; i = i - 1) oraz warunek na (s_ab[i] == 1'b0)
            OP_TONES: begin
                s_result = {WIDTH{1'b0}};
                s_stop   = 1'b0;
                for (i = 0; i < 2*WIDTH; i = i + 1) begin
                    if (s_ab[i] == 1'b1 && s_stop == 1'b0)
                        s_result = s_result + 1'b1;
                    else
                        s_stop = 1'b1; // Pierwsze napotkane 0 blokuje dalsze zliczanie
                end
            end

            // Operacja 8: Dekoder zero-hot wektora {A,B}
            // Zwraca wyznaczona wczesniej pozycje zera s_zh_pos
            // (jesli chcesz, aby przy bledzie E=1 wynik wynosil zawsze 0,
            // mozesz wpisac: s_result = (s_flag_E) ? {WIDTH{1'b0}} : s_zh_pos;)
            OP_ZHOT: begin
                s_result = s_zh_pos;
            end

            // Galaz domyslna wymagana w ukladach kombinacyjnych (Wyklad 2, str. 16, 27)
            default: begin
                s_result = {WIDTH{1'b0}};
            end
        endcase

        // ---------------------------------------------------------------------
        // 5. Wyznaczenie flag uniwersalnych Z (Zero) i N (Negative) oraz
        // zlozenie wektora flag wyjsciowych s_flag[5:0]
        // ---------------------------------------------------------------------
        s_flag_Z = ~(|s_result);        // NOR redukcji: 1 gdy wszystkie bity s_result to 0 (Wyklad 2, str. 17)
        s_flag_N = s_result[WIDTH-1];   // Bit znaku wyniku w kodzie U2 (1 oznacza liczbe ujemna)
        s_flag   = {s_flag_O, s_flag_C, s_flag_Z, s_flag_N, s_flag_E, s_flag_T};
    end

    // =========================================================================
    // BLOK 2: REJESTRY WYJSCIOWE (Wyklad 3, str. 8, 27, 30; Opis projektu, str. 1-2)
    // Uzywamy wylacznie przypisan nieblokujacych (<=).
    // =========================================================================
    always @(posedge i_clk, negedge i_rstn) begin
        if (i_rstn == 1'b0) begin
            // Asynchroniczne zerowanie rejestrow poziomem niskim i_rstn
            o_result <= {WIDTH{1'b0}};
            o_flag   <= 6'b000000;
        end else begin
            // Synchroniczny zapis wyniku i flag na narastajacym zboczu zegara i_clk
            o_result <= s_result;
            o_flag   <= s_flag;
        end
    end

endmodule