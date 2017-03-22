%Toy example: apply SCIRD to corneal nerve fibres captured with IVCM
close all
clear all

I = imread('IVCM_130.jpg');

%single layer grayscale single precision
I = single(I(:,:,1));

%ridges color 'black' or 'white'
ridges_color = 'white';

%set filter bank parameters
fb_parameters.sigma_1 = [2 4];
fb_parameters.sigma_1_step = 1;
fb_parameters.sigma_2 = [2 3];
fb_parameters.sigma_2_step = 1;
fb_parameters.k = [-0.1 0.1];
fb_parameters.k_step = 0.05;
fb_parameters.angle_step = 30;

%set contrast-adaptation parameter
alpha = -0.05;

%apply SCIRD
[outIm, properties, ALLfiltered, SCIRD_filters] = SCIRD(I,alpha,ridges_color,fb_parameters);

%show original image
%figure,imshow(I,[])

%show the result obtained applying the 10th filter in the filter bank
%figure,imshow(ALLfiltered(:,:,10),[])

%show SCIRD result

figure,imshow(outIm,[])
newImage = outIm;
newImage(outIm<2) = 0;
newImage(outIm>=2) = 255;
figure,imshow(newImage, [])

%the following three lines prints the result of each filter

for print_image_id = 1:size(ALLfiltered,3)
    imwrite(ALLfiltered(:, :, print_image_id), strcat('filter_applied', num2str(print_image_id), '.png'))
end

%the following three lines prints the SCIRD filters, normalising them before

%normalised_filters = print_SCIRD(SCIRD_filters);
%for print_image_id = 1:size(normalised_filters, 2)
%    imwrite(normalised_filters{1, print_image_id}, strcat('filter', num2str(print_image_id), '.png'));
%end
