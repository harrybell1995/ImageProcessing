clear; close all; clc;
%Step 1: Load image
I = imread('Starfish.jpg');
figure;
imshow(I);
title('Image-1: Load input image');

%Step 2: Convert to grayscale
I = rgb2gray(I);
figure;
imshow(I);
title('Image-2: Convert to grayscale');

%Step 3: filter out noise from image using median filter
I = medfilt2(I);
figure;
imshow(I);
title('Image-3: Remove noise');

%Step 4: Smooth intensity curve
I = imgaussfilt(I, 1.1);
%stretch intensitys between the range of 153 and 235 as thats where the
%starfish intenstiy is 
I = imadjust(I, [.6 .92], [0 1]);
figure;
imshow(I);
title('Image-4: Stretch intensity curve');

%Step 5: Turn image into a binary image with a threshold of 0.8
T = imbinarize(I,0.80);
figure;
imshow(T);
title('Image-5: Binarize the image with a value of 0.80');

%Step 6: Invert image
T = imcomplement(T);
figure;
imshow(T);
title('Image-6: Invert so ones become objects');

%Step 7: Filter all objects that arent in the area range of 750 to 900 out of the
%image
BW2 = bwareafilt(T,[750, 900]);
figure;
imshow(BW2);
title('Image-7: Only show objects with area 750 to 900');

