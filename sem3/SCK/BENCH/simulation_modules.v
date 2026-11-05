`timescale 1ns/1ps

/* Modul symulacyjny do
    - generacji sygnalow globalnych RST i CLK
    - zapisywania wynikow symulacji 
    - konczenia symulacji po liczbie cykli 
*/
module global_signals 
    #(
        parameter SIM_CLOCK_CYCLES  = 120,
        parameter CLOCK_PERIOD      = 10,
        parameter SIGNAL_VCD_FILE   = "waves.vcd"
    )
    (
        output wire o_CLK,
        output wire o_RSTn
    );
        
        reg clk;
        reg rst_n;

        assign o_CLK = clk;
        assign o_RSTn = rst_n;

        localparam CLK_PERIOD = CLOCK_PERIOD;
        always #(CLK_PERIOD/2) 
            clk=~clk;

        initial begin
            $dumpfile(SIGNAL_VCD_FILE);
            $dumpvars(0, testbench);
        end

        initial begin
            #1;
            rst_n<=1'bx; clk<=1'bx;
            
            #(CLK_PERIOD*3) rst_n<=1;
            
            #(CLK_PERIOD*3) rst_n<=0;clk<=0;
            
            repeat(5) 
                @(posedge clk);
            
            rst_n<=1;
            @(posedge clk);

            repeat(SIM_CLOCK_CYCLES) 
                @(posedge clk);

            $finish;
        end
endmodule

/*
    Modul generacji losowych wartosci sygnalu wielobitowego
*/
module random_vector
    #(
        parameter WIDTH = 9
    ) 
    (
        input  wire i_CLK,
        input  wire i_RSTn,

        output reg [WIDTH-1 : 0] o_Y
    );
        integer SEED = 100;
        reg     s_was_valid;

        initial 
        begin
            #1;
            @(posedge i_RSTn);

            o_Y         <= {WIDTH{1'b0}};

            forever 
            begin
                @(posedge i_CLK)
                begin
                    {o_Y} <= {o_Y, $random(SEED)};
                end
            end
        end
endmodule
