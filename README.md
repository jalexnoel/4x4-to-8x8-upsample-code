# 4x4-to-8x8-upsample-code
Supplementary File-A Systolic nxn to 2nx2n Deconvolution Architecture for Upsampling


1. A Systolic Deconvolution Architecture for up samplingM.tex and references.bib are used for generated pdf file by texstuidio 2.12.14


2. Environment MATLAB 2019a
2.1 euqation Summary.m for obtaining the equations that are in this paper.
2.2 verifycode3by3.m for check the 3x3 kernel between FPGA and Matlab 
2.3 verifycode5by5.m for check the 3x3 kernel between FPGA and Matlab 
2.4 verifycode7by7.m for check the 3x3 kernel between FPGA and Matlab 

3. project_4_to_8.zip is a Verilog HDL code to show our proposed upsample from  4x4 to 8x8 by 3x3 kernel on VIVADO 2017.4
    used input matrix such like 
            [1 2 3 4;
             5 6 7 8;
             9 10 11 12;
            13 14 15 16];

Verilog Code : We have uploaded the verilog codes alone for review purposes. The complete project will be avaliable for usage once the reviews are completed at the following doi
10.6084/m9.figshare.13668644
