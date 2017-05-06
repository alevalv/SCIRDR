function [fb] = initialize_known_filter_bank(p)
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
fb = cell(p.fb.filters_no,1);

if strcmp(p.fb.initmethod,'SCIRD-TS')
    [SCIRD_TS_filters, properties, num_kernels] = create_SCIRD_TS_fb(p.fb_parameters.sigma_1,p.fb_parameters.sigma_1_step, p.fb_parameters.sigma_2,p.fb_parameters.sigma_2_step, p.fb_parameters.k, p.fb_parameters.k_step, p.fb_parameters.angle_step,p);
    
    %produce white- and black-centred filters
    for i_bw=1:numel(SCIRD_TS_filters)
        SCIRD_TS_filters{end+1} = -SCIRD_TS_filters{i_bw};
    end
    
    fb = filters_selection(p,SCIRD_TS_filters);  
else
    disp('You need to select an initialisation method, choose SCIRD-TS or random')
end
    %  Normalize the filter bank
    for i_f = 1:p.fb.filters_no
        fb{i_f} = fb{i_f}/(norm(fb{i_f}(:)));
    end

end