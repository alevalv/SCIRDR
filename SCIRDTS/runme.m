%Toy example: apply SCIRD-TS to retinal blood vessels from the DRIVE data set
close all
clear all

I = imread('22_training.png');

%single layer grayscale single precision (green channel selected here)
I = single(I(:,:,2));

%ridges color 'black' or 'white'
ridges_color = 'black';

%set filter bank parameters
fb_parameters.sigma_1 = [1 2];
fb_parameters.sigma_1_step = 1;
fb_parameters.sigma_2 = [1 2];
fb_parameters.sigma_2_step = 1;
fb_parameters.k = [-0.1 0.1];
fb_parameters.k_step = 0.05;
fb_parameters.angle_step = 15;
fb_parameters.filter_size = 21;

%set contrast-adaptation parameter
alpha = 0.1;

%apply SCIRD_TS
[outIm, properties, ALLfiltered] = SCIRD_TS(I,alpha,ridges_color,fb_parameters);

%masking
mask = imread('22_training_mask.png');
mask = imerode(mask,strel('disk',10));
outIm(mask==0)=0;

%show original image
figure,imshow(I,[])

%show the result obtained applying the 10th filter in the filter bank
figure,imshow(ALLfiltered(:,:,10),[])

%show SCIRD_TS result
figure,imshow(outIm,[])
