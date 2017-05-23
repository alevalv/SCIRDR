#!/usr/bin/bash
###
# This script will run any arbitrary octave file, passing the next argument to it.
# e.g. ./runner.sh octave_runner.m input input/groundTruth 2 4 1 2 3 1 -0.1 0.1 0.05 30 2
# will run the SCIRD algorithm with the same example configuration as it was before
mkdir results
mkdir results/fb_img
touch results/fb_img/batch
arguments=""
for arg do
    arguments="$arguments $arg"
done
echo "call parameters:${arguments}"
/usr/bin/env octave -qfW $arguments
#/usr/bin/env matlab -nojvm -nodisplay -nosplash -nodesktop -r "run($arguments);exit;"
