%Apply any image predictor as those we learned in Week 2. Plot the
%histogram 
%of the prediction error. Try to fit a 
%function to it to learn what type of distribution best first the prediction error.
%predictor on basis of prev value 
image = imread('fruits.jpeg');
I = rgb2gray(image);
I = imnoise(I,'gaussian',0.05);
[rows,cols] = size(I);
err = zeros(rows,cols);
for i = 1:rows
    for j = 1:cols
        if(i>1)
            err(i,j) = I(i,j) - I(i-1,j);
        end
        %error matrix
    end
end
%create histogram 
no_of_pixels = 256;
h = zeros(2,2*no_of_pixels-1);
for i = -255:255
    h(1,i+no_of_pixels) = i;
end

min_error = min(min(err));
max_error = max(max(err));
%h(2,:) have no of occurences for each error value
for v = min_error:max_error
    h(2,no_of_pixels+v) = sum(sum(err == v));
end
stem(h(1,:),h(2,:))