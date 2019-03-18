% MATLAB script for Assessment Item-1
% Task-2
clear; close all; clc;

% Step-1: Load input image
I = imread('Noisy.png');
figure;
imshow(I);
title('Image-1: Load input image');

% Step-2: Conversion of input image to grey-scale image
Igray = rgb2gray(I);

%Pad the image 
Igray = padarray(Igray,[4,4]);

%Convert to uint8
Igray = uint8(Igray);

%Create a new matrix for image to be entered into
I = zeros(482,764,'uint8');

%Loop for each row and collumn
for row = 1:482
    for col = 1:764
        %if the row or col is in the padding black pixels then dont use the
        %mask just allocate a 0 intesity pixel
        if (row <= 2) || (col <= 2) || col >= 763 || row >= 481
            I(row, col) = 0;
        else
            %create a mask of 5x5 size
            mask = ones(5, 5);
            %loop each pixel in the mask
            for x = 1:5
                for y = 1:5
                    %1 - 3 is -2, which is the correct place to start the
                    %mask. -2, -2 is the top left pixel
                    newx = x - 3;
                    newy = y - 3;
                    %allocate the pixel values 
                    mask (x, y) = Igray(row - newx, col - newy);
                end
            end
            %remove 0's for the edges of the image
            A = mask(mask ~= 0);
            B = reshape(A,1,[]);
            %find amount of pixels to average from by converting mask into
            %a vector
            S = length(B);
            %add all pixels, then divide by amount of pixels
            H = sum(A) / S;
            %allocate new pixel with the intensity of the average value
            I(row, col) = H;
        end
    end
end

figure;
imshow(I);
title('Image-2: Mean Filtered');

%another new image container
J = zeros(482,764,'uint8');

%another loop for the pixel values of the image
for row = 1:482
    for col = 1:764
        %same as loop above, if its black dont run the filter
        if (row <= 2) || (col <= 2) || col >= 763 || row >= 481
            J(row, col) = 0;
        else
            %
            mask = zeros(5, 5);
            for x = 1:5
                for y = 1:5
                    newx = x - 3;
                    newy = y - 3;
                    mask (x, y) = Igray(row - newx, col - newy);
                end
            end
            
            S = mask(mask ~= 0);
            S = sort(S, 'descend');
            A = S(ceil(end/2), :);
            J(row, col) = A;
        end
    end
end

figure;
imshow(J);
title('Image-3: Median Filtered');

figure;
imshowpair(I, J, 'montage');
title('Image-4: Both filtered images');
