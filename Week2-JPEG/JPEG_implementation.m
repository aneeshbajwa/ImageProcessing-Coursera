im = imread('cameraman.png');
[x,y] = size(im);
N = 8;
x0 = x + (N-mod(x,N));
y0 = y + (N-mod(y,N));
T = zeros(x0,y0)
NR = x/N;%no of blocks of 8 on row length
NC = y/N;%no of blocks of 8 on column length
%Taking DCT of 8x8 blocks
for i = 1:NR
    for j = 1:NC
        subim = double(im(1+N*(i-1):N*i , 1+N*(j-1):N*j));
        T(1+N*(i-1):N*i , 1+N*(j-1):N*j) = dct(subim);
    end
end
%T contains all the DCT coeff
%%
%quantizationof T matrix
Q = zeros(NR * N, NC * N);
Qm = [ 16, 11, 10, 16, 24, 40, 51, 61; 
       12, 12, 14, 19, 26, 58, 60, 55; 
       14, 13, 16, 24, 40, 57, 69, 56; 
       14, 17, 22, 29, 51, 87, 80, 62; 
       18, 22, 37, 56, 68, 109, 103, 77; 
       24, 35, 55, 64, 81, 104, 113, 92; 
       49, 64, 78, 87, 103, 121, 120, 101; 
       72, 92, 95, 98, 112, 100, 103, 99 ];%quantization matrix
for i = 1:NR
    for j = 1:NC
        subim = T(1+N*(i-1):N*i , 1+N*(j-1):N*j)
        Q(1+N*(i-1):N*i , 1+N*(j-1):N*j) = round(subim./Qm).*Qm;
    end
end
%%
%taking inverse DCT of image
image = zeros(NR*N,NC*N);
for i = 1:NR
    for j = 1:NC
        subim = Q(1+N*(i-1):N*i , 1+N*(j-1):N*j);
        image(1+N*(i-1):N*i , 1+N*(j-1):N*j) = idct(subim);
    end
end

imshowpair(im,image,'montage');
