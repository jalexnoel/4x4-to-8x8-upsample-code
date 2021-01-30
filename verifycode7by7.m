
format('short');

% input image
input_1=imread('H:\picture\face\randomImage128.bmp');
input=double(input_1(:,:,1));

% creat result matrix
result7 = rand(256,256);
w=256;% result width


% computation
for i=1:1:w    
        if i==1 
                for j=1:1:w 
                    if j==1
                            result7(i,j)=pe1(0,0,0,0,input(1,1),input(1,2),0,input(2,1),input(2,2)); 
                    elseif j==2
                            result7(i,j)=pe2(0,0,0,0,0,input(1,1),input(1,2),input(1,3),0,input(2,1),input(2,2),input(2,3)); 
                    elseif j==(w-2)
                            result7(i,j)=pe2(0,0,0,0,input(1,j/2-1),input(1,j/2),input(1,j/2+1),0,input(2,j/2-1),input(2,j/2),input(2,j/2+1),0);
                    elseif j==(w-1)
                            result7(i,j)=pe1(0,0,0,input(1,(j+1)/2-1),input(1,(j+1)/2),0,input(2,(j+1)/2-1),input(2,(j+1)/2),0);
                    elseif j==w
                            result7(i,j)=pe2(0,0,0,0,input(1,j/2-1),input(1,j/2),0,0,input(2,j/2-1),input(2,j/2),0,0);                    
                    elseif j>1 && mod(j,2)==0 
                            result7(i,j)=pe2(0,0,0,0,input(1,j/2-1),input(1,j/2),input(1,j/2+1),input(1,j/2+2),input(2,j/2-1),input(2,j/2),input(2,j/2+1),input(2,j/2+2));                  
                    elseif j>1 && mod(j,2)==1 
                            result7(i,j)=pe1(0,0,0,input(1,(j+1)/2-1),input(1,(j+1)/2),input(1,(j+1)/2+1),input(2,(j+1)/2-1),input(2,(j+1)/2),input(2,(j+1)/2+1)); 
                    end

                end
        elseif i==2
                for j=1:1:w     
                    if j==1
                            result7(i,j)=pe3(0,0,0,0,input(1,1),input(1,2),0,input(2,1),input(2,2),0,input(3,1),input(3,2)); 
                    elseif j==2
                            result7(i,j)=pe4(0,0,0,0,0,input(1,1),input(1,2),input(1,3),0,input(2,1),input(2,2),input(2,3),0,input(3,1),input(3,2),input(3,3)); 
                    elseif j==(w-2)
                            result7(i,j)=pe4(0,0,0,0,input(1,j/2-1),input(1,j/2),input(1,j/2+1),0,input(2,j/2-1),input(2,j/2),input(2,j/2+1),0,input(3,j/2-1),input(3,j/2),input(3,j/2+1),0);
                    elseif j==(w-1)
                            result7(i,j)=pe3(0,0,0,input(1,(j+1)/2-1),input(1,(j+1)/2),0,input(2,(j+1)/2-1),input(2,(j+1)/2),0,input(3,(j+1)/2-1),input(3,(j+1)/2),0);
                    elseif j==w
                            result7(i,j)=pe4(0,0,0,0,input(1,j/2-1),input(1,j/2),0,0,input(2,j/2-1),input(2,j/2),0,0,input(3,j/2-1),input(3,j/2),0,0);                    
                    elseif j>1 && mod(j,2)==0 
                            result7(i,j)=pe4(0,0,0,0,input(1,j/2-1),input(1,j/2),input(1,j/2+1),input(1,j/2+2),input(2,j/2-1),input(2,j/2),input(2,j/2+1),input(2,j/2+2),input(3,j/2-1),input(3,j/2),input(3,j/2+1),input(3,j/2+2));                  
                    elseif j>1 && mod(j,2)==1 
                            result7(i,j)=pe3(0,0,0,input(1,(j+1)/2-1),input(1,(j+1)/2),input(1,(j+1)/2+1),input(2,(j+1)/2-1),input(2,(j+1)/2),input(2,(j+1)/2+1),input(3,(j+1)/2-1),input(3,(j+1)/2),input(3,(j+1)/2+1)); 
                    end                    
                end
        
        elseif i==(w-2)
                for j=1:1:w     
                    if j==1
                            result7(i,j)=pe3(0,input(i/2-1,1),input(i/2-1,2),0,input(i/2,1),input(i/2,2),0,input(i/2+1,1),input(i/2+1,2),0,0,0); 
                    elseif j==2
                            result7(i,j)=pe4(0,input(i/2-1,1),input(i/2-1,2),input(i/2-1,3),0,input(i/2,1),input(i/2,2),input(i/2,3),0,input(i/2+1,1),input(i/2+1,2),input(i/2+1,3),0,0,0,0); 
                    elseif j==(w-2)
                            result7(i,j)=pe4(input(i/2-1,j/2-1),input(i/2-1,j/2),input(i/2-1,j/2+1),0,input(i/2,j/2-1),input(i/2,j/2),input(i/2,j/2+1),0,input(i/2+1,j/2-1),input(i/2+1,j/2),input(i/2+1,j/2+1),0,0,0,0,0);
                    elseif j==(w-1)
                            result7(i,j)=pe3(input(i/2-1,(j+1)/2-1),input(i/2-1,(j+1)/2),0,input(i/2,(j+1)/2-1),input(i/2,(j+1)/2),0,input(i/2+1,(j+1)/2-1),input(i/2+1,(j+1)/2),0,0,0,0);
                    elseif j==w
                            result7(i,j)=pe4(input(i/2-1,j/2-1),input(i/2-1,j/2),0,0,input(i/2,j/2-1),input(i/2,j/2),0,0,input(i/2+1,j/2-1),input(i/2+1,j/2),0,0,0,0,0,0);                    
                    elseif j>1 && mod(j,2)==0 
                            result7(i,j)=pe4(input(i/2-1,j/2-1),input(i/2-1,j/2),input(i/2-1,j/2+1),input(i/2-1,j/2+2),input(i/2,j/2-1),input(i/2,j/2),input(i/2,j/2+1),input(i/2,j/2+2),input(i/2+1,j/2-1),input(i/2+1,j/2),input(i/2+1,j/2+1),input(i/2+1,j/2+2),0,0,0,0);                  
                    elseif j>1 && mod(j,2)==1 
                            result7(i,j)=pe3(input(i/2-1,(j+1)/2-1),input(i/2-1,(j+1)/2),input(i/2-1,(j+1)/2+1),input(i/2,(j+1)/2-1),input(i/2,(j+1)/2),input(i/2,(j+1)/2+1),input(i/2+1,(j+1)/2-1),input(i/2+1,(j+1)/2),input(i/2+1,(j+1)/2+1),0,0,0); 
                    end
                end
        elseif i==(w-1)
                for j=1:1:w
                    if j==1
                            result7(i,j)=pe1(0,input((i+1)/2-1,1),input((i+1)/2-1,2),0,input((i+1)/2,1),input((i+1)/2,2),0,0,0); 
                    elseif j==2
                            result7(i,j)=pe2(0,input((i+1)/2-1,1),input((i+1)/2-1,2),input((i+1)/2-1,3),0,input((i+1)/2,1),input((i+1)/2,2),input((i+1)/2,3),0,0,0,0); 
                    elseif j==(w-2)
                            result7(i,j)=pe2(input((i+1)/2-1,j/2-1),input((i+1)/2-1,j/2),input((i+1)/2-1,j/2+1),0,input((i+1)/2,j/2-1),input((i+1)/2,j/2),input((i+1)/2,j/2+1),0,0,0,0,0);
                    elseif j==(w-1)
                            result7(i,j)=pe1(input((i+1)/2-1,(j+1)/2-1),input((i+1)/2-1,(j+1)/2),0,input((i+1)/2,(j+1)/2-1),input((i+1)/2,(j+1)/2),0,0,0,0);
                    elseif j==w
                            result7(i,j)=pe2(input((i+1)/2-1,j/2-1),input((i+1)/2-1,j/2),0,0,input((i+1)/2,j/2-1),input((i+1)/2,j/2),0,0,0,0,0,0);                    
                    elseif j>1 && mod(j,2)==0 
                            result7(i,j)=pe2(input((i+1)/2-1,j/2-1),input((i+1)/2-1,j/2),input((i+1)/2-1,j/2+1),input((i+1)/2-1,j/2+2),input((i+1)/2,j/2-1),input((i+1)/2,j/2),input((i+1)/2,j/2+1),input((i+1)/2,j/2+2),0,0,0,0);                  
                    elseif j>1 && mod(j,2)==1 
                            result7(i,j)=pe1(input((i+1)/2-1,(j+1)/2-1),input((i+1)/2-1,(j+1)/2),input((i+1)/2-1,(j+1)/2+1),input((i+1)/2,(j+1)/2-1),input((i+1)/2,(j+1)/2),input((i+1)/2,(j+1)/2+1),0,0,0); 
                    end    
                end
        elseif i==w
                for j=1:1:w     
                    if j==1
                            result7(i,j)=pe3(0,input(i/2-1,1),input(i/2-1,2),0,input(i/2,1),input(i/2,2),0,0,0,0,0,0); 
                    elseif j==2
                            result7(i,j)=pe4(0,input(i/2-1,1),input(i/2-1,2),input(i/2-1,3),0,input(i/2,1),input(i/2,2),input(i/2,3),0,0,0,0,0,0,0,0); 
                    elseif j==(w-2)
                            result7(i,j)=pe4(input(i/2-1,j/2-1),input(i/2-1,j/2),input(i/2-1,j/2+1),0,input(i/2,j/2-1),input(i/2,j/2),input(i/2,j/2+1),0,0,0,0,0,0,0,0,0);
                    elseif j==(w-1)
                            result7(i,j)=pe3(input(i/2-1,(j+1)/2-1),input(i/2-1,(j+1)/2),0,input(i/2,(j+1)/2-1),input(i/2,(j+1)/2),0,0,0,0,0,0,0);
                    elseif j==w
                            result7(i,j)=pe4(input(i/2-1,j/2-1),input(i/2-1,j/2),0,0,input(i/2,j/2-1),input(i/2,j/2),0,0,0,0,0,0,0,0,0,0);                    
                    elseif j>1 && mod(j,2)==0 
                            result7(i,j)=pe4(input(i/2-1,j/2-1),input(i/2-1,j/2),input(i/2-1,j/2+1),input(i/2-1,j/2+2),input(i/2,j/2-1),input(i/2,j/2),input(i/2,j/2+1),input(i/2,j/2+2),0,0,0,0,0,0,0,0);                  
                    elseif j>1 && mod(j,2)==1 
                            result7(i,j)=pe3(input(i/2-1,(j+1)/2-1),input(i/2-1,(j+1)/2),input(i/2-1,(j+1)/2+1),input(i/2,(j+1)/2-1),input(i/2,(j+1)/2),input(i/2,(j+1)/2+1),0,0,0,0,0,0); 
                    end                                       
                end
         elseif i>1 && mod(i,2)==1
                for j=1:1:w     
                    if j==1
                            result7(i,j)=pe1(0,input((i+1)/2-1,1),input((i+1)/2-1,2),0,input((i+1)/2,1),input((i+1)/2,2),0,input((i+1)/2+1,1),input((i+1)/2+1,2)); 
                    elseif j==2
                            result7(i,j)=pe2(0,input((i+1)/2-1,1),input((i+1)/2-1,2),input((i+1)/2-1,3),0,input((i+1)/2,1),input((i+1)/2,2),input((i+1)/2,3),0,input((i+1)/2+1,1),input((i+1)/2+1,2),input((i+1)/2+1,3)); 
                    elseif j==(w-2)
                            result7(i,j)=pe2(input((i+1)/2-1,j/2-1),input((i+1)/2-1,j/2),input((i+1)/2-1,j/2+1),0,input((i+1)/2,j/2-1),input((i+1)/2,j/2),input((i+1)/2,j/2+1),0,input((i+1)/2+1,j/2-1),input((i+1)/2+1,j/2),input((i+1)/2+1,j/2+1),0);
                    elseif j==(w-1)
                            result7(i,j)=pe1(input((i+1)/2-1,(j+1)/2-1),input((i+1)/2-1,(j+1)/2),0,input((i+1)/2,(j+1)/2-1),input((i+1)/2,(j+1)/2),0,input((i+1)/2+1,(j+1)/2-1),input((i+1)/2+1,(j+1)/2),0);
                    elseif j==w
                            result7(i,j)=pe2(input((i+1)/2-1,j/2-1),input((i+1)/2-1,j/2),0,0,input((i+1)/2,j/2-1),input((i+1)/2,j/2),0,0,input((i+1)/2+1,j/2-1),input((i+1)/2+1,j/2),0,0);                    
                    elseif j>1 && mod(j,2)==0 
                            result7(i,j)=pe2(input((i+1)/2-1,j/2-1),input((i+1)/2-1,j/2),input((i+1)/2-1,j/2+1),input((i+1)/2-1,j/2+2),input((i+1)/2,j/2-1),input((i+1)/2,j/2),input((i+1)/2,j/2+1),input((i+1)/2,j/2+2),input((i+1)/2+1,j/2-1),input((i+1)/2+1,j/2),input((i+1)/2+1,j/2+1),input((i+1)/2+1,j/2+2));                  
                    elseif j>1 && mod(j,2)==1 
                            result7(i,j)=pe1(input((i+1)/2-1,(j+1)/2-1),input((i+1)/2-1,(j+1)/2),input((i+1)/2-1,(j+1)/2+1),input((i+1)/2,(j+1)/2-1),input((i+1)/2,(j+1)/2),input((i+1)/2,(j+1)/2+1),input((i+1)/2+1,(j+1)/2-1),input((i+1)/2+1,(j+1)/2),input((i+1)/2+1,(j+1)/2+1)); 
                    end

                end
        elseif i>1 && mod(i,2)==0
                for j=1:1:w     
                    if j==1
                            result7(i,j)=pe3(0,input(i/2-1,1),input(i/2-1,2),0,input(i/2,1),input(i/2,2),0,input(i/2+1,1),input(i/2+1,2),0,input(i/2+2,1),input(i/2+2,2)); 
                    elseif j==2
                            result7(i,j)=pe4(0,input(i/2-1,1),input(i/2-1,2),input(i/2-1,3),0,input(i/2,1),input(i/2,2),input(i/2,3),0,input(i/2+1,1),input(i/2+1,2),input(i/2+1,3),0,input(i/2+2,1),input(i/2+2,2),input(i/2+2,3)); 
                    elseif j==(w-2)
                            result7(i,j)=pe4(input(i/2-1,j/2-1),input(i/2-1,j/2),input(i/2-1,j/2+1),0,input(i/2,j/2-1),input(i/2,j/2),input(i/2,j/2+1),0,input(i/2+1,j/2-1),input(i/2+1,j/2),input(i/2+1,j/2+1),0,input(i/2+2,j/2-1),input(i/2+2,j/2),input(i/2+2,j/2+1),0);
                    elseif j==(w-1)
                            result7(i,j)=pe3(input(i/2-1,(j+1)/2-1),input(i/2-1,(j+1)/2),0,input(i/2,(j+1)/2-1),input(i/2,(j+1)/2),0,input(i/2+1,(j+1)/2-1),input(i/2+1,(j+1)/2),0,input(i/2+2,(j+1)/2-1),input(i/2+2,(j+1)/2),0);
                    elseif j==w
                            result7(i,j)=pe4(input(i/2-1,j/2-1),input(i/2-1,j/2),0,0,input(i/2,j/2-1),input(i/2,j/2),0,0,input(i/2+1,j/2-1),input(i/2+1,j/2),0,0,input(i/2+2,j/2-1),input(i/2+2,j/2),0,0);                    
                    elseif j>1 && mod(j,2)==0 
                            result7(i,j)=pe4(input(i/2-1,j/2-1),input(i/2-1,j/2),input(i/2-1,j/2+1),input(i/2-1,j/2+2),input(i/2,j/2-1),input(i/2,j/2),input(i/2,j/2+1),input(i/2,j/2+2),input(i/2+1,j/2-1),input(i/2+1,j/2),input(i/2+1,j/2+1),input(i/2+1,j/2+2),input(i/2+2,j/2-1),input(i/2+2,j/2),input(i/2+2,j/2+1),input(i/2+2,j/2+2));                  
                    elseif j>1 && mod(j,2)==1 
                            result7(i,j)=pe3(input(i/2-1,(j+1)/2-1),input(i/2-1,(j+1)/2),input(i/2-1,(j+1)/2+1),input(i/2,(j+1)/2-1),input(i/2,(j+1)/2),input(i/2,(j+1)/2+1),input(i/2+1,(j+1)/2-1),input(i/2+1,(j+1)/2),input(i/2+1,(j+1)/2+1),input(i/2+2,(j+1)/2-1),input(i/2+2,(j+1)/2),input(i/2+2,(j+1)/2+1)); 
                    end                    
                end       
        end
