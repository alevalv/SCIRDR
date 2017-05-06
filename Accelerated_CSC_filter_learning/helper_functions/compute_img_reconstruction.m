function [img_rec] = compute_img_reconstruction(feature_maps,filters)
%  compute_img_reconstruction  Compute the reconstruction of the input image
%                              given the filters and the computed feature maps
%
%  Synopsis:
%     [img_rec] = compute_img_reconstruction(feature_maps,filters)
%
%  Input:
%     feature_maps = cell array containing the feature maps extracted from the
%                    input image
%     filters      = cell array containing the set of filters used to extract
%                    features from the image
%  Ouput:
%     img_rec = reconstruction computed from the feature maps and the filters

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

% Compute the reconstruction

img_rec = convnfft(feature_maps{1},filters{1},'same');
for i_fm = 2:length(feature_maps)
         img_rec = img_rec+convnfft(feature_maps{i_fm},filters{i_fm},'same');
end
% Normalize the reconstruction.
img_rec = img_rec/(size(filters{1},1))^2;
end