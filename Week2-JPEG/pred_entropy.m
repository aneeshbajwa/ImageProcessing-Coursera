function [H] = pred_entropy(image,method)
% Input:
%   image  - a matrix with image's pixels
%   method - prediction method (0: predict from the left neighbour,
%            1: predict from the right neighbour, 
%            2: predict from left, right and lower left neighbours)
%
% Return:
%   H-entropy
%
% An error is reported if 'method' is invalid.
[r,c] = size(image);
E = zeros(r,c);
%calculate error for each pixel
for x = 1:r
    for y = 1:c
        p = 0;
        %find value of the methods respective pixel 
        if(method == 0)
            %predict value using left neighbor
            if(y>1)
                p = image(x,y-1);
            end
            
            
            
        elseif(method == 1)
            if(y<c)
                p = image(x,y+1);
            end
            
            
            
        elseif(method == 2)
            if(y>1)
                p = p + image(x,y-1);
            end
            if(y<c)
                p = p + image(x,y+1);
            end
            if(y>1&&x<r)
                p = p + image(x+1,y-1);
            end
            
        end
        
        E(x,y) = uint8(p) - image(x,y)   
    end
end

%now count the frequenct of each error value
 depth = 256
 %error will lie in range -255 to +255
 h = zeros(2,2*depth-1);
 %first row of h will be filled by actual error values and second by no of
 %occurences
 h(1,:) = -255:255
 %first row is filled with all possible error values 
 min_error = min(min(E));
 max_error = max(max(E));
 for v = min_error:max_error
     h(2,depth+v) = sum(sum(E==v));
 end
 %now calculate probability of occurence of each error value
 s = sum(h(2,:));
 p = double(h(2,:))/double(s);
 % A logarithm will be applied on relative frequencies. As a logarithm of 0
% is not defined, all occurrences of 0 in 'p' will be replaced by 1
% (additionally this will evaluate such logarithms to 0):
 l = p;
 l(l==0)=1;
 
 H = -sum(p.*log2(l))

 
end
