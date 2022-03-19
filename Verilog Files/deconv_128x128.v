`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/05/02 09:42:17
// Design Name: 
// Module Name: deconv
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


module deconv_128x128(
input clk,
input rst_n,
input de,
input signed [10:0]k1,
input signed [10:0]k2,
input signed [10:0]k3,
input signed [10:0]k4,
input signed [10:0]k5,
input signed [10:0]k6,
input signed [10:0]k7,
input signed [10:0]k8,
input signed [10:0]k9,
input signed [19:0] bias,
input signed [8:0]data_in,
output             de_o,
output signed [8:0]data
    );
 
 

 
 reg signed [8:0] data_in_dly1;
 wire signed [8:0] data_in_dly4;
 reg signed [8:0] data_in_dly5;
 reg [15:0]   cnt_src_c;
 reg [15:0]   cnt_src_l;
 reg signed [10:0]   kx1;
 reg signed [10:0]   kx2;
 reg signed [10:0]   kx3;
 reg signed [10:0]   kx4;
 reg signed [10:0]   ky1;
 reg signed [10:0]   ky2;
 reg signed [10:0]   kz1;
 reg signed [10:0]   kz2; 
 reg signed [10:0]   ko1; 
 reg de_dly1;
 reg de_dly2;
 reg de_dly3;
 reg de_dly4;
 reg de_dly5;
 //reg de_dly3_dly5;
 reg signed [20:0] x_s1;
 reg signed [20:0] x_s2;
 reg signed [21:0] x_s;
 reg signed [20:0] y_s;
 reg signed [20:0] z_s;
 reg signed [22:0] x_s_bias;
 reg signed [21:0] y_s_bias;
 reg signed [21:0] z_s_bias;
 reg signed [20:0] o_s_bias;
 reg signed [8:0] x_in;
 reg signed [8:0] y_in;
 reg signed [8:0] z_in;
 reg signed [8:0] o_in;
 reg [15:0] cnt_dst_c;
 reg [15:0] cnt_dst_l;
 reg        start_sign;
 reg        line1_v;
 reg        line2_v;
 reg        transfer;
 reg signed [8:0] data_out;
 reg              data_de;
 reg        x_r_dly1;
 reg        y_r_dly1;
 reg        z_r_dly1;
 reg        o_r_dly1; 
 wire        x_r;
 wire        y_r;
 wire        z_r;
 wire        o_r;
 wire [11:0] data_count;
 wire signed [8:0]  line1_data1;
 wire signed [8:0]  line1_data2;
 wire signed [8:0]  line2_data1;
 wire signed [8:0]  line2_data2;  
 //wire de_dly3_dly4;
 wire signed [19:0]   result_x1;
 wire signed [19:0]   result_x2;
 wire signed [19:0]   result_x3;
 wire signed [19:0]   result_x4; 
 wire signed [19:0]   result_y1;
 wire signed [19:0]   result_y2;
 wire signed [19:0]   result_z1;
 wire signed [19:0]   result_z2; 
 wire signed [19:0]   result_o1; 

 
 parameter cnt_col_src = 128;
 parameter cnt_line_src = 128;
 parameter cnt_col_dst = 256;
 parameter cnt_line_dst = 256; 

 assign data=data_out;
 assign de_o=data_de;
 
c_shift_ram_128x128 u0_c_shift_ram_128x128 (.D(data_in),.CLK(clk),.Q(data_in_dly4));
//c_shift_ram_4x4 u1_c_shift_ram_4x4 (.D(de_dly3),.CLK(clk),.Q(de_dly3_dly4)); 
 
 
 always@(posedge clk or negedge rst_n)
 begin
   if(!rst_n)
     data_in_dly1<=9'd0;
   else 
     data_in_dly1<=data_in;
 end
 
 always@(posedge clk or negedge rst_n)
 begin
   if(!rst_n)
     data_in_dly5<=9'd0;
   else 
     data_in_dly5<=data_in_dly4;  
 end   
 
 always@(posedge clk or negedge rst_n)
 begin 
   if(!rst_n)
     cnt_src_c<=16'd1;
   else if(de&&cnt_src_c==cnt_col_src) 
     cnt_src_c<=16'd1;
   else if(de) 
     cnt_src_c<=cnt_src_c+16'd1;
 end
 
 always@(posedge clk or negedge rst_n)
  begin 
    if(!rst_n)
      cnt_src_l<=16'd1;
    else if(de&&cnt_src_c==cnt_col_src&&cnt_src_l==cnt_col_src) 
      cnt_src_l<=16'd1;
    else if(de&&cnt_src_c==cnt_col_src) 
      cnt_src_l<=cnt_src_l+16'd1;
  end
 
 always@(*)
 begin
    case(cnt_src_l)
    
      1:  
        case (cnt_src_c)
           1:begin
             kx1<=k9;kx2<=0;kx3<=0;kx4<=0;ky1<=k8;ky2<=0;kz1<=k6;kz2<=0;ko1<=k5;                                  
             end           
           default:begin
             kx1<=k9;kx2<=k7;kx3<=0;kx4<=0;ky1<=k8;ky2<=0;kz1<=k6;kz2<=k4;ko1<=k5;
                   end                    
         endcase  
     default: case (cnt_src_c)
               1:begin
             kx1<=k9;kx2<=0;kx3<=k3;kx4<=0;ky1<=k8;ky2<=k2;kz1<=k6;kz2<=0;ko1<=k5;                                  
                     end           
                   default:begin
             kx1<=k9;kx2<=k7;kx3<=k3;kx4<=k1;ky1<=k8;ky2<=k2;kz1<=k6;kz2<=k4;ko1<=k5;
                           end   
                 endcase     
         
                         
              
    endcase          
 end
 
 mult_gen_0 u0_mult_gen_0( .CLK(clk),.A(data_in     ),.B(kx1),.P(result_x1));
 mult_gen_0 u0_mult_gen_1( .CLK(clk),.A(data_in_dly1),.B(kx2),.P(result_x2));
 mult_gen_0 u0_mult_gen_2( .CLK(clk),.A(data_in_dly4),.B(kx3),.P(result_x3));
 mult_gen_0 u0_mult_gen_3( .CLK(clk),.A(data_in_dly5),.B(kx4),.P(result_x4));
 mult_gen_0 u0_mult_gen_4( .CLK(clk),.A(data_in     ),.B(ky1),.P(result_y1));
 mult_gen_0 u0_mult_gen_5( .CLK(clk),.A(data_in_dly4),.B(ky2),.P(result_y2));
 mult_gen_0 u0_mult_gen_6( .CLK(clk),.A(data_in     ),.B(kz1),.P(result_z1));
 mult_gen_0 u0_mult_gen_7( .CLK(clk),.A(data_in_dly1),.B(kz2),.P(result_z2));
 mult_gen_0 u0_mult_gen_8( .CLK(clk),.A(data_in     ),.B(ko1),.P(result_o1));
 



 always@(posedge clk or negedge rst_n)
 begin
   if(!rst_n)
   begin
     x_s1<=21'd0;
     x_s2<=21'd0;
     x_s<=22'd0;
     y_s<=21'd0;
     z_s<=21'd0;
     x_s_bias<=23'd0;
     y_s_bias<=22'd0;
     z_s_bias<=22'd0;
     o_s_bias<=21'd0;
   end  
   else 
   begin
     x_s1<= result_x1 + result_x2; 
     x_s2<= result_x3 + result_x4;
     x_s <= x_s1 + x_s2;
     y_s <= result_y1 + result_y2;
     z_s <= result_z1 + result_z2;
     x_s_bias<=x_s+bias;
     y_s_bias<=y_s+bias;
     z_s_bias<=z_s+bias;
     o_s_bias<=result_o1+bias;
   end  
 end

  always@(posedge clk or negedge rst_n)
  begin
    if(!rst_n)
      x_in<=9'd0;
    else if (x_s_bias[22])
    begin 
       if(x_s_bias[17:10]==8'h01)
         x_in<={x_s_bias[22],x_s_bias[17:10]};
       if(x_s_bias[17:10]==8'h00&&x_s_bias[21:18]==4'b1111)
         x_in<=-255;  
       else if(x_s_bias[21:18]==4'b1111&&(!x_s_bias[9]))
         x_in<={x_s_bias[22],x_s_bias[17:10]}+9'h1ff;
       else if(x_s_bias[21:18]==4'b1111)
         x_in<={x_s_bias[22],x_s_bias[17:10]};        
       else  
         x_in<=-255;  
    end
     else if (!x_s_bias[22])
      begin 
       if(x_s_bias[17:10]==255)
         x_in<={x_s_bias[22],x_s_bias[17:10]};   
       else if(x_s_bias[21:18]==4'b0000)
         x_in<={x_s_bias[22],x_s_bias[17:10]}+x_s_bias[9];
       else  
         x_in<=255;  
      end  
  end
  
   always@(posedge clk or negedge rst_n)
  begin
    if(!rst_n)
      y_in<=9'd0;
    else if (y_s_bias[21])
    begin 
       if(y_s_bias[17:10]==8'h01)
         y_in<={y_s_bias[21],y_s_bias[17:10]};
       else if(y_s_bias[17:10]==8'h00&&y_s_bias[20:18]==3'b111)
         y_in<=-255;        
       else  if(y_s_bias[20:18]==3'b111&&(!y_s_bias[9]))
         y_in<={y_s_bias[21],y_s_bias[17:10]}+9'h1ff;
       else if(y_s_bias[20:18]==3'b111)
         y_in<={y_s_bias[21],y_s_bias[17:10]};        
       else  
         y_in<=-255;  
    end
     else if (!y_s_bias[21])
      begin 
       if(y_s_bias[17:10]==255)
         y_in<={y_s_bias[21],y_s_bias[17:10]};
       else if(y_s_bias[20:18]==3'b000)
         y_in<={y_s_bias[21],y_s_bias[17:10]}+y_s_bias[9];
       else  
         y_in<=255;  
      end  
  end
  
   always@(posedge clk or negedge rst_n)
  begin
    if(!rst_n)
      z_in<=9'd0;
    else if (z_s_bias[21])
    begin 
       if(z_s_bias[17:10]==8'h01)
         z_in<={z_s_bias[21],z_s_bias[17:10]};
       else if(z_s_bias[17:10]==8'h00&&z_s_bias[20:18]==3'b111)
         z_in<=-255;   
       else if(z_s_bias[20:18]==3'b111&&(!z_s_bias[9]))
         z_in<={z_s_bias[21],z_s_bias[17:10]}+9'h1ff;
       else if(z_s_bias[20:18]==3'b111)
         z_in<={z_s_bias[21],z_s_bias[17:10]};        
       else  
         z_in<=-255;  
    end
     else if (!z_s_bias[21])
      begin 
       if(z_s_bias[17:10]==255)
         z_in<={z_s_bias[21],z_s_bias[17:10]};
       else  if(z_s_bias[20:18]==3'b000)
         z_in<={z_s_bias[21],z_s_bias[17:10]}+z_s_bias[9];
       else  
         z_in<=255;  
      end  
  end
  
   always@(posedge clk or negedge rst_n)
  begin
    if(!rst_n)
      o_in<=9'd0;
    else if (o_s_bias[20])
    begin 
       if(o_s_bias[17:10]==8'h01)
         o_in<={o_s_bias[20],o_s_bias[17:10]}; 
       if(o_s_bias[17:10]==8'h00&&o_s_bias[19:18]==2'b11)
         o_in<={o_s_bias[20],o_s_bias[17:10]};    
       else  if(o_s_bias[19:18]==2'b11&&(!o_s_bias[9]))
         o_in<={x_s_bias[20],o_s_bias[17:10]}+9'h1ff;
       else if(o_s_bias[19:18]==2'b11)
           o_in<={x_s_bias[20],o_s_bias[17:10]};        
       else  
         o_in<=-255;  
    end
     else if (!o_s_bias[20])
      begin 
       if(o_s_bias[17:10]==255)
        o_in<={o_s_bias[20],o_s_bias[17:10]};
       else  if(o_s_bias[19:18]==2'b00)
         o_in<={o_s_bias[20],o_s_bias[17:10]}+o_s_bias[9];
       else  
         o_in<=255;  
      end  
  end
  
 always@(posedge clk or negedge rst_n)
  begin
    if(!rst_n)
    begin
      {de_dly5,de_dly4,de_dly3,de_dly2,de_dly1}<=5'd0;
      {x_r_dly1,y_r_dly1,z_r_dly1,o_r_dly1}<=4'd0;
     
    end  
    else
    begin
      {de_dly5,de_dly4,de_dly3,de_dly2,de_dly1}<={de_dly4,de_dly3,de_dly2,de_dly1,de};
      {x_r_dly1,y_r_dly1,z_r_dly1,o_r_dly1}<={x_r,y_r,z_r,o_r};
    end   
  end 
 
 
 
 


 assign x_r=transfer&&line1_v;
 assign y_r=!transfer &&line1_v;
 assign z_r=transfer&&line2_v;
 assign o_r=!transfer &&line2_v;
 
 always@(posedge clk or negedge rst_n)
 begin
   if(!rst_n)
     start_sign<=1'b0;
   else if(data_count > 0)
     start_sign<=1'b1;  
   else if(cnt_dst_c==cnt_col_dst&&cnt_dst_l==cnt_line_dst)
     start_sign<=1'b0;  
 end 
 
  
 always@(posedge clk or negedge rst_n)
 begin
   if(!rst_n)
     transfer<=1'b0;
   else if(start_sign)   
     transfer<=~transfer;
 end
 
 always@(posedge clk or negedge rst_n)
 begin
   if(!rst_n)
     cnt_dst_c<=16'd1;
   else if(start_sign&&cnt_dst_c==cnt_col_dst)
     cnt_dst_c<=16'd1;   
   else if(start_sign)
     cnt_dst_c<= cnt_dst_c+16'd1; 
 end
 
 always@(posedge clk or negedge rst_n)
 begin
   if(!rst_n)
     cnt_dst_l<=16'd1;
   else if(start_sign&&cnt_dst_c==cnt_col_dst&&cnt_dst_l==cnt_line_dst)
     cnt_dst_l<=16'd1;   
   else if(start_sign&&cnt_dst_c==cnt_col_dst)
     cnt_dst_l<= cnt_dst_l+16'd1; 
 end 
 
 always@(posedge clk or negedge rst_n)
 begin
   if(!rst_n)
     begin 
     line1_v<=1'b0;
     line2_v<=1'b0;
     end
   else if(start_sign&&cnt_dst_l[0])
   begin
     line1_v<=1'b1;
     line2_v<=1'b0;
   end
   else if(start_sign&(!cnt_dst_l[0]))
   begin
     line1_v<=1'b0;
     line2_v<=1'b1;
   end
    else 
   begin 
    line1_v<=1'b0;
    line2_v<=1'b0;
    end
 end
 
 
 always@(posedge clk or negedge rst_n)
 begin
   if(!rst_n)
   begin
     data_out<=9'd0;
     data_de<=1'b0;
   end  
   else if(x_r_dly1)
   begin
     data_out<=line1_data1;
     data_de<=1'b1;
   end
   else if(y_r_dly1)
   begin
     data_out<=line1_data2;
     data_de<=1'b1;
   end   
   else if(z_r_dly1)
   begin
     data_out<=line2_data1;
     data_de<=1'b1;
   end   
   else if(o_r_dly1)
   begin
     data_out<=line2_data2;
     data_de<=1'b1;
   end   
   else 
   begin
     data_out<=9'd0;
     data_de<=1'b0;
   end     
 end
 
 
fifo_generator_128x128 u0_fifo_generator_128x128(
    .clk(clk),
    .srst(!rst_n),
    .din(x_in),
    .wr_en(de_dly5),
    .rd_en(x_r),
    .dout(line1_data1),
    .full(),
    .empty(),
    .data_count(data_count)
  );
 
 fifo_generator_128x128 u1_fifo_generator_128x128(
      .clk(clk),
      .srst(!rst_n),
      .din(y_in),
      .wr_en(de_dly4),
      .rd_en(y_r),
      .dout(line1_data2),
      .full(),
      .empty(),
      .data_count()
    );
 
 fifo_generator_128x128 u2_fifo_generator_128x128(
        .clk(clk),
        .srst(!rst_n),
        .din(z_in),
        .wr_en(de_dly4),
        .rd_en(z_r),
        .dout(line2_data1),
        .full(),
        .empty(),
        .data_count()
      );
 
 fifo_generator_128x128 u3_fifo_generator_128x128(
          .clk(clk),
          .srst(!rst_n),
          .din(o_in),
          .wr_en(de_dly3),
          .rd_en(o_r),
          .dout(line2_data2),
          .full(),
          .empty(),
          .data_count()
        );
 
 
 
 
 
 
endmodule
