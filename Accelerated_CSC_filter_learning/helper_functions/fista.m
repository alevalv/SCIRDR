function t = fista(x,p,fb,t)   
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
Objective = []; 

t_fista_old = ones(1,p.fb.filters_no);
prox_y_old = repmat(x,1,1,p.fb.filters_no);
L = 40; %20-40 are good choices to start with

for i=1:p.learning.gd_steps_no

    % Image reconstruction due to feature maps
    rec_ft = compute_img_reconstruction(t,fb);
    % Residual used to compute gradient
    res_ft = x-rec_ft;
    
    for i_f = 1:p.fb.filters_no
        
        %compute gradient
        Gradf = -convnfft(res_ft,rot90(fb{i_f},2),'same');
        
        %compute proximal
        prox_y = max(abs(t{i_f}-(1/L)*Gradf)-p.learning.lambda_1/L,0).*sign(t{i_f}-(1/L)*Gradf);
                
        %updates
        prox_y_new = prox_y;
        t_fista_new = (1 + sqrt(1+4*t_fista_old(i_f)^2))/2;
        t{i_f} = prox_y_new + ((t_fista_old(i_f) - 1)/t_fista_new)*(prox_y_new - prox_y_old(:,:,i_f));
        
        %save for future updates
        prox_y_old(:,:,i_f) = prox_y_new;
        t_fista_old(i_f) = t_fista_new;
    end
    
    norm_ft = 0;
    for i_f = 1:p.fb.filters_no
        norm_ft = norm_ft + norm(t{i_f}(:),1);
    end
    Objective(i,1) = 0.5*norm(res_ft(:))^2 + p.learning.lambda_1 * norm_ft
    
end