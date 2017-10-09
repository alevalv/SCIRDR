function [segmentatedImage] = runme(Image, GT, Mask, filename, sigma1, sigma1Step, sigma2, sigma2Step, k, kStep, angleStep, filterSize)

%single layer grayscale single precision (green channel selected here)
I = single(Image(:,:,2));

%ridges color 'black' or 'white'
ridges_color = 'black';

%set filter bank parameters
fb_parameters.sigma_1 = sigma1;%[1 2];
fb_parameters.sigma_1_step = sigma1Step;%1;
fb_parameters.sigma_2 = sigma2;%[1 2];
fb_parameters.sigma_2_step = sigma2Step;%1;
fb_parameters.k = k;%[-0.1 0.1];
fb_parameters.k_step = kStep;%0.05;
fb_parameters.angle_step = angleStep;%15;
fb_parameters.filter_size = filterSize;%21;

%set contrast-adaptation parameter
alpha = 0.1;

%apply SCIRD_TS
[outIm, ~, ~, ~] = SCIRD_TS(I,alpha,ridges_color,fb_parameters);

%masking
mask = imerode(Mask,strel('disk',10, 0));
outIm(mask==0)=0;

%uncomment this if you want to check the confusion matrix of the given segmentation against the groundTruth image
%confusionMatrix = compare_image(outIm, GT);

%figure,imshow(outIm,[])

segmentatedImage = mat2gray(outIm);

%the following three lines prints the SCIRD filters, normalising them before
%[normalised_filters, filenames] = print_SCIRD(filters, filterProperties);
%for print_image_id = 1:size(normalised_filters, 2)
%    imwrite(normalised_filters{1, print_image_id}, filenames{1, print_image_id});
%end
