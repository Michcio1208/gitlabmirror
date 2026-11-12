// Dyrektywa kompilatora określająca jednostkę czasu (1 ns) oraz precyzję symulacji (1 ps).
// Oznacza to, że np. opóźnienie #10 w kodzie będzie trwało dokładnie 10 nanosekund.
`timescale 1ns/1ps

// Makra preprocesora (stałe globalne kompilacji):
`define SIM_CLOCK_CYCLES    100 // Liczba taktów zegara, przez jaką ma działać symulacja (100 cykli)
`define CLOCK_PERIOD        10  // Okres zegara w jednostkach timescale, czyli 10 ns (częstotliwość 100 MHz)

// Deklaracja głównego modułu testowego. Testbench nie posiada portów wejścia/wyjścia,
// ponieważ jest najwyższą warstwą symulacji (tzw. top-level) — sam generuje i odbiera sygnały.
module testbench;

    // Stała lokalna określająca szerokość szyny danych (8 bitów).
    // Ułatwia zmianę rozmiaru całego układu w jednym miejscu.
    localparam DATA_WIDTH = 8;

    // Deklaracja przewodów (wire) łączących podmoduły:
    wire                    s_clk, s_rstn; // Zegar (s_clk) i reset aktywny stanem niskim (s_rstn)
    
    // Szyny danych ze znakiem (signed - kod U2) o szerokości 8 bitów (indeksy od 7 do 0):
    // s_arg0, s_arg1 to argumenty trafiające bezpośrednio do ALU, a s_result to wynik z ALU.
    wire signed [DATA_WIDTH-1 : 0] s_arg0, s_arg1, s_result;
    
    // 4-bitowy kod operacji (pozwala zakodować do 16 operacji, od 0 do 15).
    wire [3 : 0]            s_oper;
    
    // 6-bitowy wektor flag wyjściowych z ALU: {O, C, Z, N, E, T}.
    wire [5 : 0]            s_flag;

    // Sygnały pomocnicze odbierające "surowe" dane pseudolosowe z modułu random_vector.
    // Zanim trafią do ALU, mogą zostać podmienione przez multipleksery poniżej.
    wire signed [DATA_WIDTH-1 : 0] r_arg0, r_arg1;
    wire [3 : 0]                   r_oper;

    // =========================================================================
    // WYMUSZENIE PRZYPADKÓW SZCZEGÓLNYCH (Multipleksery czasowe - operator ? :)
    // Dlaczego to tu jest? W 16-bitowym wektorze {arg0, arg1} szansa na wylosowanie
    // poprawnego kodu Zero-Hot (tylko jedno zero) wynosi 16/65536 (0,024%), a kodu
    // termometrowego 17/65536 (0,026%). W 100 losowych taktach prawie na pewno
    // byśmy ich nie trafili! Dlatego w dwóch oknach czasowych podmienia się losowe
    // dane na wartości wpisane na sztywno, aby udowodnić działanie flag E i T.
    // =========================================================================

    // Okno 1 (od 156 ns do 165 ns): Wymuszenie dla testu Zero-Hot (OP_ZHOT = 8).
    //   s_arg0 = 8'sb11111111 (-1 w U2), s_arg1 = 8'sb11110111 (-9 w U2).
    //   Złączony wektor {s_arg0, s_arg1} to 16'b11111111_11110111 — ma dokładnie JEDNO zero
    //   na pozycji nr 3 (licząc od 0 od prawej). Flaga błędu E wyniesie 0, a wynik to 3.
    // Okno 2 (od 166 ns do 175 ns): Wymuszenie dla testu kodu termometrowego (OP_TONES = 7).
    //   s_arg0 = 8'sb00000000 (0), s_arg1 = 8'sb00011111 (31).
    //   Złączony wektor {s_arg0, s_arg1} to 16'b00000000_00011111 — ma ciąg 5 jedynek od LSB,
    //   a dalej same zera. To poprawny kod termometrowy (flaga T = 1), a wynik OP_TONES to 5.
    // Poza tymi oknami czasowymi: do ALU trafiają sygnały losowe (r_arg0, r_arg1, r_oper).
    assign s_arg0 = ($time >= 156 && $time < 166) ? 8'sb11111111 :
                    ($time >= 166 && $time < 176) ? 8'sb00000000 : r_arg0;

    assign s_arg1 = ($time >= 156 && $time < 166) ? 8'sb11110111 :
                    ($time >= 166 && $time < 176) ? 8'sb00011111 : r_arg1;

    assign s_oper = ($time >= 156 && $time < 166) ? 4'd8 :
                    ($time >= 166 && $time < 176) ? 4'd7 : r_oper;
 
    // Instancjonowanie (wstawienie) badanego modułu ALU pod nazwą u_alu.
    // Notacja z kropką (.port_modułu(sygnał_w_testbenchu)) łączy porty po nazwach.
    alu 
        u_alu
            (
                .i_clk(s_clk),       // Podłączenie zegara
                .i_rstn(s_rstn),     // Podłączenie resetu
                .i_arg0(s_arg0),     // Podłączenie pierwszego argumentu
                .i_arg1(s_arg1),     // Podłączenie drugiego argumentu
                .i_oper(s_oper),     // Podłączenie kodu operacji
                .o_result(s_result), // Odbiór wyniku z rejestru wyjściowego ALU
                .o_flag(s_flag)      // Odbiór flag z rejestru wyjściowego ALU
            );

    // Blok wykonywany przy każdym narastającym zboczu zegara (posedge s_clk).
    // Służy do wypisywania stanu symulacji w konsoli symulatora ($display).
    always @(posedge s_clk)
    begin
        case (s_oper)
            default:
                // Formatowanie: %0t (czas bez zbędnych spacji), %d (liczba dziesiętna), %b (binarnie).
                // Ponieważ s_arg0, s_arg1 i s_result są zadeklarowane jako 'signed', %d wypisze je ze znakiem.
                $display("t=%0t | oper=%d | arg0=%d | arg1=%d | result=%d | flag=%b", 
                         $time, s_oper, s_arg0, s_arg1, s_result, s_flag);
        endcase;
    end
            
    // Instancja zewnętrznego generatora zegara i resetu.
    // Przekazujemy mu parametry przez #(...) określające czas trwania symulacji i okres zegara.
    global_signals #(.SIM_CLOCK_CYCLES(`SIM_CLOCK_CYCLES), .CLOCK_PERIOD(`CLOCK_PERIOD))
        u_rst_clk_generator
            (.o_CLK(s_clk), .o_RSTn(s_rstn));

    // Instancja generatora liczb pseudolosowych (LFSR).
    // Szerokość wyjścia ustawiamy na 2*DATA_WIDTH + 4 = 2*8 + 4 = 20 bitów.
    // Wyjście o_Y rozbijamy za pomocą konkatenacji {r_arg0, r_arg1, r_oper} od razu na 3 osobne sygnały:
    // 8 bitów na r_arg0, 8 bitów na r_arg1 oraz 4 bity na r_oper (razem 20 bitów).
    random_vector #(.WIDTH(2*DATA_WIDTH + 4))
        u_random_vector_arg0
            (   .i_CLK(s_clk),
                .i_RSTn(s_rstn),
                .o_Y({r_arg0, r_arg1, r_oper})
            );
endmodule