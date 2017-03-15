%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Scale and Curvature Invariant Ridge Detector (SCIRD) for Tortuous and Fragmented Structures %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

================================== Short description ==========================================

SCIRD is a novel ridge detector designed and developed to improve the enhancement/segmentation 
of tortuous and fragmented curvilinear structures in the medical domain, such as corneal nerve
fibres and neurites. In addition to the elongation and width parameters typically used to tune 
filter banks performing this task, SCIRD includes 2 other parameters: 

1) "k" controlling the curvature of each filter, allowing a better enhancement/segmentation of
   tortuous structures; 

2) "alpha" controlling the level of contrast enhancement required to deal with severe contrast
   variations for each specific dataset.
==============================================================================================


===================================== Code usage =============================================

1. open MATLAB
2. set as current folder <yourpath>\SCIRD
3. type "runme" in the Matlab Command Window (toy example filtering corneal nerve fibres 
captured thorugh in vivo confocal microscopy).


Notice that time to run SCIRD on large datasets or when using many filters can be reduced 
further using MATLAB parallel toolbox. Moreover, casting images and filters as gpuArrays 
would contribute to a significant speed up if dealing with large images.

This code has been tested on Intel i7-4770 CPU @ 3.4 Ghz (Windows 7, Matlab R2014a).
==============================================================================================


===================================== Bug report =============================================

For any question or bug report do not hesitate to contact me at:

		               r.annunziata@dundee.ac.uk
			        r_o_b_e_r_t_o@hotmail.it
==============================================================================================


If you use this code in your project, please remember to cite [1].


[1]   R. Annunziata, A. Kheirkhah, P. Hamrah, E. Trucco, "Scale and Curvature Invariant 
      Ridge Detector for Tortuous and Fragmented Structures", MICCAI, 2015.