end


%%%%%%%%%%%%%%%%%%%%
ectend_im=rand(262,262); % create extend image 

for j=1:262
   for i=1:262
       ectend_im(i,j)=0;     
   end
end
i_src=1;
j_src=1;
for i=4:2:259   %64-67 128-131 256-259
    
   for j=4:2:259
       ectend_im(i,j)=input(j_src,i_src);
       i_src=i_src+1;       
   end
   j_src=j_src+1;
   i_src=1;
end

%original kernel
k7_1= [0.39472,0.81682,0.90759,0.60466,0.84234,0.5933,0.93146;
       0.20672,0.23103,0.38088,0.43332,0.65549,0.17684,0.68075;
       0.20786,0.89973,0.72526,0.20345,0.11409,0.98963,0.15702;
       0.22669,0.86165,0.25599,0.86624,0.89057,0.61963,0.64939;
       0.35785,0.41779,0.10363,0.19041,0.60134,0.81727,0.27057;
       0.23066,0.85413,0.57259,0.36309,0.17781,0.03629,0.84022;
       0.96893,0.19821,0.24863,0.14144,0.59314,0.44285,0.16618];

k7_2=[0.33051094,0.10673218,0.05013331,0.12861225,0.50127095,0.5246594,0.07500438;
       0.42310557,0.12748237,0.4353789,0.42978293,0.34391433,0.38301912,0.1816853;
       0.28788945,0.06225649,0.40983698,0.46752962,0.23085538,0.09532151,0.21057223;
       0.301026,0.14912336,0.10052594,0.07373565,0.44789845,0.35394394,0.45623922;
       0.31702736,0.46058732,0.3625885,0.05765626,0.3156168,0.13739912,0.15602818;
       0.3201534,0.37335616,0.19527644,0.49341854,0.38085836,0.4791964,0.08726056;
       0.10770901,0.15217789,0.4561706,0.28341985,0.2893898,0.51527923,0.06207731]; 
   
