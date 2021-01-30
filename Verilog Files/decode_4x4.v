`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/12/15 09:01:54
// Design Name: 
// Module Name: decode
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
module decode_4x4(
input          clk,
input          rst_n,
input          de,
input  [7:0]   data,
output [7:0]   data_o,
output         de_o
    );
    
    
    
    parameter k1=8'd1;
    parameter k2=8'd2;
    parameter k3=8'd3;
    parameter k4=8'd4;
    parameter k5=8'd5;
    parameter k6=8'd6;
    parameter k7=8'd7;
    parameter k8=8'd8;
    parameter k9=8'd9;
    parameter pic_src_width=4;          //原始宽度
    parameter pic_dst_width=8;          //目标宽度
    parameter pic_src_height=4;         //原始高度
    parameter pic_dst_height=8;         //目标高度

    
    
    
    reg         data_de; 
    reg         de_dly1; 
    reg         de_dly2;
    reg         de_dly3;  
    reg [20:0]  cnt_src_c;   //原始列数   
    reg [20:0]  cnt_src_l;   //原始行数
    reg [20:0]  cnt_src_l_dly1;
    reg [7:0 ]  data_dly1;    
    reg [15:0]  line1_data_1;
    reg [15:0]  line1_data_2;
    reg [15:0]  line2_data_1;
    reg [15:0]  line2_data_2;
    reg [7:0 ]  data_l1_1;         
    reg [7:0 ]  data_l2_1;
    reg [15:0]   wr_cnt_line1;
    reg [15:0]   wr_cnt_line2;
    reg [15:0]   rd_cnt_line1;
    reg [15:0]   rd_cnt_line2;
    reg          rd_start;
    reg [15:0]   dst_cnt_c;
    reg [15:0]   dst_cnt_l;
    reg [7:0 ]   data_out;   
    reg          rd_line1_vaild;
    reg          rd_line2_vaild;
    reg          transfer;
    wire[7:0 ]  data_l1_2;
    wire[7:0 ]  data_l2_2;
    wire        de_dly_x;
    wire        de_dly_y;
    
    assign data_l2_2=data;
    assign de_o=data_de;
    assign data_o=data_out;
    
  shift_ram_4x4 u0_shift_ram_4x4
 (
    .D           (data       ), 
    .CLK         (clk        ),
    .Q           (data_l1_2  )
  );
  
   shift_ram_4x4 u1_shift_ram_4x4
  (
     .D           (de_dly1    ), 
     .CLK         (clk        ),
     .Q           (de_dly_x   )
   );
   shift_ram_4x4 u2_shift_ram_4x4
     (
        .D           (de_dly2    ), 
        .CLK         (clk        ),
        .Q           (de_dly_y   )
      );
    
    always@(posedge clk,negedge rst_n)
    begin
      if(!rst_n)
       cnt_src_l_dly1<=1'b0;
      else
       cnt_src_l_dly1<=cnt_src_l;
    end 
    
    
    always@(posedge clk,negedge rst_n)
    begin
       if(!rst_n)
       begin
         de_dly1<=1'b0;
         de_dly2<=1'b0;
         de_dly3<=1'b0;
       end 
       else
       begin
         de_dly1<=de;
         de_dly2<=de_dly1;
         de_dly3<=de_dly2;
       end  
    end
    
    
    always@(posedge clk,negedge rst_n)
    begin
       if(!rst_n)
       begin
          data_l1_1<=8'd0;
          data_l2_1<=8'd0;
       end   
       else
       begin
          data_l1_1<=data_l1_2;
          data_l2_1<=data_l2_2;
       end      
    end
    
    
    always@(posedge clk,negedge rst_n)
    begin
        if(!rst_n)
          cnt_src_c<=21'd0;
        else if((de_dly_x||de_dly1)&&cnt_src_c==pic_src_width-1)
          cnt_src_c<=21'd0;
        else if(de_dly1||de_dly_x)
          cnt_src_c<=+cnt_src_c+21'd1;        
    end
    
    always@(posedge clk,negedge rst_n )
    begin
       if(!rst_n)
         cnt_src_l<=21'd0;
       else if((de_dly_x||de_dly1)&&cnt_src_c==pic_src_width-1&&cnt_src_l==pic_src_height)
         cnt_src_l<=21'd0;
       else if((de_dly_x||de_dly1)&&cnt_src_c==pic_src_width-1)
         cnt_src_l<=cnt_src_l+21'd1;
    end
    
    
    always@(posedge clk,negedge rst_n)
    begin
       if(!rst_n)
         data_dly1<=8'd0;
       else 
         data_dly1<=data;  
    end   
    
    always@(posedge clk,negedge rst_n)
    begin
      if(!rst_n)
      begin
        line1_data_1<=8'd0;
        line1_data_2<=8'd0;
      end
      else  
        case(cnt_src_l)
        0:
        if(cnt_src_c==pic_src_width-1)
        begin    
              line1_data_1<=data_l2_1*k5;
              line1_data_2<=data_l2_1*k4;
              line2_data_1<=16'd0;
              line2_data_2<=16'd0;                                                                 
                  end
       else  begin    
             line1_data_1<=data_l2_1*k5;
             line1_data_2<=data_l2_1*k4+data_l2_2*k6;
             line2_data_1<=16'd0;
             line2_data_2<=16'd0;                                                                 
          end
        pic_src_height:
         if(cnt_src_c==pic_src_width-1)
               begin    
              line1_data_1<=data_l1_1*k2;
              line1_data_2<=data_l1_1*k1; 
              line2_data_1<=16'd0;
              line2_data_2<=16'd0;                                                                 
                         end
              else
        begin   
             line1_data_1<=data_l1_1*k2;
             line1_data_2<=data_l1_1*k1+data_l1_2*k3;  
             line2_data_1<=16'd0;
             line2_data_2<=16'd0;                             
                       end
        default:
       if(cnt_src_c==pic_src_width-1)
       begin   
         line1_data_1<=data_l1_1*k2+data_l2_1*k8;
         line1_data_2<=data_l1_1*k1+data_l2_1*k7;  
         line2_data_1<=data_l2_1*k5;
         line2_data_2<=data_l2_1*k4; 
       end
      else  begin
             line1_data_1<=data_l1_1*k2+data_l2_1*k8;
             line1_data_2<=data_l1_1*k1+data_l1_2*k3+data_l2_1*k7+data_l2_2*k9;  
             line2_data_1<=data_l2_1*k5;
             line2_data_2<=data_l2_1*k4+data_l2_2*k6; 
         end
        endcase  
    
    
       end
    
     
     wire   [23:0] data_fifo0;
     wire   [23:0] data_fifo1;
     wire   [23:0] data_fifo2;
     wire   [23:0] data_fifo3;
     wire   wr_fifo_2;
     wire   rd_fifo_0;
     wire   rd_fifo_1;
     wire   rd_fifo_2;
     wire   rd_fifo_3;
     
     reg   transfer2;
     reg   rd_fifo_0_dly1;
     reg   rd_fifo_1_dly1;
     reg   rd_fifo_2_dly1;
     reg   rd_fifo_3_dly1;
     wire  [7:0] wr_in0;
     wire  [7:0] wr_in1;
     wire  [7:0] wr_in2;
     wire  [7:0] wr_in3;
     
     assign rd_fifo_0=~transfer2&&rd_line1_vaild;
     assign rd_fifo_1= transfer2&&rd_line1_vaild;
     assign rd_fifo_2=~transfer2&&rd_line2_vaild;
     assign rd_fifo_3= transfer2&&rd_line2_vaild;
     assign wr_fifo_2=de_dly2&&cnt_src_l_dly1>0&&cnt_src_l_dly1<pic_src_height;
     assign wr_in0=line1_data_1[9:8]?8'd255:line1_data_1[7:0];
     assign wr_in1=line1_data_2[9:8]?8'd255:line1_data_2[7:0];
     assign wr_in2=line2_data_1[9:8]?8'd255:line2_data_1[7:0];
     assign wr_in3=line2_data_2[9:8]?8'd255:line2_data_2[7:0];
     
    
     always@(posedge clk,negedge rst_n)
     begin
        if(!rst_n)
        begin
          rd_fifo_0_dly1<=1'b0;
          rd_fifo_1_dly1<=1'b0;
          rd_fifo_2_dly1<=1'b0;
          rd_fifo_3_dly1<=1'b0;
        end
        else 
        begin
          rd_fifo_0_dly1<=rd_fifo_0;
          rd_fifo_1_dly1<=rd_fifo_1;
          rd_fifo_2_dly1<=rd_fifo_2;
          rd_fifo_3_dly1<=rd_fifo_3;
        end
     end
     
     fifo_generator_4x4 u0_fifo_generator_4x4
     (
       .clk        (clk      ), 
       .srst       (         ),
       .din        (wr_in0),
       .wr_en      (de_dly_y||de_dly2),
       .rd_en      (rd_fifo_0),
       .dout       (data_fifo0)
     );    
      
    fifo_generator_4x4 u1_fifo_generator_4x4
         (
      .clk        (clk      ), 
      .srst       (         ),
      .din        (wr_in1),
      .wr_en      (de_dly_y||de_dly2),
      .rd_en      (rd_fifo_1),
      .dout       (data_fifo1)
         );    
    
    fifo_generator_4x4 u2_fifo_generator_4x4
       (
      .clk        (clk      ), 
      .srst       (         ),
      .din        (wr_in2),
      .wr_en      (wr_fifo_2),
      .rd_en      (rd_fifo_2),
      .dout       (data_fifo2)
                  ); 
    
     fifo_generator_4x4 u3_fifo_generator_4x4
    (
      .clk        (clk      ),
      .srst       (         ),
      .din        (wr_in3),
      .wr_en      (wr_fifo_2),
      .rd_en      (rd_fifo_3),
      .dout       (data_fifo3)
   ); 
    
    
    
    
    
    
    
    always@(posedge clk, negedge rst_n)
    begin
       if(!rst_n)
         rd_start<=1'b0;
       else if(de_dly3)
         rd_start<=1'b1;  
       else if(dst_cnt_l==pic_dst_height-1&&dst_cnt_c==pic_dst_width-1)
         rd_start<=1'b0;
    end
    
    always@(posedge clk,negedge rst_n)
    begin
       if(!rst_n)
        dst_cnt_c<=16'd0;    
       else if(rd_start&&dst_cnt_c==pic_dst_width-1)
        dst_cnt_c<=16'd0;  
       else if(rd_start)
        dst_cnt_c<=dst_cnt_c+16'd1;
       else 
        dst_cnt_c<=dst_cnt_c;      
    end
    
    always@(posedge clk,negedge rst_n)
    begin
       if(!rst_n)
          dst_cnt_l<=16'd0;
       else if(rd_start&&dst_cnt_c==pic_dst_width-1&&dst_cnt_l==pic_dst_height-1)
          dst_cnt_l<=16'd0;
       else if(rd_start&&dst_cnt_c==pic_dst_width-1)    
          dst_cnt_l<=dst_cnt_l+16'd1;
    end
    
    always@(posedge clk,negedge rst_n)
    begin
       if(!rst_n)
         transfer<=1'b0;
       else if(dst_cnt_l==1'b0)
         transfer<=1'b0;
       else if(dst_cnt_c==pic_dst_width-1)  
         transfer<=~transfer;
    end
    
    
    always@(posedge clk,negedge rst_n)
    begin
      if(!rst_n)
      begin
        rd_line1_vaild<=1'b0;
        rd_line2_vaild<=1'b0;
        
      end
      else if(rd_start&&dst_cnt_l==16'd0)
      begin
        rd_line1_vaild<=1'b1;
        rd_line2_vaild<=1'b0;
      
      end
      else if(rd_start&&transfer==1'b0)
      begin  
        rd_line1_vaild<=1'b1;
        rd_line2_vaild<=1'b0;
       
      end
      else if(rd_start&&transfer==1'b1)
      begin  
        rd_line1_vaild<=1'b0;
        rd_line2_vaild<=1'b1;
      
      end
      
      else 
       begin  
             rd_line1_vaild<=1'b0;
             rd_line2_vaild<=1'b0;
           
           end
    end 
    
    
    
    
    always@(posedge clk,negedge rst_n)
    begin
       if(!rst_n)
         transfer2<=1'b0;
       else if(rd_line1_vaild||rd_line2_vaild)  
         transfer2<=~transfer2;
    end
    
    
    
    
    always@(posedge clk,negedge rst_n)
    begin
      if(!rst_n)
      begin
        data_de<=1'b0;  
        data_out<=24'd0;
      end
      else if(rd_fifo_0_dly1)
        begin
        data_de<=1'b1;  
        data_out<=data_fifo0;
        end
     else if(rd_fifo_1_dly1)
        begin
        data_de<=1'b1;  
        data_out<=data_fifo1;
        end 
     else if(rd_fifo_2_dly1)
        begin
        data_de<=1'b1;  
        data_out<=data_fifo2;
        end
     else if(rd_fifo_3_dly1)
        begin
        data_de<=1'b1;  
        data_out<=data_fifo3;
        end
     else
       begin
       data_de<=1'b0;
       data_out<=24'd0;
       end              
    end
    
    

    
    
endmodule
