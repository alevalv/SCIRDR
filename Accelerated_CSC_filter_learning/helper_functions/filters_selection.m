%known filter bank initialization
function fb = filters_selection(p,filters_init)
    
    % This function implements the K-means optimisation to select a set of
    % prototype SCIRD-TS-like filters used to initialise CSC (warm start) [1].
    
    %**************************************************************************
    %  author: Roberto Annunziata, CVIP, University of Dundee, UK 
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
    
    % put the filters in the right format to run fkmeans
    filters_init_mat = zeros(p.fb.filter_size,p.fb.filter_size,numel(filters_init));
    for i=1:numel(filters_init)
        filters_init_mat(:,:,i) = filters_init{i};
    end
    filters_init_vect = reshape(filters_init_mat,p.fb.filter_size^2,numel(filters_init)); 
    
    % fkmeans options
    options.careful = 1; 
    options.nIters = 100; %10 is already enough in most cases
    
    % start optimisation
    [~, C] = fkmeans(filters_init_vect', p.fb.filters_no,options);
    
    % get back the filters arranged as needed
    fb_mat = reshape(C',p.fb.filter_size,p.fb.filter_size,p.fb.filters_no);
    fb = [];
    for i=1:size(fb_mat,3)
        fb{i}=fb_mat(:,:,i);
    end
    
end