module  Gameover_game (
	input logic clk,
	input logic reset,
	input logic [10:0] x_cnt,
	input logic [9:0] y_cnt,
	input logic e_piece,
	input logic mode_arcade,
	output logic [23:0] gameover_RGB
);

parameter logic [23:0] background_RGB = {8'd255,8'd255,8'd128};
parameter logic [23:0] ZP1_RGB = {8'd174,8'd87,8'd0};
parameter logic [23:0] ZP2_RGB = {8'd224,8'd196,8'd31};

logic zone_piece_1, zone_piece_2, zone_piece_3;
logic [31:0] count = 32'd0;
logic add_piece = 1'd0;

always_ff @(posedge clk) begin

zone_piece_1 <= {(x_cnt >= 11'd200 && x_cnt <= 11'd600)
				&&(y_cnt >= 10'd150 && y_cnt <= 10'd350)};
				
zone_piece_2 <= {(x_cnt >= 11'd220 && x_cnt <= 11'd580)
				&&(y_cnt >= 10'd170 && y_cnt <= 10'd330)};
				
zone_piece_3 <= {(x_cnt >= 11'd350 && x_cnt <= 11'd450)
				&& (y_cnt >= 10'd230 && y_cnt <= 10'd270)};
	
	if(e_piece) add_piece <= 1'd1;
	
	if(add_piece) begin
		if(count == 32'd8000000) begin
			count <= 1'b0;
			add_piece <= 1'd0;
		end
		else count <= count + 1'b1;
	end
	
	if (add_piece & mode_arcade) begin 
		if(zone_piece_3)
			gameover_RGB <= ZP1_RGB;
		else if(zone_piece_2)
			gameover_RGB <= ZP2_RGB;
		else if(zone_piece_1)
			gameover_RGB <= ZP1_RGB;
		else gameover_RGB <= background_RGB;
	end
	else gameover_RGB <= background_RGB;
end
endmodule