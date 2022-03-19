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

//sim
//input         I_32x32_RDREQ,

//

    input clk,
    output hdmi_oen,
    output TMDS_clk_n,
    output TMDS_clk_p,
    output [2:0]TMDS_data_n,
    output [2:0]TMDS_data_p



    );
    
    
wire video_clk;
wire video_clk_5x;
wire video_hs;
wire video_vs;
wire video_de;
wire[7:0] video_r;
wire[7:0] video_g;
wire[7:0] video_b;

wire        pic1_hs;
wire        pic1_vs;
wire        pic1_de;
wire[7:0]   pic1_r;
wire[7:0]   pic1_g;
wire[7:0]   pic1_b;

wire        pic2_hs;
wire        pic2_vs;
wire        pic2_de;
wire[7:0]   pic2_r;
wire[7:0]   pic2_g;
wire[7:0]   pic2_b;

wire        pic3_hs;
wire        pic3_vs;
wire        pic3_de;
wire[7:0]   pic3_r;
wire[7:0]   pic3_g;
wire[7:0]   pic3_b;
    
wire        pic4_hs;
wire        pic4_vs;
wire        pic4_de;
wire[7:0]   pic4_r;
wire[7:0]   pic4_g;
wire[7:0]   pic4_b;
    
    
    
    

  wire [7:0] data_o_32x32;
  wire de_o_32x32; 
  wire signed [8:0] data_out_32x32;
  wire [7:0] data_o_64x64;
  wire de_o_64x64;  
  wire signed [8:0] data_out_64x64;     
  wire [7:0] data_o_128x128;
  wire de_o_128x128;
  wire signed [8:0] data_out_128x128;       
  
 assign    data_o_32x32= data_out_32x32[8]?0:data_out_32x32[7:0];
 assign    data_o_64x64= data_out_64x64[8]?0:data_out_64x64[7:0]; 
 assign    data_o_128x128=data_out_128x128[8]?0:data_out_128x128[7:0];
 

/*=============================================================================+/
||                                                                             ||
||                                FPGA Self Reset                              ||
||                                                                             ||
/+=============================================================================*/

    reg  [12:0] r_SELF_CNT                  = 13'h1FFF              ;
    wire  s_RST   ;

    always @(posedge clk) begin
        if (r_SELF_CNT[4]) begin
            r_SELF_CNT                  <= r_SELF_CNT - 1'b1    ;
        end
    end

    assign s_RST                        = r_SELF_CNT[4]        ;

