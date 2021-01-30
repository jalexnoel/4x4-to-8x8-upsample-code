
format('short');
 

%defined the input 
input_1=imread('H:\picture\face\randomImage32.bmp');
input=double(input_1(:,:,1));
%%%%%%%%%%%%%%%%%%%  

%d creat result matrix
result = rand(64,64);
w=64 ;  % result width                              
%%%%%%%%%%%%%%%%%%%


%computation
for i=1:1:w
        if i==1 
                for j=1:1:w     
                    if j==1
                            result(i,j)=pe1(0,0,0,0,input(1,1),input(1,2),0,input(2,1),input(2,2));                               
                    elseif j==(w-1)
                            result(i,j)=pe1(0,0,0,input(1,(j+1)/2-1),input(1,(j+1)/2),0,input(2,(j+1)/2-1),input(2,(j+1)/2),0);
                    elseif j==w
                            result(i,j)=pe2(0,0,input(1,j/2),0,input(2,j/2),0);                    
                    elseif j>1 && mod(j,2)==0 
                            result(i,j)=pe2(0,0,input(1,j/2),input(1,j/2+1),input(2,j/2),input(2,j/2+1));                 
                    elseif j>1 && mod(j,2)==1 
                            result(i,j)=pe1(0,0,0,input(1,(j+1)/2-1),input(1,(j+1)/2),input(1,(j+1)/2+1),input(2,(j+1)/2-1),input(2,(j+1)/2),input(2,(j+1)/2+1)); 
                    end
                end
        elseif i==w-1                 
                for j=1:1:w     
                        if j==1 
                            result(i,j)=pe1(0,input((i+1)/2-1,1),input((i+1)/2-1,2),0,input((i+1)/2,1),input((i+1)/2,2),0,0,0);                               
                        elseif j==w-1
                            result(i,j)=pe1(input((i+1)/2-1,(j+1)/2-1),input((i+1)/2-1,(j+1)/2),0,input((i+1)/2,(j+1)/2-1),input((i+1)/2,(j+1)/2),0,0,0,0);
                        elseif j==w
                            result(i,j)=pe2(input((i+1)/2-1,j/2),0,input((i+1)/2,j/2),0,0,0);               
                        elseif j>1 && mod(j,2)==0 
                            result(i,j)=pe2(input((i+1)/2-1,j/2),input((i+1)/2-1,j/2+1),input((i+1)/2,j/2),input((i+1)/2,j/2+1),0,0);                 
                        elseif j>1 && mod(j,2)==1 
                            result(i,j)=pe1(input((i+1)/2-1,(j+1)/2-1),input((i+1)/2-1,(j+1)/2),input((i+1)/2-1,(j+1)/2+1),input((i+1)/2,(j+1)/2-1),input((i+1)/2,(j+1)/2),input((i+1)/2,(j+1)/2+1),0,0,0);
                        end
                end
        elseif i==w
                for j=1:1:w     
                    if j==1 
                            result(i,j)=pe3(0,input(i/2,1),input(i/2,2),0,0,0);    
                    elseif j==w-1
                            result(i,j)=pe3(input(i/2,(j+1)/2-1),input(i/2,(j+1)/2),0,0,0,0);
                    elseif j==w
                            result(i,j)=pe4(input(i/2,j/2),0,0,0);                    
                    elseif j>1 && mod(j,2)==0 
                            result(i,j)=pe4(input(i/2,j/2),input(i/2,j/2+1),0,0);
                    elseif j>1 && mod(j,2)==1 
                            result(i,j)=pe3(input(i/2,(j+1)/2-1),input(i/2,(j+1)/2),input(i/2,(j+1)/2+1),0,0,0);
                    end
                end
        elseif i>1 && mod(i,2)==0
                for j=1:1:w   
                    if j==1 
                            result(i,j)=pe3(0,input(i/2,1),input(i/2,2),0,input(i/2+1,1),input(i/2+1,2));    
                    elseif j==w-1
                            result(i,j)=pe3(input(i/2,(j+1)/2-1),input(i/2,(j+1)/2),0,input(i/2+1,(j+1)/2-1),input(i/2+1,(j+1)/2),0);
                    elseif j==w
                            result(i,j)=pe4(input(i/2,j/2),0,input(i/2+1,j/2),0);                    
                    elseif j>1 && mod(j,2)==0 
                            result(i,j)=pe4(input(i/2,j/2),input(i/2,j/2+1),input(i/2+1,j/2),input(i/2+1,j/2+1));
                    elseif j>1 && mod(j,2)==1 
                            result(i,j)=pe3(input(i/2,(j+1)/2-1),input(i/2,(j+1)/2),input(i/2,(j+1)/2+1),input(i/2+1,(j+1)/2-1),input(i/2+1,(j+1)/2),input(i/2+1,(j+1)/2+1));
                    end
                end 
         elseif i>1 && mod(i,2)==1
                for j=1:1:w     
                        if j==1 
                            result(i,j)=pe1(0,input((i+1)/2-1,1),input((i+1)/2-1,2),0,input((i+1)/2,1),input((i+1)/2,2),0,input((i+1)/2+1,1),input((i+1)/2+1,2));                               
                        elseif j==w-1
                            result(i,j)=pe1(input((i+1)/2-1,(j+1)/2-1),input((i+1)/2-1,(j+1)/2),0,input((i+1)/2,(j+1)/2-1),input((i+1)/2,(j+1)/2),0,input((i+1)/2+1,(j+1)/2-1),input((i+1)/2+1,(j+1)/2),0);
                        elseif j==w
                            result(i,j)=pe2(input((i+1)/2-1,j/2),0,input((i+1)/2,j/2),0,input((i+1)/2+1,j/2),0);               
                        elseif j>1 && mod(j,2)==0 
                            result(i,j)=pe2(input((i+1)/2-1,j/2),input((i+1)/2-1,j/2+1),input((i+1)/2,j/2),input((i+1)/2,j/2+1),input((i+1)/2+1,j/2),input((i+1)/2+1,j/2+1));                 
                        elseif j>1 && mod(j,2)==1 
                            result(i,j)=pe1(input((i+1)/2-1,(j+1)/2-1),input((i+1)/2-1,(j+1)/2),input((i+1)/2-1,(j+1)/2+1),input((i+1)/2,(j+1)/2-1),input((i+1)/2,(j+1)/2),input((i+1)/2,(j+1)/2+1),input((i+1)/2+1,(j+1)/2-1),input((i+1)/2+1,(j+1)/2),input((i+1)/2+1,(j+1)/2+1));
                        end
                end        
        end
