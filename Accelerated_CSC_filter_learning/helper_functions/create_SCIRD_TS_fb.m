function [SCIRD_TS_filter_bank, properties, all_ind] = create_SCIRD_TS_fb(sigma_1,sigma_1_step, sigma_2,sigma_2_step, k, k_step, step_angle,p)

% create_SCIRD_TS_fb creates a SCIRD-TS filter bank (same notation adopted in [1])

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
% forcing simmetry (SCIRD-TS filters with curvature not equal to 0 are
% asymmetric) was found to speed-up convergence further.
symmetry = 1; 

if symmetry==1
    k(1)=0;
end

% initialise SCIRD-TS parameters
s1_ind=0;
s2_ind=0;
k_ind=0;
angle_ind=0;
all_ind=0;

%create filters
for i_s1 = sigma_1(1):sigma_1_step:sigma_1(end)
    s1_ind = s1_ind+1; 
    for i_s2 = sigma_2(1):sigma_2_step:sigma_2(end) 
        s2_ind = s2_ind+1; 
        for i_k = k(1)-1e-15:k_step:k(end)+1e-15 
            if i_s1>=i_s2 %filters should be longer than wider
                k_dim = i_k;
                k_ind = k_ind+1; 
                %create a grid
                Sigma = max(i_s1,i_s2);
                [x,y]   = ndgrid([-floor(p.fb.filter_size/2):0,1:floor(p.fb.filter_size/2)]); 
                
                for angle = 0:step_angle:(180-step_angle)
                    angle_ind = angle_ind+1;
                                        
                    %define rotation
                    x_t = x.*cosd(angle) - y.*sind(angle);
                    y_t = x.*sind(angle) + y.*cosd(angle);
                   
                    %SCIRD-TS filter
                    SCIRD_TS = exp(-((x_t).^2)/(2*i_s1^2)) .* exp(-((y_t + k_dim*x_t.^2).^2)/(2*i_s2^2)) .* ( ((y_t + k_dim*x_t.^2).^2)/(i_s2^4) - 1/(i_s2^2)); 
                    
                    %forcing simmetry
                    if symmetry == 1
                        k_dim_s = -k_dim;
                        SCIRD_TS = 0.5*SCIRD_TS + 0.5*exp(-((x_t).^2)/(2*i_s1^2)) .* exp(-((y_t + k_dim_s*x_t.^2).^2)/(2*i_s2^2)) .* ( ((y_t + k_dim_s*x_t.^2).^2)/(i_s2^4) - 1/(i_s2^2)); 
                    end
                    
                   %normalization
                   SCIRD_TS = SCIRD_TS/norm(SCIRD_TS(:));
                    
                   if isnan(SCIRD_TS(:))
                       break
                   end
                   all_ind = all_ind + 1;
                    
                   %pause(0.01), imshow(SCIRD_TS,[])
                  
                   SCIRD_TS_filter_bank{all_ind} =  SCIRD_TS; 
                    
                   %store properties related to the current kernel
                   properties(all_ind).s1 = i_s1;
                   properties(all_ind).s2 = i_s2;
                   properties(all_ind).k = i_k;
                   properties(all_ind).angle = angle;
                    
                end
            end
        end
    end
end
end


