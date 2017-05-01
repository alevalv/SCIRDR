### SCIRDR

This project is an extension of the original SCIRD filter made by Roberto Annunziata, focusing on modifying it to be able to work with retinal images. The original proposal can be found in the paper:
```
R. Annunziata, A. Kheirkhah, P. Hamrah, E. Trucco, "Scale and
Curvature Invariant Ridge Detector for Tortuous and Fragmented
Structures", MICCAI, 2015.
R. Annunziata, E. Trucco, "Accelerating Convolutional Sparse Coding
for Curvilinear Structures Segmentation by Refining SCIRD-TS Filter
Banks", IEEE Transactions on Medical Imaging, (in press), 2016
```

To run this project in matlab, call the file `matlab_runner`, and uncomment the algorithm that you want to test
To run in octave, modify `octave_runner` file to select the algorithm, then execute `runner.sh` from a console, passing the following arguments (this example works for SCRIDTS):

```
./runner.sh octave_runner.m input input/groundTruth input/mask 1 2 1 1 2 1 -0.1 0.1 0.05 15 21
```

HTCondor
--------
It includes a configuration to run this project in a distributed platform, check condor folder for details.


License
-------
This program is free software: you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation, either version 3 of the License, or (at your option) any later version.

This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for more details.

You should have received a copy of the GNU General Public License along with this program. If not, see <http://www.gnu.org/licenses/>.