%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%     Accelerating Convolutional Sparse Coding for Curvilinear Structures Segmentation by     %
%                             Refining SCIRD-TS Filter Banks 	                              %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
R. Annunziata and E. Trucco, "Accelerating Convolutional Sparse Coding for Curvilinear 
Structures Segmentation by Refining SCIRD-TS Filter Banks", IEEE TMI, 2016.

================================== Short description ==========================================

Deep learning has shown great potential for curvilinear structure (e.g. retinal blood vessels 
and neurites) segmentation as demonstrated by a recent auto-context regression architecture 
based on filter banks learned by convolutional sparse coding. However, learning such filter 
banks is very time-consuming, thus limiting the amount of filters employed and the adaptation 
to other data sets (i.e. slow re-training). We address this limitation by proposing a novel 
acceleration strategy to speed-up convolutional sparse coding filter learning for curvilinear 
structure segmentation. Our approach is based on a novel initialisation strategy (warm start),
and therefore it is different from recent methods improving the optimisation itself. 
Our warm-start strategy is based on carefully designed hand-crafted filters (SCIRD-TS), 
modelling appearance properties of curvilinear structures which are then refined by convolutional 
sparse coding. Experiments on four diverse data sets, including retinal blood vessels and 
neurites, suggest that the proposed method reduces significantly the time taken to learn 
convolutional filter banks (i.e. up to -82%) compared to conventional initialisation strategies. 
Remarkably, this speed-up does not worsen performance; in fact, filters learned with the proposed 
strategy often achieve a much lower reconstruction error and match or exceed the segmentation 
performance of random and DCT-based initialisation, when used as input to a random forest 
classifier.
==============================================================================================

================================= Acknowledgments ============================================
 
- re-used/modified some of the MATLAB functions written by R. Rigamonti (CVlab, EPFL) for learning CSC filters, available at https://bitbucket.org/roberto_rigamonti/med_img_pc 
- fast solution for computing the convolutions in the Fourier domain, available at http://www.mathworks.com/matlabcentral/fileexchange/24504-fft-based-convolution
- fast k-means (with careful seeding) available at http://www.mathworks.com/matlabcentral/fileexchange/31274-fast-k-means
- The DRIVE data set, included here to avoid directory issues, has been download through http://www.isi.uu.nl/Research/Databases/DRIVE/download.php
==============================================================================================

===================================== Code usage =============================================

1. open MATLAB
2. set as current folder <yourpath>\Accelerated_CSC_filter_learning
3. set the parameters in "get_config.m" (in the "helper_functions" folder) 
4. type "Accelerated_CSC_filter_learning" in the Matlab Command Window.
5. At convergence, the algorithm stops. The learned filter bank is saved as a cell variable 
   called "fb" in "results/fb_img/workspace"

Comments:

- you can check the CSC learned filters at intermediate states, they are available in the 
  "fb_img_DRIVE" folder as png images. In case your machine crashes after many hours for any 
  reason (e.g. power cut), you can simply resume from the previous saved state.
- *do not open* the png file showing the filter banks related to the current iteration, as it can
  lead to a crash due to conflicts between writing/reading windows' internal routines. 
- based on my experience, contrast normalisation speeds-up convergence further.
- this code is easily parallelizable and will benefit from a powerful GPU, but I tested it on
  a *laptop* equipped with Intel i7-4702 CPU @ 2.2 GHz and 16GB RAM (Windows 7, Matlab R2014a).
- You may want to stop the algorithm (before convergence is reached), if you observe that filters 
  banks start to be visually very similar to each other (p.convergence_t was set too small).
  
==============================================================================================


===================================== Bug report =============================================

For any question or bug report do not hesitate to contact me at:

		               r.annunziata@dundee.ac.uk
			         robertoannunziata@outlook.com
==============================================================================================


If you use this code in your project, please cite [1].

[1] R. Annunziata and E. Trucco, "Accelerating Convolutional Sparse Coding for Curvilinear 
Structures Segmentation by Refining SCIRD-TS Filter Banks", IEEE Transactions on Medical Imaging, 2016.


Further readings:

[2] R. Annunziata, A. Kheirkhah, S. Aggarwal, P. Hamrah and E. Trucco: 
"A Fully Automated Tortuosity Quantification System with Application to Corneal Nerve Fibres In Confocal Microscopy Images",
Medical Image Analysis, 2016.

[3] Annunziata R., Kheirkhah A., Hamrah P., Trucco E.:
"Scale and Curvature Invariant Ridge Detector for Tortuous and Fragmented Structures",
Proceedings of Medical Image Computing and Computer Assisted Interventions (MICCAI), 2015, Munich, Germany.

[4] Annunziata R., Kheirkhah A., Hamrah P., Trucco E.:
"Boosting Hand-Crafted Features for Curvilinear Structure Segmentation by Learning Context Filters",
Proceedings of Medical Image Computing and Computer Assisted Interventions (MICCAI), 2015, Munich, Germany.

[5] Annunziata R., Kheirkhah A., Hamrah P., Trucco E.:
"Combining Efficient Hand-Crafted Features with Learned Filters for Fast and Accurate Corneal Nerve Fibre Centreline Detection",
Proceedings of IEEE Engineering in Medicine and Biology Society (EMBS) 2015, Milan, Italy .

