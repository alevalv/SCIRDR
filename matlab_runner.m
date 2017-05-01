close all;
clear all;

addpath SCIRD;
addpath SCIRDK;
addpath SCIRDTS;

I = imread('input/1.tif');
GT = imread('input/groundTruth/1.gif');
mask = imread ('input/mask/1.gif');

%confusionMatrix = runme(I, GT, mask, 'outputimage.png', [2 4], 1,
%confusionMatrix = runmek(I, GT, mask, 'outputimage.png', [2 4], 1, [2 3], 1, [-0.1 0.1], 0.05, [-0.1 0.1], 0.05, 30, 0.5);
[~, ~] = runme(I, GT, mask, 'outputimage.png', [1 2], 1, [1 2], 1, [-0.1 0.1], 0.05, 15, 21);
