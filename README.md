# 4x4-to-8x8-upsample-code
Supplementary File-FPGA-Based Systolic Deconvolution Architecture for Upsampling




1. Environment MATLAB 2019a
1.1 euqation Summary.m for obtaining the equations that are in this paper.
1.2 verifycode3by3.m for check the 3x3 kernel between FPGA and Matlab 
1.3 verifycode5by5.m for check the 3x3 kernel between FPGA and Matlab 
1.4 verifycode7by7.m for check the 3x3 kernel between FPGA and Matlab 

2. project_4_to_8.zip is a Verilog HDL code to show our proposed upsample from  4x4 to 8x8 by 3x3 kernel on VIVADO 2017.4
    used input matrix such like 
            [1 2 3 4;
             5 6 7 8;
             9 10 11 12;
            13 14 15 16];

Verilog Code : We have uploaded the verilog codes alone for review purposes. 
