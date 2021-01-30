`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/12/24 21:37:52
// Design Name: 
// Module Name: decode_top
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


module decode_top(
input         clk,
input         rst_n,
input  [7:0] data_in,
input        de_in,
output [7:0] data_out,
output        de_o

    );
    
    
    wire [23:0] data_out_pic;
    reg [15:0] de_cnt;
    reg de;
    
  always@(posedge clk,negedge rst_n)
    begin
      if(!rst_n)
        de<=1'b0;
      else if(de_cnt==16'd1023)
        de<=1'b0;
      else   
        de<=1'b1;
    end  
    
    always@(posedge clk,negedge rst_n)
      begin
        if(!rst_n)
          de_cnt<=16'd0;           
        else if(de_cnt==16'd1023)
          de_cnt<=de_cnt;  
        else if(de)
          de_cnt<=de_cnt+16'd1;             
      end
    
    
     
reg [4:0] cnt_ini;
reg [10:0] cnt_s;
reg  [4:0]cnt_d;    
reg       cnt_start;
  

always@(posedge clk or negedge rst_n)
  begin
    if(!rst_n)
      cnt_d<=5'd0;
   else if(cnt_start)  
     cnt_d<=cnt_d+5'd1;
     else 
     cnt_d<=cnt_d; 
  end  
always@(posedge clk or negedge rst_n)
  begin
    if(!rst_n)
    begin
      cnt_s<=11'd0;
      cnt_start<=1'b0;
      
    end  
     else if(cnt_d==5'd15||cnt_d==5'd16)
      begin
       cnt_s<=cnt_s;  
       cnt_start<=1'b0;
     end  
    else if(cnt_s==11'd400)
    begin
      cnt_s<=cnt_s;
      cnt_start<=1'b1;
    end  
  
    else   
    begin
      cnt_s<=cnt_s+11'd1;  
      cnt_start<=1'b0;
    end
  end  
  
always@(posedge clk or negedge rst_n)
 begin
     if(!rst_n)
       cnt_ini<=5'd0;
     else if(cnt_start&&cnt_ini==5'd16)
       cnt_ini<=5'd1;
     else if(cnt_start)  
       cnt_ini<=cnt_ini+5'd1;  
    else 
      cnt_ini<=5'd0;   
 end 
  reg cnt_start_dly1;
     
 always@(posedge clk or negedge rst_n)
   begin
       if(!rst_n)
         cnt_start_dly1<=4'd0;
     else 
         cnt_start_dly1<=cnt_start;  
   end 
  
 (*mark_debug="true"*) wire [7:0] data_o_4x4;
 (*mark_debug="true"*) wire de_o_4x4;
  assign de_o=de_o_4x4;
  assign data_out=data_o_4x4;
     
decode_4x4 u0_decode_4x4(    

.clk        (clk       ),
.rst_n      (rst_n     ),
.de         (cnt_start_dly1     ),
.data       ({4'd0,cnt_ini}  ),
.data_o     (data_o_4x4), 
.de_o       (de_o_4x4  )

);  
endmodule
