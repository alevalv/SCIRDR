%{
    This script allows running an octave program that receives command line arguments,
    useful for running multiple test unattended.
%}

%#!/usr/bin/octave -qfW
close all
clear all
pkg load image
%close all
arg_list = argv ();
getArg = @(number) str2double(arg_list{number});

imageDirectory = arg_list{1};
groundTruthDirectory = arg_list{2};
maskDirectory = arg_list{3};
outputFilename = strcat('run-', arg_list{4}, '_', arg_list{5}, '_', arg_list{6}, '_', arg_list{7}, '_', arg_list{8}, '_', arg_list{9}, '_', arg_list{10}, '_', arg_list{11}, '_', arg_list{12}, '_', arg_list{13}, '_', arg_list{14},'.txt');
outputFile = fopen(outputFilename, 'wt');
for imageId =1:20
    filename=strcat(num2str(imageId));
    I = imread(strcat(imageDirectory, '/', filename, '.tif'));
    GT = imread(strcat(groundTruthDirectory, '/', filename, '.gif'));
    Mask = imread(strcat(maskDirectory, '/', filename, '.gif'));
                        % sigma1start sigma2end sigma1step sigma2start sigma2end sigma2step kstart kend kstep anglestep threshold
    confMatrix = runme(I, GT, Mask, filename, [getArg(4) getArg(5)], getArg(6), [getArg(7) getArg(8)], getArg(9), [getArg(10) getArg(11)], getArg(12), getArg(13), getArg(14));
    fprintf(outputFile, '%d,%d,%d,%d\n', confMatrix(1), confMatrix(2), confMatrix(3), confMatrix(4));
end
fclose(outputFile);