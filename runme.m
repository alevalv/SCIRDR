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
res=ALLfiltered(:,:,10)


%A=rgb2gray(res)


A=res;
B=adaptivethreshold(A,15,0.01,0); 
figure,imshow(B)
title('Ventana de 15 filter mean')
figure,imwrite(B,'imagenespost/window15_filterMean.png')

C=adaptivethreshold(A,13,0.01,0); 
figure,imshow(C)
title('Ventana de 13 filter mean')
figure,imwrite(C,'imagenespost/window13_filterMean.png')

D=adaptivethreshold(A,11,0.01,0); 
figure,imshow(D)
title('Ventana de 11 filter mean')
figure,imwrite(D,'imagenespost/window11_filterMean.png')

E=adaptivethreshold(A,9,0.01,0); 
figure,imshow(E)
title('Ventana de 9 filter mean')
figure,imwrite(E,'imagenespost/window9_filterMean.png')

F=adaptivethreshold(A,7,0.01,0); 
figure,imshow(F)
title('Ventana de 7 filter mean')
figure,imwrite(F,'imagenespost/window7_filterMean.png')

G=adaptivethreshold(A,5,0.01,0); 
figure,imshow(G)
title('Ventana de 5 filter mean')
figure,imwrite(G,'imagenespost/window5_filterMean.png')

H=adaptivethreshold(A,3,0.01,0); 
figure,imshow(H)
title('Ventana de 3 filter mean')
figure,imwrite(H,'imagenespost/window3_filterMean.png')


O=adaptivethreshold(A,15,0.01,1); 
figure,imshow(O)
title('Ventana de 15 filter median')
figure,imwrite(O,'imagenespost/window15_filterMedian.png')

P=adaptivethreshold(A,13,0.01,1); 
figure,imshow(P)
title('Ventana de 13 filter median')
figure,imwrite(P,'imagenespost/window13_filterMedian.png')

Q=adaptivethreshold(A,11,0.01,1); 
figure,imshow(Q)
title('Ventana de 11 filter median')
figure,imwrite(Q,'imagenespost/window11_filterMedian.png')


R=adaptivethreshold(A,9,0.01,1); 
figure,imshow(R)
title('Ventana de 9 filter median')
figure,imwrite(R,'imagenespost/window9_filterMedian.png')

S=adaptivethreshold(A,13,0.01,1); 
figure,imshow(S)
title('Ventana de 7 filter median')
figure,imwrite(S,'imagenespost/window7_filterMedian.png')

T=adaptivethreshold(A,11,0.01,1); 
figure,imshow(T)
title('Ventana de 5 filter median')
figure,imwrite(T,'imagenespost/window5_filterMedian.png')


U=adaptivethreshold(A,9,0.01,1); 
figure,imshow(U)
title('Ventana de 3 filter median')
figure,imwrite(U,'imagenespost/window3_filterMedian.png')




%figure,imshow(res,[])
figure,imwrite(res,'img1.png')

%show SCIRD result
%figure,imshow(outIm,[])
%imwrite(outIm,'../Imagenes_pruebas/1/1_3.png')
%figure,imwrite(outIm,'../Imagenes_pruebas/1/1_3.png','BitDepth',16)

