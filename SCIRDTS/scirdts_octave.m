%{
    This script allows running an octave program that receives command line arguments,
    useful for running multiple test unattended.

    It is currently modified to be able to be used with the SCIRDTS algorithms, by handling more arguments

    Default values for SCIRD-TS algorithm:
    ./runner.sh scirdts_octave.m ../input/source ../input/groundTruth ../input/mask 1 2 1 1 2 1 -0.1 0.1 0.05 15 21
%}

%#!/usr/bin/octave -qfW
close all;
pkg load image

arg_list = argv ();

%inline function to parse a string to a double.
getArg = @(number) str2double(arg_list{number});

imageDirectory = arg_list{1};
groundTruthDirectory = arg_list{2};
maskDirectory = arg_list{3};

for imageId =1:20
    filename=strcat(num2str(imageId));
    I = imread(strcat(imageDirectory, '/', filename, '.tif'));
    GT = imread(strcat(groundTruthDirectory, '/', filename, '.gif'));
    Mask = imread(strcat(maskDirectory, '/', filename, '.gif'));
    segmentatedImage = runme(I, GT, Mask, filename, [getArg(4) getArg(5)], getArg(6), [getArg(7) getArg(8)], getArg(9), [getArg(10) getArg(11)], getArg(12), getArg(13), getArg(14));

    imwrite(segmentatedImage, strcat('output/s',filename, '.png'));
end
