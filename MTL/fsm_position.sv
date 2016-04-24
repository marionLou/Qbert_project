module fsm_position(
	input logic clk,
	input logic reset,
	input logic [10:0] x_cnt,
	input logic [9:0] y_cnt,
	input logic [20:0] xy_offset,
	input logic done_move_qb,
	input logic jump,
	input logic [27:0] position_qb,
	output logic [27:0] dff_position	
);
typedef enum logic {IDLE, UPDATE} state_t;
	state_t pos_state;
	
always_ff @(posedge clk) begin
	case(pos_state)
	IDLE : if(!done_move_qb) pos_state <= UPDATE;
	UPDATE	: 	if(done_move_qb) begin 
					dff_position <= position_qb;
					pos_state <= IDLE;
				end
	endcase
end

endmodule