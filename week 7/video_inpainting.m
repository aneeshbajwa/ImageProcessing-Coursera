function [Vid] = video_inpainting(V,N)
% input -> V = video represented as a 4D matrix ,
%          N = No. frames to calculate median
% output -> Vid = inpainted video as a 4 D matrix
% Video inpainting on basis of median filtering
%The pixels in the region to be inpainted are replaced by the median of
%pixels in the same (x,y) spatial location and at different frames t 
%(median of (x,y,t) for t in some time interval with the current frame at its center).

%Total no of frames in the video
[~,~,~,nf] = size(V);
%prelocate Vid as a zeros matrix of size of V
Vid = zeros(size(V));

%iterate through each frame and calculate median
for x = 1:nf
    %calculating the first last frame to be included while calculating a
    %particular median
    fmin = max(1  , x-N/2);
    fmax = min(nf , x+N/2);
    
    %Taking median from frame fmin to fmax for ith frame in vid
    Vid = median(V(:,:,:,fmin:fmax),4)
end
end
