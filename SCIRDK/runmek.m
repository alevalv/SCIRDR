%Toy example: apply SCIRD to corneal nerve fibres captured with IVCM
%close all
function confusionMatrix = runmek(Image, GT, Mask, filename, sigma1, sigma1Step, sigma2, sigma2Step, k1, k1Step, k2, k2step, angleStep, segmentationThreshold)

I = preprocesar(Image(:,:,1), Mask);
%I = imread('3.png');

%single layer grayscale single precision
I = single(I);

%ridges color 'black' or 'white'
ridges_color = 'white';

%set filter bank parameters
fb_parameters.sigma_1 = sigma1;%[2 4];
fb_parameters.sigma_1_step = sigma1Step; %1;
fb_parameters.sigma_2 = sigma2;%[2 3];
fb_parameters.sigma_2_step = sigma2Step; %1;
fb_parameters.k_1 = k1;
fb_parameters.k_1_step = k1Step;
fb_parameters.k_2 = k2;
fb_parameters.k_2_step = k2step;
fb_parameters.angle_step = angleStep; %30;

%set contrast-adaptation parameter
alpha = -0.05;

%apply SCIRD
[outIm, filterProperties, ~, SCIRD_filters] = SCIRDK(I,alpha,ridges_color,fb_parameters);

%show original image
%figure,imshow(I,[])
%imwrite(I,"../Imagenes_pruebas/1/1_1.png")

%show the result obtained applying the 10th filter in the filter bank
%figure,imshow(ALLfiltered(:,:,10),[])
%imwrite(ALLfiltered(:,:,10),"../Imagenes_pruebas/1/1_2.png")
segmentatedImage = mat2gray(outIm);
confusionMatrix = compare_image(segmentatedImage, GT);
%show SCIRD result
%figure,imshow(outIm,[])
%imwrite(outIm,'../Imagenes_pruebas/1/1_3.png')
%figure,imwrite(outIm,'../Imagenes_pruebas/1/1_3.png','BitDepth',16)

%[normalised_filters, filenames] = print_SCIRDK(SCIRD_filters, filterProperties);
%for print_image_id = 1:size(normalised_filters, 2)
%    imwrite(normalised_filters{1, print_image_id}, filenames{1, print_image_id});
%end
