
input_1=imread('H:\picture\face\randomImage32.bmp');
input=double(input_1(:,:,1));
%%%%%%%%%%%%%%%%%%%  

% creat result matrix
result = rand(64,64);
w=64 ;  % result width                              
                    
%%%%%%%%%%%%%%%%%%%

for i=1:1:w
        if i==1 
                for j=1:1:w     
                    if j==1
                            result(i,j)=pe1(input(1,1));  
                    elseif j==w
                            result(i,j)=pe2(input(1,j/2),0);                    
                    elseif j>1 && mod(j,2)==0 
                            result(i,j)=pe2(input(1,j/2),input(1,j/2+1));                 
                    elseif j>1 && mod(j,2)==1 
                            result(i,j)=pe1(input(1,(j+1)/2)); 
                    end
                end       
        elseif i==w
                for j=1:1:w     
                    if j==1 
                            result(i,j)=pe3(input(i/2,1),0);    
                    elseif j==w
                            result(i,j)=pe4(input(i/2,j/2),0,0,0);                    
                    elseif j>1 && mod(j,2)==0 
                            result(i,j)=pe4(input(i/2,j/2),input(i/2,j/2+1),0,0);
                    elseif j>1 && mod(j,2)==1 
                            result(i,j)=pe3(input(i/2,(j+1)/2),0);
                    end
                end
        elseif i>1 && mod(i,2)==0
                for j=1:1:w   
                    if j==1 
                            result(i,j)=pe3(input(i/2,1),input(i/2+1,1));    
                    elseif j==w
                            result(i,j)=pe4(input(i/2,j/2),0,input(i/2+1,j/2),0);                    
                    elseif j>1 && mod(j,2)==0 
                            result(i,j)=pe4(input(i/2,j/2),input(i/2,j/2+1),input(i/2+1,j/2),input(i/2+1,j/2+1));
                    elseif j>1 && mod(j,2)==1 
                            result(i,j)=pe3(input(i/2,(j+1)/2),input(i/2+1,(j+1)/2));
                    end
                end 
         elseif i>1 && mod(i,2)==1
                for j=1:1:w     
                    if j==1
                            result(i,j)=pe1(input((i+1)/2,1));  
                    elseif j==w
                            result(i,j)=pe2(input((1+i)/2,j/2),0);                    
                    elseif j>1 && mod(j,2)==0 
                            result(i,j)=pe2(input((1+i)/2,j/2),input((1+i)/2,j/2+1));                 
                    elseif j>1 && mod(j,2)==1 
                            result(i,j)=pe1(input((1+i)/2,(j+1)/2)); 
                    end
                end        
        end
end




%%%%%%%%%%%%%%%%%%%  extend image
ectend_im=rand(66,66);
i_src=1;
j_src=1;
for j=1:66
   for i=1:66
       ectend_im(i,j)=0;     
   end
end
for j=2:2:65 %64-65 128-129 256-257
    
   for i=2:2:65
       ectend_im(i,j)=input(i_src,j_src);
       i_src=i_src+1;
       
   end
   j_src=j_src+1;
   i_src=1;
end


%%%%%%%%%%%%%%%%%%%%
k3_1=[-0.3081858 -0.10534405 0.64513654; 
          0.60798633 0.31159636  0.3837524;
          0.7219356 0.377903 0.13250548];   

k3_2=[-0.64444816 -0.06277101 0.17268254; 
          -0.4636364 -0.14195922  0.13072383;
          -0.53896284 -0.49845114 -0.29156035]; 

k3_3=[-0.3081858 -0.10534405 0.64513654; 
          0.60798633 0.31159636  0.3837524;
          0.7219356 0.377903 0.13250548];    

      
      
k3_4 =[0.16091657 -0.51409566 0.193108; 
          -0.53862643 0.16649093  -0.09471586;
          0.119229 -0.22878562 0.19257468];

%%%%%%%%%%%%%%%%%%%%
pic_dst_0=conv2(ectend_im,k3_1,'valid');

F_result=(result)/2048;
compare=pic_dst_0-F_result;
b1=reshape(compare,1,4096);
MSE_1 = sum(sum((b1).^2))/(4096);
RMSe1 = sqrt(MSE_1);
PSNR_1 = psnr(pic_dst_0,F_result,511);
%%%%%%%%%%%%%%%%%%%%



%%%%four PE %%%%
function result1 = pe1(din1)
% 12-bit kernel value
    k3=[271, 774, 1479;
        786, 638, 1245;
        1321, -216, -631];
    result1 = k3(2,2)*din1;%k5
end

function result2 = pe2(din1,din2)
% 12-bit kernel value
    k3=[271, 774, 1479;
        786, 638, 1245;
        1321, -216, -631];
    result2 = k3(2,1)*din1+k3(2,3)*din2;%  k4  k6
end

function result3 = pe3(din1,din2)
% 12-bit kernel value
    k3=[271, 774, 1479;
        786, 638, 1245;
        1321, -216, -631];
    result3 = k3(1,2)*din1+k3(3,2)*din2;% k2  k8 
end


function result4 = pe4(din1,din2,din3,din4)
% 12-bit kernel value
    k3=[271, 774, 1479;
        786, 638, 1245;
        1321, -216, -631];
    result4 = k3(1,1)*din1+k3(1,3)*din2+k3(3,1)*din3+k3(3,3)*din4;% k1  k3   k7  k9
end