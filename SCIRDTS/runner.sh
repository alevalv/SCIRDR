#!/usr/bin/bash
###
# This script will run any arbitrary octave file, passing the next argument to it.
# e.g. ./runner.sh octave_runner.m input input/groundTruth 2 4 1 2 3 1 -0.1 0.1 0.05 30 2
# will run the SCIRD algorithm with the same example configuration as it was before
arguments=""
for arg do
    arguments="$arguments $arg"
done
echo "call parameters:${arguments}"
mkdir output
/usr/bin/env octave -qfW $arguments
