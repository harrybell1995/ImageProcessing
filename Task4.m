%Step 1: Load image
I = imread('starfish.jpg');
figure;
imshow(I);
title('Image-1: Load input image');

%Step 2: Convert to grayscale
Igray = rgb2gray(I);
figure;
imshow(Igray);
title('Image-2: Convert to grayscale');

%Step 3: filter out noise from image using median filter
Imedian = medfilt2(Igray);
figure;
imshow(Imedian);
title('Image-3: Filter out noise with median filter');

figure;
imshowpair(Igray, Imedian, 'Montage');
title('Image 4: Comparison of unfiltered and filtered image');

%Step 4: Binarize image with a threshold of 0.9
BW = imbinarize(Imedian, 0.9);

%Step 5: Invert image
BW = ~BW ;

figure;
imshow(BW);
title('Image 5: Objects within threshold value');

label = bwlabel(BW);

%Step 6: Get Information on all objects in image
objects = regionprops(label, 'Area', 'Perimeter', 'Extent', 'Eccentricity',	'Orientation'	);
%Step 7: Create new tables with each objects extent (box around then white
%pixels within box) and perimiter (edge distance)
extent = [objects.Extent];
perimeter = [objects.Perimeter];

%Step 8: For each object found, calculate a value based on its extent and
%perimiter.
StarShape = zeros(length(objects), 1);
for i = 1 : length(StarShape)
    StarShape(i) = perimeter(i)/extent(i);
end

%Step 9: Find objects where previous calculation is between two values
ObjFind = find(( StarShape > 900)  & (StarShape < 1300));

%Step 10: Create image which contains objects found in both label and ObjFind 
BW3 = ismember(label, ObjFind);
objects = regionprops(BW3, 'Area', 'Perimeter', 'Extent', 'Eccentricity',	'Orientation'	);

figure;
imshow(BW3);
title('Image 6: Objects where perimiter/extent is > 900 & < 1300');