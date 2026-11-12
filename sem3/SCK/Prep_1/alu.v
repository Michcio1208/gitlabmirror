module alu #(
    parameter WIDTH = 8
) (
    input  wire                   i_clk,
    input  wire                   i_rstn,
    input  wire signed [WIDTH-1:0] i_arg0,
    input  wire signed [WIDTH-1:0] i_arg1,
    input  wire        [3:0]       i_oper,
    output reg  signed [WIDTH-1:0] o_result,
    output reg         [5:0]       o_flag
);

    localparam OP_AND   = 4'd0;
    localparam OP_OR    = 4'd1;
    localparam OP_XOR   = 4'd2;
    localparam OP_SUB   = 4'd3;
    localparam OP_ADD   = 4'd4;
    localparam OP_SHL   = 4'd5;
    localparam OP_SHA   = 4'd6;
    localparam OP_TONES = 4'd7;
    localparam OP_ZHOT  = 4'd8;

    reg signed [WIDTH-1:0]   s_result;
    reg        [5:0]         s_flag;
    reg        [2*WIDTH-1:0] s_ab;
    reg        [WIDTH:0]     s_ext;
    reg                      s_flag_O, s_flag_C, s_flag_Z, s_flag_N, s_flag_E, s_flag_T;
    reg                      s_was0, s_stop;
    reg        [WIDTH-1:0]   s_zh_pos;
    integer                  i;

    // Blok logiki kombinacyjnej
    always @(*) begin
        s_result = {WIDTH{1'b0}};
        s_ab     = {i_arg0, i_arg1};
        s_ext    = {(WIDTH+1){1'b0}};
        s_flag_O = 1'b0;
        s_flag_C = 1'b0;
        s_flag_Z = 1'b0;
        s_flag_N = 1'b0;
        s_flag_E = 1'b0;
        s_flag_T = 1'b1;
        s_was0   = 1'b0;
        s_stop   = 1'b0;
        s_zh_pos = {WIDTH{1'b0}};

        // Dekoder zero-hot oraz flaga E dla wektora {A,B}
        for (i = 0; i < 2*WIDTH; i = i + 1) begin
            if (s_ab[i] == 1'b0) begin
                if (s_was0 == 1'b1)
                    s_flag_E = 1'b1;
                else begin
                    s_was0   = 1'b1;
                    s_zh_pos = i;
                end
            end
        end
        if (s_was0 == 1'b0)
            s_flag_E = 1'b1;

        // Flaga T (kod termometrowy wektora {A,B})
        for (i = 0; i < 2*WIDTH - 1; i = i + 1) begin
            if (s_ab[i] == 1'b0 && s_ab[i+1] == 1'b1)
                s_flag_T = 1'b0;
        end

        // Wybor operacji ALU 
        case (i_oper)
            OP_AND: begin
                s_result = i_arg0 & i_arg1;
            end
            OP_OR: begin
                s_result = i_arg0 | i_arg1;
            end
            OP_XOR: begin
                s_result = i_arg0 ^ i_arg1;
            end
            OP_SUB: begin
                s_ext    = {1'b0, i_arg0} - {1'b0, i_arg1};
                s_result = i_arg0 - i_arg1;
                s_flag_C = s_ext[WIDTH];
                s_flag_O = (i_arg0[WIDTH-1] != i_arg1[WIDTH-1]) && (s_result[WIDTH-1] != i_arg0[WIDTH-1]);
            end
            OP_ADD: begin
                s_ext    = {1'b0, i_arg0} + {1'b0, i_arg1};
                s_result = i_arg0 + i_arg1;
                s_flag_C = s_ext[WIDTH];
                s_flag_O = (i_arg0[WIDTH-1] == i_arg1[WIDTH-1]) && (s_result[WIDTH-1] != i_arg0[WIDTH-1]);
            end
            OP_SHL: begin
                if (i_arg1 > 0)
                    s_result = i_arg0 << i_arg1;
                else if (i_arg1 < 0)
                    s_result = i_arg0 >> (-i_arg1);
                else
                    s_result = i_arg0;
            end
            OP_SHA: begin
                if (i_arg1 > 0)
                    s_result = i_arg0 <<< i_arg1;
                else if (i_arg1 < 0)
                    s_result = i_arg0 >>> (-i_arg1);
                else
                    s_result = i_arg0;
            end
            OP_TONES: begin
                s_result = {WIDTH{1'b0}};
                s_stop   = 1'b0;
                for (i = 0; i < 2*WIDTH; i = i + 1) begin
                    if (s_ab[i] == 1'b1 && s_stop == 1'b0)
                        s_result = s_result + 1'b1;
                    else
                        s_stop = 1'b1;
                end
            end
            OP_ZHOT: begin
                s_result = s_zh_pos;
            end
            default: begin
                s_result = {WIDTH{1'b0}};
            end
        endcase

        s_flag_Z = ~(|s_result);
        s_flag_N = s_result[WIDTH-1];
        s_flag   = {s_flag_O, s_flag_C, s_flag_Z, s_flag_N, s_flag_E, s_flag_T};
    end

    // Blok rejestrow wyjsciowych
    always @(posedge i_clk, negedge i_rstn) begin
        if (i_rstn == 1'b0) begin
            o_result <= {WIDTH{1'b0}};
            o_flag   <= 6'b000000;
        end else begin
            o_result <= s_result;
            o_flag   <= s_flag;
        end
    end

endmodule