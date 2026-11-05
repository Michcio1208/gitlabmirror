`timescale 1ns/1ps // Jednostka czasu 1ns, precyzja 1ps (Wyklad 4, str. 24)

// Makra preprocesora (Wyklad 4, str. 55) okreslajace liczbe cykli i okres zegara
`define SIM_CLOCK_CYCLES    100
`define CLOCK_PERIOD        10

module testbench;

    // Rozmiar argumentow wejsciowych i wyniku (8 bitow dla Zestawu nr 4)
    localparam DATA_WIDTH = 8;

    // Sygnaly zegara i resetu sterowane przez instancje global_signals
    wire s_clk, s_rstn;

    // POPRAWKA 1: Dodano 'signed', aby Verilog i GTKWave traktowaly wektory
    // jako liczby ze znakiem w kodzie U2 (Opis projektu, str. 1-2).
    wire signed [DATA_WIDTH-1 : 0] s_arg0, s_arg1, s_result;
    wire        [3 : 0]            s_oper;

    // POPRAWKA 2: Zmieniono rozmiar s_flag z [3:0] na [5:0], poniewaz Zestaw nr 4
    // wymaga 6 flag: {O, C, Z, N, E, T} (Zestaw operacji, str. 2; Opis projektu, str. 1).
    wire        [5 : 0]            s_flag;

    // Wektory pomocnicze odbierajace losowe bity z modulu random_vector
    wire signed [DATA_WIDTH-1 : 0] s_rand_arg0, s_rand_arg1;
    wire        [3 : 0]            s_rand_oper;

    // Opcjonalne podanie w t >= 1000ns dwoch przypadkow specjalnych (kod termometrowy
    // oraz kod zero-hot), aby na wykresie w GTKWave zmienily stan takze flagi T oraz E:
    assign s_arg0 = ($time == 1001) ? 8'sb00000000 :
                    ($time == 1011) ? 8'sb11111111 : s_rand_arg0;
    assign s_arg1 = ($time == 1001) ? 8'sb00011111 :
                    ($time == 1011) ? 8'sb11110111 : s_rand_arg1;
    assign s_oper = ($time == 1001) ? 4'd7 :
                    ($time == 1011) ? 4'd8 : s_rand_oper;

    // Instancja testowanego modulu ALU (Wyklad 1, str. 29; Wyklad 4, str. 40)
    alu u_alu (
        .i_clk    (s_clk),
        .i_rstn   (s_rstn),
        .i_arg0   (s_arg0),
        .i_arg1   (s_arg1),
        .i_oper   (s_oper),
        .o_result (s_result),
        .o_flag   (s_flag)
    );

    // POPRAWKA 3: Rozbudowa bloku monitorujacego (Wyklad 4, str. 40, 44)
    // UWAGA: Poniewaz wyjscia o_result i o_flag sa rejestrowane na narastajacym
    // zboczu zegara s_clk (Wyklad 3, str. 27), dodajemy #1 po @(posedge s_clk),
    // aby $display wypisal NOWY wynik z rejestru obliczony dla biezacych wejsc!
    always @(posedge s_clk) begin
        #1;
        case (s_oper)
            4'd0: $display("t=%0t | op=0 (AND)   | A=%4d (0x%2h) | B=%4d (0x%2h) | Y=%4d (0x%2h) | Flagi(OCZNET)=%6b", $time, s_arg0, s_arg0, s_arg1, s_arg1, s_result, s_result, s_flag);
            4'd1: $display("t=%0t | op=1 (OR)    | A=%4d (0x%2h) | B=%4d (0x%2h) | Y=%4d (0x%2h) | Flagi(OCZNET)=%6b", $time, s_arg0, s_arg0, s_arg1, s_arg1, s_result, s_result, s_flag);
            4'd2: $display("t=%0t | op=2 (XOR)   | A=%4d (0x%2h) | B=%4d (0x%2h) | Y=%4d (0x%2h) | Flagi(OCZNET)=%6b", $time, s_arg0, s_arg0, s_arg1, s_arg1, s_result, s_result, s_flag);
            4'd3: $display("t=%0t | op=3 (SUB)   | A=%4d (0x%2h) | B=%4d (0x%2h) | Y=%4d (0x%2h) | Flagi(OCZNET)=%6b", $time, s_arg0, s_arg0, s_arg1, s_arg1, s_result, s_result, s_flag);
            4'd4: $display("t=%0t | op=4 (ADD)   | A=%4d (0x%2h) | B=%4d (0x%2h) | Y=%4d (0x%2h) | Flagi(OCZNET)=%6b", $time, s_arg0, s_arg0, s_arg1, s_arg1, s_result, s_result, s_flag);
            4'd5: $display("t=%0t | op=5 (SHL)   | A=%4d (0x%2h) | B=%4d (0x%2h) | Y=%4d (0x%2h) | Flagi(OCZNET)=%6b", $time, s_arg0, s_arg0, s_arg1, s_arg1, s_result, s_result, s_flag);
            4'd6: $display("t=%0t | op=6 (SHA)   | A=%4d (0x%2h) | B=%4d (0x%2h) | Y=%4d (0x%2h) | Flagi(OCZNET)=%6b", $time, s_arg0, s_arg0, s_arg1, s_arg1, s_result, s_result, s_flag);
            4'd7: $display("t=%0t | op=7 (TONES) | A=%4d (0x%2h) | B=%4d (0x%2h) | Y=%4d (0x%2h) | Flagi(OCZNET)=%6b", $time, s_arg0, s_arg0, s_arg1, s_arg1, s_result, s_result, s_flag);
            4'd8: $display("t=%0t | op=8 (ZHOT)  | A=%4d (0x%2h) | B=%4d (0x%2h) | Y=%4d (0x%2h) | Flagi(OCZNET)=%6b", $time, s_arg0, s_arg0, s_arg1, s_arg1, s_result, s_result, s_flag);
            default: $display("t=%0t | op=%0d (DEF)  | A=%4d (0x%2h) | B=%4d (0x%2h) | Y=%4d (0x%2h) | Flagi(OCZNET)=%6b", $time, s_oper, s_arg0, s_arg0, s_arg1, s_arg1, s_result, s_result, s_flag);
        endcase
    end

    // Instancja generatora zegara, resetu i zapisu do pliku waves.vcd
    global_signals #(
        .SIM_CLOCK_CYCLES(`SIM_CLOCK_CYCLES),
        .CLOCK_PERIOD(`CLOCK_PERIOD)
    ) u_rst_clk_generator (
        .o_CLK  (s_clk),
        .o_RSTn (s_rstn)
    );

    // Instancja generatora 20-bitowego wektora losowego: {8b arg0, 8b arg1, 4b oper}
    random_vector #(
        .WIDTH(2*DATA_WIDTH + 4)
    ) u_random_vector_arg0 (
        .i_CLK  (s_clk),
        .i_RSTn (s_rstn),
        .o_Y    ({s_rand_arg0, s_rand_arg1, s_rand_oper})
    );

endmodule