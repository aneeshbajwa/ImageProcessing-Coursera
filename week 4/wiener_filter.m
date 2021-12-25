%Practice with Wiener filtering. Consider for example a Gaussian blurring 
%and play with different values of K for different types and levels of noise.
function I = wiener_filter(img, H, K)
% img - degraded image
%H - filter of the type of noise
%K - ratio of PSD of noise and PSD of original image
% I - final image after applying wiener filtering


img = double(img);

%Dimensions of degreaderd img
[rows,cols] = size(img);

%Dimensions of filter H
[hr,hc] = size(H);

%Fourier transform if img
IMG = fft2(img);

%Changing size of filter mtrix to make it suitiable for loop limits
h = zeros(rows,cols);
[hr,hc] = size(H);
h(1:hr,1:hc) = H;

%Taking fourier transform
HF = fft2(h);

%
%               *    
% X(u,v) =     H(u,v)     . IMG(u,v)
%         --------------
%         |H(u,v)|^2 + K 

x = zeros(rows,cols);
for i = 1:rows
    for j = 1:cols
        x(i,j) = (conj(HF(i,j))/((abs(HF(i,j)))^2 + K))*IMG(i,j);
    end
end
%Takinf inverse fourier transform of the image
I = uint8(abs(ifft2(x)));
end
