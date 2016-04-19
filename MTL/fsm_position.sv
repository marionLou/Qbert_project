module fsm_position(
	input logic clk,
	input logic reset,
	input logic [10:0] x_cnt,
	input logic [9:0] y_cnt,
	input logic [20:0] xy_offset,
	input logic done_move,
	input logic jump,
	
	output logic pos
	
);
typedef enum logic {IDLE, UPDATE} state_t;
	state_t pos_state;
	
always_ff @(posedge clk) begin
	case(pos_state)
	IDLE : 
	UPDATE:
	endcase
end

endmodule