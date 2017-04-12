%Toy example: apply SCIRD to corneal nerve fibres captured with IVCM
%single layer grayscale single precision
function confusionMatrix = runme(I, GT, filename, sigma1, sigma1Step, sigma2, sigma2Step, k, kStep, angleStep, segmentationThreshold)


I = single(I(:,:,1));
GT = single(I(:,:,1));

%ridges color 'black' or 'white'
ridges_color = 'white';

%set filter bank parameters
fb_parameters.sigma_1 = sigma1;%[2 4];
fb_parameters.sigma_1_step = sigma1Step; %1;
fb_parameters.sigma_2 = sigma2;%[2 3];
fb_parameters.sigma_2_step = sigma2Step; %1;
fb_parameters.k = k; %[-0.1 0.1];
fb_parameters.k_step = kStep; %0.05;
fb_parameters.angle_step = angleStep; %30;

%set contrast-adaptation parameter
alpha = -0.05;

%apply SCIRD
[outIm, ~, ~, ~] = SCIRD(I,alpha,ridges_color,fb_parameters);

%show original image
%figure,imshow(I,[])

%show the result obtained applying the 10th filter in the filter bank
%figure,imshow(ALLfiltered(:,:,10),[])

%show SCIRD result
%figure,imshow(outIm,[])
newImage = outIm;
newImage(outIm<segmentationThreshold) = 0;
newImage(outIm>=segmentationThreshold) = 255;
%imwrite(newImage, strcat('output.',filename, '.png'));
confusionMatrix = compare_image(newImage, GT);

%the following three lines prints the result of each filter
%for print_image_id = 1:size(ALLfiltered,3)
%    imwrite(ALLfiltered(:, :, print_image_id), strcat('filter_applied', num2str(print_image_id), '.png'))
%end

%the following three lines prints the SCIRD filters, normalising them before
%normalised_filters = print_SCIRD(SCIRD_filters);
%for print_image_id = 1:size(normalised_filters, 2)
%    imwrite(normalised_filters{1, print_image_id}, strcat('filter', num2str(print_image_id), '.png'));
%end
