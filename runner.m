#!/usr/bin/octave -qfW
pkg load image
%close all

%arg_list = argv ();
%directory = arg_list{1};
%dirdata = dir(strcat(directory, '/*.jpg'));
%for file = dirdata'
%    I = imread(strcat(directory, '/', file.name));
%    runme(I, file.name)
%end
    I = imread('input/IVCM_130.jpg');
    runme(I, 'IVCM_130.jpg')
pkg unload image