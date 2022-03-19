`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/04/11 18:22:21
// Design Name: 
// Module Name: pic1_dispaly
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////

module pic1_display(
	input                       rst_n,   
	input                       pclk,

	output                      o_region_active,   
	output                      o_ram_addr_rst,   
	input[7:0]                  i_region_data,    
	input                       i_hs,    
	input                       i_vs,    
	input                       i_de,	
	input[23:0]                 i_data,  
	output                      o_hs,    
	output                      o_vs,    
	output                      o_de,    
	output[23:0]                o_data
);
parameter OSD_WIDTH   =  12'd32;
parameter OSD_HEGIHT  =  12'd32;

wire[11:0] pos_x;
wire[11:0] pos_y;
wire       pos_hs;
wire       pos_vs;
wire       pos_de;
wire[23:0] pos_data;
reg[23:0]  v_data;

reg        region_active;
reg        region_active_d0;
reg        region_active_d1;
reg        region_active_d2;

reg        pos_vs_d0;
reg        pos_vs_d1;
reg        ram_addr_rst;


assign o_region_active = region_active;
assign o_ram_addr_rst = ram_addr_rst;

assign o_data = v_data;
assign o_hs = pos_hs;
assign o_vs = pos_vs;
assign o_de = pos_de;
//delay 1 clock 
//always@(posedge pclk)
//begin
//	if(pos_y >= 12'd318 && pos_y <= 12'd318 + OSD_HEGIHT - 12'd1 && pos_x >= 12'd10 && pos_x  <= 12'd10 + OSD_WIDTH - 12'd1)
//		region_active <= 1'b1;
//	else
//		region_active <= 1'b0;
//end

always@(posedge pclk)
begin
	if(pos_y >= 12'd330 && pos_y <= 12'd330 + OSD_HEGIHT - 12'd1 && pos_x >= 12'd160 && pos_x  <= 12'd160 + OSD_WIDTH - 12'd1)   //    166   314
		region_active <= 1'b1;
	else
		region_active <= 1'b0;
end




always@(posedge pclk)
begin
	region_active_d0 <= region_active;
	region_active_d1 <= region_active_d0;
	region_active_d2 <= region_active_d1;
end

always@(posedge pclk)
begin
	pos_vs_d0 <= pos_vs;
	pos_vs_d1 <= pos_vs_d0;
end

//delay 2 clock
//region_active_d0

always@(posedge pclk)
begin
	if(pos_vs_d1 == 1'b1 && pos_vs_d0 == 1'b0)
		ram_addr_rst <= 1'b1;
	else 
		ram_addr_rst <= 1'b0;
end


always@(posedge pclk)
begin
	if(region_active_d0 == 1'b1)       //active dly0 =  vld
        v_data <= {i_region_data,i_region_data,i_region_data};
	else
		v_data <= pos_data;
end

timing_gen_xy timing_gen_xy_m0(
	.rst_n    (rst_n    ),
	.clk      (pclk     ),
	.i_hs     (i_hs     ),
	.i_vs     (i_vs     ),
	.i_de     (i_de     ),
	.i_data   (i_data   ),
	.o_hs     (pos_hs   ),
	.o_vs     (pos_vs   ),
	.o_de     (pos_de   ),
	.o_data   (pos_data ),
	.x        (pos_x    ),
	.y        (pos_y    )
);
endmodule
