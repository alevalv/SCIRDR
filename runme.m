%Toy example: apply SCIRD to corneal nerve fibres captured with IVCM
%close all
clear all

I = imread('9.png');
%I = imread('3.png');

%single layer grayscale single precision
I = single(I(:,:,1));

%ridges color 'black' or 'white'
ridges_color = 'white';

%set filter bank parameters
fb_parameters.sigma_1 = [2 4]; 
fb_parameters.sigma_1_step = 1;
fb_parameters.sigma_2 = [2 3]; 
fb_parameters.sigma_2_step = 1; 
fb_parameters.k_1 = [-0.1 0.1]; 
fb_parameters.k_1_step = 0.05; 
fb_parameters.k_2 = [3 6]; 
fb_parameters.k_2_step = 0.5; 
fb_parameters.angle_step = 30;

%set contrast-adaptation parameter
alpha = -0.05; 

%apply SCIRD
[outIm, properties, ALLfiltered] = SCIRD(I,alpha,ridges_color,fb_parameters);

%show original image
%figure,imshow(I,[])
%imwrite(I,"../Imagenes_pruebas/1/1_1.png")

%show the result obtained applying the 10th filter in the filter bank
figure,imshow(ALLfiltered(:,:,10),[])
%imwrite(ALLfiltered(:,:,10),"../Imagenes_pruebas/1/1_2.png")

%show SCIRD result
figure,imshow(outIm,[])
%imwrite(outIm,'../Imagenes_pruebas/1/1_3.png')
%figure,imwrite(outIm,'../Imagenes_pruebas/1/1_3.png','BitDepth',16)

