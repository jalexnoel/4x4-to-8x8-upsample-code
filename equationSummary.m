
%%%%  previous defined %%%%
n = 32;  %input size
k = 7;  %kernel size
beta = 2;
DCMdelay =3;
D = 3;  %number of layer
%%%%%%%%%%%%%%%%%%%%%%%%%%


%%%% equation 16 - 19 %%%%
N =(2*n-1-1)/2;

Tct = 2*n+n*N;

theta = ceil((k+1)/4)+1;

Ttotal = Tct + theta;

%%%% equation 20 %%%%

Tr = (2^D * n)^2;

Tp = D*(beta + DCMdelay) + Tr;


%%%% equation 21 - 23 %%%%


OPmul = (n*k-(k-1)^2/8-(k-1)/4)^2;

OPadd = (n*k-(k-1)^2/8-(k-1)/4)^2-4*n^2;

OPtotal = OPmul+ OPadd;