end
%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%  extend image
ectend_im=rand(68,68);
i_src=1;
j_src=1;
for j=1:68
   for i=1:68
       ectend_im(i,j)=0;     
   end
end
for j=3:2:65 
    
   for i=3:2:65
       ectend_im(i,j)=input(i_src,j_src);
       i_src=i_src+1;
       
   end
   j_src=j_src+1;
   i_src=1;
end

%%%%%%%%%%%%%%%%%%%%
k5_1=[0.3337559,0.9601080,0.58529107,0.1752709,0.5335508;
    0.4908880,0.6123945,0.2637595,0.7209398,0.6351042;
    0.2253839,0.3535834,0.5837172,0.1185988,0.9574030;
    0.7640113,0.2084628,0.03690647,0.4767907,0.2430356;
    0.4047918,0.07671536,0.8965142,0.7426966,0.6288385];

k5_2=[0.32472357,0.49766937,0.7179508,0.36809376,0.37602708;
    0.6708246,0.5465848,0.73040485,0.74279296,0.69488674;
    0.43003333,0.49754766,0.7543376,0.3721336,0.50353473;
    0.62220645,0.20782448,0.7216198,0.31841174,0.33199382;
    0.5266644,0.6538245,0.6767199,0.1349497,0.43830177]; 


k5_3=[0.18728149,0.32240462,0.52116907,0.6616572,0.37523922;
    0.52034175,0.65139055,0.30861047,0.6860085,0.17061643;
    0.44493514,0.6103205,0.24159689,0.3325804,0.24146505;
    0.1982769,0.50561666,0.41104487,0.39173868,0.7685566;
    0.7049747,0.78133786,0.4827651,0.66265166,0.4202156]; 


k5_4=[-0.5082502,0.43726194,-0.60172296,0.2166621,-0.34238118;
    -0.16574912,0.30523908,0.10099383,0.5604663,0.10574419;
    -0.2743001,0.27375165,-0.7012087,0.17278147,-0.14555337;
    -0.05479549,0.36990842,0.15466414,0.34556758,-0.01668373;
    -0.55698955,0.46784526,-0.7068811,0.13075468,-0.47714347]; 

pic_dst_0=conv2(ectend_im,k5_1,'valid');
%%%%%%%%%%%%%%%%%%%%

F_result=(result)/2048;
compare=pic_dst_0-F_result;
b1=reshape(compare,1,4096);
MSE_1 = sum(sum((b1).^2))/(4096);
RMSe1 = sqrt(MSE_1);
PSNR_1 = psnr(pic_dst_0,F_result,511);
%%%%%%%%%%%%%%%%%%%%


%%%% four PE %%%%
function result1 = pe1(din1,din2,din3,din4,din5,din6,din7,din8,din9)
% 12-bit kernel value
k5=[1288,1521,1836,157,829;
    498,976,76,427,1565;
    1961,243,1195,724,462;
    1301,1476,540,1254,1005;
    1093,359,1199,1966,684];

    result1 = k5(1,1)*din1+k5(1,3)*din2+k5(1,5)*din3+k5(3,1)*din4+k5(3,3)*din5+k5(3,5)*din6+k5(5,1)*din7+k5(5,3)*din8+k5(5,5)*din9;
end

function result2 = pe2(din1,din2,din3,din4,din5,din6)
% 12-bit kernel value
k5=[1288,1521,1836,157,829;
    498,976,76,427,1565;
    1961,243,1195,724,462;
    1301,1476,540,1254,1005;
    1093,359,1199,1966,684];

    result2 = k5(1,2)*din1+k5(1,4)*din2+k5(3,2)*din3+k5(3,4)*din4+k5(5,2)*din5+k5(5,4)*din6;
end

function result3 = pe3(din1,din2,din3,din4,din5,din6)
% 12-bit kernel value
k5=[1288,1521,1836,157,829;
    498,976,76,427,1565;
    1961,243,1195,724,462;
    1301,1476,540,1254,1005;
    1093,359,1199,1966,684];

    result3 = k5(2,1)*din1+k5(2,3)*din2+k5(2,5)*din3+k5(4,1)*din4+k5(4,3)*din5+k5(4,5)*din6;
end

function result4 = pe4(din1,din2,din3,din4)
% 12-bit kernel value
k5=[1288,1521,1836,157,829;
    498,976,76,427,1565;
    1961,243,1195,724,462;
    1301,1476,540,1254,1005;
    1093,359,1199,1966,684];

    result4 = k5(2,2)*din1+k5(2,4)*din2+k5(4,2)*din3+k5(4,4)*din4;
end