%{
    This script allows running an octave program that receives command line arguments,
    useful for running multiple test unattended.
%}

%#!/usr/bin/octave -qfW
close all;
clear all;
pkg load image

Accelerated_CSC_filter_learning(0)