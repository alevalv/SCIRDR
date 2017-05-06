function [p] = get_config()
%  get_config  Setup the configuration and the paths
%
%  Synopsis:
%     [p] = get_config()
%
%  Ouput:
%     p = structure containing the parameters and the paths required by the
%         system

%**************************************************************************
%  Originally written by Roberto Rigamonti, CVlab EPFL.
%  Modified by: Roberto Annunziata, CVIP, University of Dundee, UK 
%  e-mail: r.annunziata@dundee.ac.uk or robertoannunziata@outlook.com
%  web: http://staff.computing.dundee.ac.uk/rannunziata/
%  date: May 2016
%
%  If you use this code in your project, please cite [1].
%        
% [1] R. Annunziata and E. Trucco, "Accelerating Convolutional Sparse Coding 
%     for Curvilinear Structures Segmentation by Refining SCIRD-TS Filter Banks", 
%     IEEE Transactions on Medical Imaging, 2016.
%**************************************************************************

%% Dataset's parameters
% Directory containing input images
p.data.imgs_filelist = 'datasets/DRIVE_imgs_filelist.txt';
if (~exist(p.data.imgs_filelist,'file'))
    error('Cannot find the list of input images, please check the path: %s',p.data.img_filelist);
end
% Directory containing input mask
p.data.masks_filelist = 'datasets/DRIVE_masks_filelist.txt';
if (~exist(p.data.masks_filelist,'file'))
    error('Cannot find the list of input masks, please check the path: %s',p.data.mask_filelist);
end
% Size of the patches extracted from the image during the filter learning phase
p.data.patch_size = 49;
% contrast normalization
p.data.contrast_normalization = 1;
p.data.sigma_gaussian_contrast_norm = 3*1.591; % standard value for gaussians
% Set the batch size (i.e. amount of patches to be sampled)
p.data.batch_size = 1000;

%% Results' parameters
% Base directory for storing the results
p.results.results_dir = 'results';
% Directory where the TXT version of the image filter bank will be stored
p.results.fb_txt_dir = fullfile(p.results.results_dir,'fb_img/fb_txt');
p.results.fb_txt_fileformat = fullfile(p.results.results_dir,'fb_txt','fb_%06d.txt');
% Directory where the PNG version of the image filter bank will be stored
p.results.fb_img_dir = fullfile(p.results.results_dir,'fb_img');
p.results.fb_img_fileformat = fullfile(p.results.results_dir,'fb_img','fb_%06d.png');
% Vertical/horizontal spacing between filters in filter bank's representation
p.results.v_space = 10;
p.results.h_space = 10;
% Pixel size for the filters in filter bank's representation
p.results.pixel_size = 11;

%% Filter bank's parameters
% Instead of taking days (original solution by Rigamonti and Lepetit,
% MICCAI 2012), our solution takes only a few hours to learn large filter 
% banks with the same cardinality and size as the ones used by Rigamonti and Lepetit.

% Number of filters
p.fb.filters_no = 144;
% Filter size
p.fb.filter_size = 21;
% initialization method
p.fb.initmethod = 'SCIRD-TS'; %the other option is plain CSC, i.e. 'random'
%set filter bank parameters (this setting has been used for 4 different data sets,
%you may need to change it depending on resolution, fragmentation or tortuosity)
p.fb_parameters.sigma_1 = [1 10]; 
p.fb_parameters.sigma_1_step = 0.5;
p.fb_parameters.sigma_2 = [1 10]; 
p.fb_parameters.sigma_2_step = 0.5; 
p.fb_parameters.k = [-0.1 0.1]; 
p.fb_parameters.k_step = 0.025; 
p.fb_parameters.angle_step = 15;

%% Filter learning parameters
% Regularization parameter on feature maps
p.learning.lambda_1 = 2; % we showed that our warm start strategy is more robust against this parameter compared to random initialisation
% Number of GD steps performed in the optimization of the feature maps
p.learning.gd_steps_no = 5;
% Gradient step over the feature maps
p.learning.fm_gd_step = 1e-1;
% Gradient step over the image filters
p.learning.fb_gd_step = 1e-5;

%% Convergence
% set the threshold to check convergence (when the absolute difference of the 
% objective at epoch t and t+1 is smaller that this threshold, stop).
p.convergence_t = 0.1;

end