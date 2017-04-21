function preprocesar3(filename,filemask)

A = imread("images/21_training.tif");
%A = rgb2gray(RGB1);
%imshow(A);
B = imread("mask/21_training_mask.gif");


Inew = bsxfun(@times, A, cast(B,class(A)));
greenChannel = Inew(:, :, 2);
Inew = greenChannel;

%Inew = A.*repmat(B,[1,1,3]);



[rows cols depth]=size(Inew);
 for xAxis = 1 : rows          
     for yAxis = 1 : cols
     	if Inew(xAxis,yAxis) == 0
     		Inew(xAxis,yAxis) = 255;

     	end
        
     end
 end 
 imwrite(Inew,"salidafinal.png");
 Inew
imshow(Inew);


