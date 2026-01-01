module cpu6 (
    input  clk,
    output [5:0] acc_out
);

    // ---------------- Clock divider (SIM friendly) ----------------
    reg [7:0] div;
    reg tick_d;

    initial begin
        div    = 0;
        tick_d = 0;
    end

    always @(posedge clk) begin
        div    <= div + 1'b1;
        tick_d <= div[3];
    end

    wire tick = div[3] & ~tick_d;   // pulse every ~16 clocks

    // ---------------- CPU registers ----------------
    reg [5:0] acc;
    reg [2:0] pc;
    reg [5:0] instr;
    reg zf;

    // ---------------- Instruction decode ----------------
    wire [2:0] opcode  = instr[5:3];
    wire [2:0] operand = instr[2:0];

    // ---------------- Instruction memory ----------------
    reg [5:0] imem [0:7];
    initial begin
        imem[0] = 6'b001_001; // LDI 1
        imem[1] = 6'b100_000; // ADD 0
        imem[2] = 6'b011_000; // STM 0
        imem[3] = 6'b110_001; // JMP 1
        imem[4] = 6'b000_000;
        imem[5] = 6'b000_000;
        imem[6] = 6'b000_000;
        imem[7] = 6'b000_000;
    end

    // ---------------- Data memory ----------------
    reg [5:0] dmem [0:7];
    initial begin
        dmem[0] = 6'd1;
    end

    // ---------------- FSM ----------------
    reg state;
    localparam FETCH = 1'b0,
               EXEC  = 1'b1;

    initial begin
        acc   = 0;
        pc    = 0;
        zf    = 0;
        state = FETCH;
    end

    always @(posedge clk) begin
        if (tick) begin
            case (state)
                FETCH: begin
                    instr <= imem[pc];
                    state <= EXEC;
                end

                EXEC: begin
                    case (opcode)
                        3'b001: acc <= operand;               // LDI
                        3'b010: acc <= dmem[operand];         // LDM
                        3'b011: dmem[operand] <= acc;         // STM
                        3'b100: acc <= acc + dmem[operand];   // ADD
                        3'b101: acc <= acc - dmem[operand];   // SUB
                        3'b110: pc  <= operand;               // JMP
                        3'b111: if (zf) pc <= operand;        // JZ
                        default: ;
                    endcase

                    zf <= (acc == 0);

                    if (opcode < 3'b110)
                        pc <= pc + 1'b1;

                    state <= FETCH;
                end
            endcase
        end
    end

    assign acc_out = ~acc;

endmodule