/*=============================================================================+/
||                                                                             ||
||                          EDGE_CHECK                                         ||
||                                                                             ||
/+=============================================================================*/

    reg                                 r_RST_DFF1       = 1'b0              ;//(r)  [  1]
    reg                                 r_RST_DFF2       = 1'b0              ;//(r)  [  1]
    reg                                 r_RST_DFF3       = 1'b0              ;//(r)  [  1]
    wire                                s_NEG_RST                            ;//(s)  [  1]

    always @ (posedge clk )begin
        r_RST_DFF1                  <= s_RST ;
        r_RST_DFF2                  <= r_RST_DFF1 ;
        r_RST_DFF3                  <= r_RST_DFF2 ;
    end

   assign  s_NEG_RST                     = r_RST_DFF2==0 && r_RST_DFF3==1;


  wire       s_ROM_DE_S;
  wire [7:0] s_ROM_DOUT_S;

  wire       s_64x64_RDREQ  ;
  wire       s_128x128_RDREQ;            
  wire       s_256x256_RDREQ;            
  wire [7:0] s_DOUT64       ;            
  wire [7:0] s_DOUT128      ;            
  wire [7:0] s_DOUT256      ;            
          
  wire       s_32x32_RDREQ  ;       
  wire       s_ram_addr_rst  ;       
  wire [7:0] s_DOUT32       ;            
        
            
  
  
  
    rom_ctrl rom_ctrl_u(
        .CLK                            ( clk          ),
        .PIXEL_CLK                      ( video_clk      ),     
        .i_ram_addr_rst                 (s_ram_addr_rst              ),        
        .RST                            ( s_RST        ),
        .I_START                        ( s_NEG_RST    ),
        .I_32x32_RDREQ                  ( s_32x32_RDREQ        ),
        .O_DE_S                         ( s_ROM_DE_S   ),
        .O_DOUT_S                       ( s_ROM_DOUT_S ),
        .O_DOUT_W                       ( s_DOUT32          )
    ); 
 
 
 
  deconv_32x32  u0_deconv_32x32(
        .clk(clk),
        .rst_n(~s_RST),
        .de(s_ROM_DE_S),
        .k1(136),
        .k2(387),
        .k3(739),
        .k4(393),
        .k5(319),
        .k6(623),
        .k7(661),
        .k8(-108),
        .k9(-316),
        .bias(67680),
        .data_in({1'b0,s_ROM_DOUT_S}),
        .de_o(de_o_32x32),
        .data(data_out_32x32)
            );
  deconv_64x64  u0_deconv_64x64(
        .clk(clk),
        .rst_n(~s_RST),
        .de(de_o_32x32),
        //.k1(-171),
        //.k2(-257),
        //.k3(-887),
        //.k4(-769),
        //.k5(-238),
        //.k6(-854),
        //.k7(-683),
        //.k8(-632),
        //.k9(-5),
        
        .k1(136),
        .k2(387),
        .k3(739),
        .k4(393),
        .k5(319),
        .k6(623),
        .k7(661),
        .k8(-108),
        .k9(-316),        
        
        
        .bias(-61739),
        .data_in(data_out_32x32),
        .de_o(de_o_64x64),
        .data(data_out_64x64)
             );            
  deconv_128x128  u0_deconv_128x128(
        .clk(clk),
        .rst_n(~s_RST),
        .de(de_o_64x64),
        .k1(136),
        .k2(387),
        .k3(739),
        .k4(393),
        .k5(319),
        .k6(623),
        .k7(661),
        .k8(-108),
        .k9(-316),
        .bias(67680), 
        
       // .k1(-299),
       // .k2(-510),
       // .k3(-551),
       // .k4(133),
       // .k5(-145),
       // .k6(-475),
       // .k7(177),
       // .k8(-64),
       // .k9(-660),
       // .bias(34831),
        
        
        .data_in(data_out_64x64),
        .de_o(de_o_128x128),
        .data(data_out_128x128)
             );            
            
            


    ram_ctrl ram_ctrl_u(
        .CLK                                 ( clk            )    ,//(i)  [   1]
        .RST                                 ( s_RST          )    ,//(i)  [   1]
        .PIXEL_CLK                           ( video_clk      )    ,//(i)  [   1] 
        .i_ram_addr_rst                      (s_ram_addr_rst  ),        
        .I_64x64_RDREQ                       ( s_64x64_RDREQ  )    ,//(i)  [   1]
        .I_128x128_RDREQ                     ( s_128x128_RDREQ)    ,//(i)  [   1]
        .I_256x256_RDREQ                     ( s_256x256_RDREQ)    ,//(i)  [   1]
        .O_DOUT64                            ( s_DOUT64       )    ,//(o)  [   8]    
        .O_DOUT128                           ( s_DOUT128      )    ,//(o)  [   8]    
        .O_DOUT256                           ( s_DOUT256      )    ,//(o)  [   8]   

        .I_64x64_WRREQ                       ( de_o_32x32     )    ,//(i)  [   1]
        .I_128x128_WRREQ                     ( de_o_64x64     )    ,//(i)  [   1]
        .I_256x256_WRREQ                     ( de_o_128x128   )    ,//(i)  [   1]
        .I_DIN64                             ( data_o_32x32   )    ,//(i)  [   8]    
        .I_DIN128                            ( data_o_64x64   )    ,//(i)  [   8]    
        .I_DIN256                            ( data_o_128x128 )     //(i)  [   8]   
    );
  
/*=============================================================================+/
||                                                                             ||
||                          DISPALY                                            ||
||                                                                             ||
/+=============================================================================*/  
  

video_clock video_clock_m0
(
     // Clock in ports
    .clk_in1(clk),
      // Clock out ports
    .clk_out1(video_clk),
    .clk_out2(video_clk_5x),
      // Status and control signals
    .reset(1'b0),
    .locked()
 );
 



color_bar hdmi_color_bar(
	.clk(video_clk),
	.rst(s_RST),
	.hs(video_hs),
	.vs(video_vs),
	.de(video_de),
	.rgb_r(video_r),
	.rgb_g(video_g),
	.rgb_b(video_b)
);


pic1_display  pic1_display_u(
	.rst_n                 (~s_RST                     ),
	.pclk                  (video_clk                  ),
	.i_hs                  (video_hs                   ),
	.i_vs                  (video_vs                   ),
	.i_de                  (video_de                   ),
	.i_data                (24'h00                     ),
    
	.o_region_active       (s_32x32_RDREQ              ),
	.o_ram_addr_rst        (s_ram_addr_rst              ),
	.i_region_data         (s_DOUT32                   ),    
    
	.o_hs                  (pic1_hs                     ),
	.o_vs                  (pic1_vs                     ),
	.o_de                  (pic1_de                     ),
	.o_data                ({pic1_r,pic1_g,pic1_b}        )
);  
  
pic2_display  pic2_display_u(
	.rst_n                 (~s_RST                     ),
	.pclk                  (video_clk                  ),
	.i_hs                  (pic1_hs                   ),
	.i_vs                  (pic1_vs                   ),
	.i_de                  (pic1_de                   ),
	.i_data                ({pic1_r,pic1_g,pic1_b}    ),
    
	.o_region_active       (s_64x64_RDREQ              ),
	.o_ram_addr_rst        (                              ),
	.i_region_data         (s_DOUT64                   ),    
    
	.o_hs                  (pic2_hs                     ),
	.o_vs                  (pic2_vs                     ),
	.o_de                  (pic2_de                     ),
	.o_data                ({pic2_r,pic2_g,pic2_b}        )
);  
    
pic3_display  pic3_display_u(
	.rst_n                 (~s_RST                     ),
	.pclk                  (video_clk                  ),
	.i_hs                  (pic2_hs                   ),
	.i_vs                  (pic2_vs                   ),
	.i_de                  (pic2_de                   ),
	.i_data                ({pic2_r,pic2_g,pic2_b}    ),
    
	.o_region_active       (s_128x128_RDREQ              ),
	.o_ram_addr_rst        (                              ),
	.i_region_data         (s_DOUT128                   ),    
    
	.o_hs                  (pic3_hs                     ),
	.o_vs                  (pic3_vs                     ),
	.o_de                  (pic3_de                     ),
	.o_data                ({pic3_r,pic3_g,pic3_b}        )
);   
  
pic4_display  pic4_display_u(
	.rst_n                 (~s_RST                     ),
	.pclk                  (video_clk                  ),
	.i_hs                  (pic3_hs                   ),
	.i_vs                  (pic3_vs                   ),
	.i_de                  (pic3_de                   ),
	.i_data                ({pic3_r,pic3_g,pic3_b}    ),
    
	.o_region_active       (s_256x256_RDREQ              ),
	.o_ram_addr_rst        (                            ),
	.i_region_data         (s_DOUT256                   ),    
    
	.o_hs                  (pic4_hs                     ),
	.o_vs                  (pic4_vs                     ),
	.o_de                  (pic4_de                     ),
	.o_data                ({pic4_r,pic4_g,pic4_b}        )
);   
  
  
  
  
  
  
  

rgb2dvi_0 rgb2dvi_m0 (
	// DVI 1.0 TMDS video interface
	.TMDS_Clk_p(TMDS_clk_p),
	.TMDS_Clk_n(TMDS_clk_n),
	.TMDS_Data_p(TMDS_data_p),
	.TMDS_Data_n(TMDS_data_n),
	.oen(hdmi_oen),
	//Auxiliary signals 
	.aRst_n(1'b1), //-asynchronous reset; must be reset when RefClk is not within spec
	
	// Video in
	.vid_pData({pic4_r,pic4_g,pic4_b}),
	.vid_pVDE(pic4_de),
	.vid_pHSync(pic4_hs),
	.vid_pVSync(pic4_vs),
	.PixelClk(video_clk),
	.SerialClk(video_clk_5x)// 5x PixelClk
);   
  
 
 

  
endmodule
