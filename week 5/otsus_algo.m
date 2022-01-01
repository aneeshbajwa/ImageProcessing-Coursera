function [level] = otsus_algo(I)
% To find the otsu threshhold for an image
% I -> Image
% level -> threshold obtaind by otsu's algorithm

N = 256;

p = imhist(I)/numel(I);%numel returns no of array elements

% s_between(t)^2 = q1(t) * q2(t) * [mu1(t) - mu2(t)]^2

%             t
%           -----
%           \
%   q1(t) =  >    p(t)                           
%           /
%           -----
%            i=1
%
%             N
%           -----
%           \
%   q2(t) =  >    p(t)                            
%           /
%           -----
%           i=t+1
%
                  

q1 = 0;
mu1 = 0;
q2 = 1;
mu2 =  ( 0 : (N-1) ) * p;
level = 0;
s_between_max = 0;
for t = 1:N
    
    q1n = q1 + p(t);
    q2n = q2 - p(t);
    
        %               mu1(t) * q1(t) + (t) * p(t+1)
    %   mu1(t+1) = -------------------------------
    %                        q1(t+1)
    
    %               mu2(t) * q2(t) - (t) * p(t+1)
    %   mu2(t+1) = ------------------------------- 
    %                        q2(t+1)
    
    
    
    % if not take muB&muF to be zero in some cases then level will remain zero
    if (q1n ~= 0 )
        mu1 = (mu1*q1 + (t-1)*p(t)) / q1n;
    else
        mu1 = 0;
    end  % if
    
    if (q2n ~= 0 )
        mu2 = (mu2*q2 - (t-1)*p(t)) / q2n;
    else
        mu2 = 0;
    end 
    
    q1 = q1n;
    q2 = q2n;
    
    % Between class variance for the current 't':
    s_between = q1 * q2 * (mu1-mu2)^2;
    
    % Update it if it is greater than the greatest between class variance
    % so far:
    if ( s_between > s_between_max )
        level = (t-1)/256;
        s_between_max = s_between;
    end 
    
end


end
