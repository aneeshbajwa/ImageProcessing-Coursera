I = imread("fruits.jpeg");
im = rgb2ycbcr(I);
%%
%For Y-Luma Component
iy = im(:,:,1);
N = 8;
[x,y] = size(iy);
NR = floor(x/N);
NC = floor(y/N);
Ty = zeros(NR*N,NC*N);
%DCT
for i = 1:NR
    for j = 1:NC
        subim = double(iy(1+(N*(i-1)):N*i, 1+N*(j-1):N*j));
        T(1+(N*(i-1)):N*i, 1+N*(j-1):N*j) = dct(subim);
    end
end
%Quantize for Y
Qy = zeros(NR*N,NC*N);
for i = 1:NR
    for j = 1:NC
        subim = T(1+(N*(i-1)):N*i, 1+N*(j-1):N*j);
        Q(1+(N*(i-1)):N*i, 1+N*(j-1):N*j) = round(subim./8).*8;
    end
end
%IDCT
IY = zeros(NR*N,NC*N);
for i = 1:NR
    for j = 1:NC
        subim = Q(1+(N*(i-1)):N*i, 1+N*(j-1):N*j);
        IY(1+(N*(i-1)):N*i, 1+N*(j-1):N*j) = idct(subim);
    end
end
imageY = uint8(IY);

%%
%For Cb-Blue Component
ib = im(:,:,2);
N = 8;
[x,y] = size(ib);
NR = floor(x/N);
NC = floor(y/N);
Tb = zeros(NR*N,NC*N);
%DCT
for i = 1:NR
    for j = 1:NC
        subim = double(ib(1+(N*(i-1)):N*i, 1+N*(j-1):N*j));
        Tb(1+(N*(i-1)):N*i, 1+N*(j-1):N*j) = dct(subim);
    end
end
%Quantize for Cb
Qb = zeros(NR*N,NC*N);
for i = 1:NR
    for j = 1:NC
        subim = Tb(1+(N*(i-1)):N*i, 1+N*(j-1):N*j);
        Qb(1+(N*(i-1)):N*i, 1+N*(j-1):N*j) = round(subim./16).*16;
    end
end
%IDCT
Ib = zeros(NR*N,NC*N);
for i = 1:NR
    for j = 1:NC
        subim = Qb(1+(N*(i-1)):N*i, 1+N*(j-1):N*j);
        Ib(1+(N*(i-1)):N*i, 1+N*(j-1):N*j) = idct(subim);
    end
end
imageB = uint8(Ib);

%%
%For Cr-Red Component
ir = im(:,:,3);
N = 8;
[x,y] = size(ib);
NR = floor(x/N);
NC = floor(y/N);
Tr = zeros(NR*N,NC*N);
%DCT
for i = 1:NR
    for j = 1:NC
        subim = double(ir(1+(N*(i-1)):N*i, 1+N*(j-1):N*j));
        Tr(1+(N*(i-1)):N*i, 1+N*(j-1):N*j) = dct(subim);
    end
end
%Quantize for Cb
Qr = zeros(NR*N,NC*N);
for i = 1:NR
    for j = 1:NC
        subim = Tr(1+(N*(i-1)):N*i, 1+N*(j-1):N*j);
        Qr(1+(N*(i-1)):N*i, 1+N*(j-1):N*j) = round(subim./16).*16;
    end
end
%IDCT
Ir = zeros(NR*N,NC*N);
for i = 1:NR
    for j = 1:NC
        subim = Qr(1+(N*(i-1)):N*i, 1+N*(j-1):N*j);
        Ir(1+(N*(i-1)):N*i, 1+N*(j-1):N*j) = idct(subim);
    end
end
imageR = uint8(Ir);

%%
%put ycbcr together

imageFinal(:,:,1) = imageY;
imageFinal(:,:,2) = imageB;
imageFinal(:,:,3) = imageR;
imshow(imageFinal)
imageFinalRGB = ycbcr2rgb(imageFinal);
imshowpair(imageFinalRGB,I,'montage')