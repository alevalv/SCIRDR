#!/usr/bin/bash
###
# This script will run any arbitrary octave file, passing the next argument to it.
# e.g. /octave_runner.sh runner.m input 2 4 1 2 3 1 -0.1 0.1 0.05 30
# will run the SCIRD algorithm with the same example configuration as it was before
arguments=""
for arg do
    arguments="$arguments $arg"
done
echo $arguments
/usr/bin/env octave -qfW $arguments