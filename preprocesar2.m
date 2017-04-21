

function preprocesar2(filename,filemask)

RGB1 = imread("images/21_training.tif");
A = rgb2gray(RGB1);
%imshow(A);
B = imread("mask/21_training_mask.gif");

I = single(B(:,:,1));

image2d(I > 254) = nan;
I
[rows cols depth]=size(B);
 for xAxis = 1 : rows          
     for yAxis = 1 : cols
     	if I(xAxis,yAxis) != nan
     		A(xAxis,yAxis) = nan;
     	end
        
     end
 end 



imwrite(B,"salidaB.png");
imwrite(A,"salidaA.png");

% See where all channels exceed (175, 255, 55) and 
% set image to black for those pixels. (untested)
% Extract the individual red, green, and blue color channels.
redChannel = A(:, :, 1);
greenChannel = A(:, :, 2);
blueChannel = A(:, :, 3);
% Threshold each at the particular color
binaryRed = redChannel > 175;
binaryGreen = greenChannel > 255;
binaryBlue = blueChannel > 55;
% Find where all exceed threshold.
mask = binaryRed & binaryGreen & binaryBlue;
% Mask image to be black there.
maskedRgbImage = bsxfun(@times, A, cast(mask,class(A)));
imshow(maskedRgbImage);