%{
    This script allows running an octave program that receives command line arguments,
    useful for running multiple test unattended.
%}

%#!/usr/bin/octave -qfW
pkg load image
%close all
arg_list = argv ();
getArg = @(number) str2double(arg_list{number});

directory = arg_list{1};
dirdata = dir(strcat(directory, '/*.jpg'));
for file = dirdata'
    I = imread(strcat(directory, '/', file.name));
                        % sigma1start sigma2end   sigma1step     sigma2start sigma2end    sigma2step     kstart      kend        kstep   anglestep
    runme(I, file.name, [getArg(2) getArg(3)], getArg(4), [getArg(5) getArg(6)], getArg(7), [getArg(8) getArg(9)], getArg(10), getArg(11))
end