k7_3=[0.3330938,0.41524026,0.17674299,0.3882037,0.320235730,0.11810157,0.25461292;
    0.22985801,0.22337542,0.5316171,0.4433579,0.10363182,0.48868066,0.5295713;
    0.43802425,0.48757213,0.05176888,0.35199302,0.3340689,0.41745934,0.4070925;
    0.04061552,0.520719,0.40770584,0.2337705,0.45601314,0.3661271,0.5227249;
    0.24683578,0.46223426,0.34606037,0.52677226,0.1068985,0.0657221,0.06747539;
    0.4579608,0.43500355,0.13553518,0.34246337,0.43974382,0.25248194,0.24043046;
    0.28089997,0.23432288,0.26317424,0.12313879,0.14707908,0.33872637,0.29625517];   

k7_4=[0.35375357,-0.05216091,0.02137527,-0.07342049,-0.0063364,-0.26084793,0.12952916;
    -0.10091413,-0.275059580,-0.04002069,-0.44667605,0.20199534,-0.46372077,-0.0164096;
    0.19211417,-0.12038646,0.08610587,0.02412038,0.15704784,-0.0316366,0.41212186;
    0.02051753,-0.12508357,-0.00668782,-0.31517583,-0.12440626,-0.09615263,0.00248853;
    0.3812805,0.01853922,0.06026622,-0.1398631,0.13830628,-0.00137337,0.10158557;
    0.06072693,-0.14443825,-0.03001859,-0.22082204,-0.20725305,-0.33614317,0.2296806;
    0.04981431,-0.3145547,0.34037316,-0.4020002,0.39035714,-0.16993718,0.17800097];   
   
