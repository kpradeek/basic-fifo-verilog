module FIFO (
    input  wire        clk,
    input  wire        rst,
    input  wire        write_enable,
    input  wire        read_enable,
    input  wire [7:0]  din,
    output reg  [7:0]  dout,
    output reg         fifo_full,
    output reg         fifo_empty
);

    reg [7:0] memory [0:3];   
    reg [1:0] write_ptr;      
    reg [1:0] read_ptr;      
    reg [2:0] count;       

    always @(posedge clk) begin
        if (rst) begin
            write_ptr <= 0;
            read_ptr <= 0;
            count  <= 0;
            fifo_full   <= 0;
            fifo_empty  <= 1;
        end
        else begin
            if (write_enable && !fifo_full) begin
                memory[write_ptr] <= din;
                write_ptr <= write_ptr + 1;
                count <= count + 1;
            end

            if (read_enable && !fifo_empty) begin
                dout <= memory[read_ptr];
                read_ptr <= read_ptr + 1;
                count <= count - 1;
            end

            fifo_full  <= (count == 4);
            fifo_empty <= (count == 0);
        end
    end

endmodule