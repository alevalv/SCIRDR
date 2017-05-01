function trythreshold(Image)

B=adaptivethreshold(Image,15,0.01,0);
imwrite(B,'window15_filterMean.png')

C=adaptivethreshold(Image,13,0.01,0);
imwrite(C,'window13_filterMean.png')

D=adaptivethreshold(Image,11,0.01,0);
imwrite(D,'window11_filterMean.png')

E=adaptivethreshold(Image,9,0.01,0);
imwrite(E,'window9_filterMean.png')

F=adaptivethreshold(Image,7,0.01,0);
imwrite(F,'window7_filterMean.png')

G=adaptivethreshold(Image,5,0.01,0);
imwrite(G,'window5_filterMean.png')

H=adaptivethreshold(Image,3,0.01,0);
imwrite(H,'window3_filterMean.png')

O=adaptivethreshold(Image,15,0.01,1);
imwrite(O,'window15_filterMedian.png')

P=adaptivethreshold(Image,13,0.01,1);
imwrite(P,'window13_filterMedian.png')

Q=adaptivethreshold(Image,11,0.01,1);
imwrite(Q,'window11_filterMedian.png')

R=adaptivethreshold(Image,9,0.01,1);
imwrite(R,'window9_filterMedian.png')

S=adaptivethreshold(Image,13,0.01,1);
imwrite(S,'window7_filterMedian.png')

T=adaptivethreshold(Image,11,0.01,1);
imwrite(T,'window5_filterMedian.png')

U=adaptivethreshold(Image,9,0.01,1);
imwrite(U,'window3_filterMedian.png')