pic_dst_0=conv2(ectend_im,k7_1,'valid');
%%%%%%%%%%%%%%%%%%%%

F_result=(result7)/2048;
compare=pic_dst_0-F_result;
b1=reshape(compare,1,65536);
MSE_1 = sum(sum((b1).^2))/(65536);
RMSe1 = sqrt(MSE_1);
PSNR_1 = psnr(pic_dst_0,F_result,511);
%%%%%%%%%%%%%%%%%%%%


%%%% four PEs %%%%
function result1 = pe1(din1,din2,din3,din4,din5,din6,din7,din8,din9)
    % 12-bit kernel value 
    k7=[340,907,1215,290,509,406,1984;
        1721,74,364,744,1173,1749,472;
        554,1674,1232,390,212,856,733;
        1330,1269,1824,1774,524,1765,464;
        322,2027,234,417,1485,1843,426;
        1394,362,1342,887,780,473,423;
        1908,1215,1725,1238,1859,1673,808];
    result1 = k7(2,2)*din1+k7(2,4)*din2+k7(2,6)*din3+k7(4,2)*din4+k7(4,4)*din5+k7(4,6)*din6+k7(6,2)*din7+k7(6,4)*din8+k7(6,6)*din9;
end

function result2 = pe2(din1,din2,din3,din4,din5,din6,din7,din8,din9,din10,din11,din12)
    % 12-bit kernel value
    k7=[340,907,1215,290,509,406,1984;
        1721,74,364,744,1173,1749,472;
        554,1674,1232,390,212,856,733;
        1330,1269,1824,1774,524,1765,464;
        322,2027,234,417,1485,1843,426;
        1394,362,1342,887,780,473,423;
        1908,1215,1725,1238,1859,1673,808];
    result2 = k7(2,1)*din1+k7(2,3)*din2+k7(2,5)*din3+k7(2,7)*din4+k7(4,1)*din5+k7(4,3)*din6+k7(4,5)*din7+k7(4,7)*din8+k7(6,1)*din9+k7(6,3)*din10+k7(6,5)*din11+k7(6,7)*din12;
