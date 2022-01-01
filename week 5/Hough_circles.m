function[H,Cx,Cy,r] = Hough_circles(I)
% Implementation Of hough transform for circles
% I -> binary image 
% H -> 3D hough transform matrix
% Cx -> x co - ordinate of centre
% Cy -> y co - ordinate of centre
% R -> radius of circle

[rows,cols ] = size(I);

%ranges for each parametes - Cx, Cy, r
% given that each pixel represents a point on graph
Cx = 1 : rows;
Cy = 1 : cols;
r = 1:min(rows,cols);

%prelocate H -> the hough matrix
H = zeros(rows, cols, length(r));

% Now increement the discreetized boxes in H matrix for each possible
% combination of Cx, Cy and r
for x0 = 1 : length(Cx)
    for y0 = 1:length(Cy)
        for rad = 1:length(r)
            % (x-x0)^2 + (y-y0)^2 = rad^2
            % for different values of x find y
            %  x0 - rad < x < x0 + rad
            for x = max(x0 - rad,1) : min(x0 + rad,rows)
                % as x values should lie inside the image for a full circle
                % a = y - y0 or -a = y - y0
                a = sqrt(rad^2 - (x - x0)^2);
                % for both possibilities
                y1 = y0 + a;
                y2 = y0 - a;
                % check if y1 & y2 are within image range and then vote for
                % them in H matrix
                if (y1<= cols)
                    
                    H(x0,y0,rad) = H(x0,y0,rad)+1;
                end
                if (y2>=1)
                    H(x0,y0,rad) = H(x0,y0,rad)+1;
                end
        end
    end
end

end