end

function result3 = pe3(din1,din2,din3,din4,din5,din6,din7,din8,din9,din10,din11,din12)
    % 12-bit kernel value
    k7=[340,907,1215,290,509,406,1984;
        1721,74,364,744,1173,1749,472;
        554,1674,1232,390,212,856,733;
        1330,1269,1824,1774,524,1765,464;
        322,2027,234,417,1485,1843,426;
        1394,362,1342,887,780,473,423;
        1908,1215,1725,1238,1859,1673,808];
    result3 = k7(1,2)*din1+k7(1,4)*din2+k7(1,6)*din3+k7(3,2)*din4+k7(3,4)*din5+k7(3,6)*din6+k7(5,2)*din7+k7(5,4)*din8+k7(5,6)*din9+k7(7,2)*din10+k7(7,4)*din11+k7(7,6)*din12;
end


function result4 = pe4(din1,din2,din3,din4,din5,din6,din7,din8,din9,din10,din11,din12,din13,din14,din15,din16)
    % 12-bit kernel value
    k7=[340,907,1215,290,509,406,1984;
        1721,74,364,744,1173,1749,472;
        554,1674,1232,390,212,856,733;
        1330,1269,1824,1774,524,1765,464;
        322,2027,234,417,1485,1843,426;
        1394,362,1342,887,780,473,423;
        1908,1215,1725,1238,1859,1673,808];
    result4 = k7(1,1)*din1+k7(1,3)*din2+k7(1,5)*din3+k7(1,7)*din4+k7(3,1)*din5+k7(3,3)*din6+k7(3,5)*din7+k7(3,7)*din8+k7(5,1)*din9+k7(5,3)*din10+k7(5,5)*din11+k7(5,7)*din12+k7(7,1)*din13+k7(7,3)*din14+k7(7,5)*din15+k7(7,7)*din16;
end