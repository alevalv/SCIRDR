function [] = Accelerated_CSC_filter_learning(resume_fb_no)
%
%  Accelerating CSC filter learning by refining SCIRD-TS filter banks
%
%  Input:
%     resume_fb_no (default=0)
%     if you set resume_fb_no to 3, for instance, it will assume that
%     the iteration 3 (corresponding to fb_000003) is completed and starts
%     from iteration 4.

%**************************************************************************
%  Author: Roberto Annunziata, CVIP, University of Dundee, UK
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

addpath(genpath('helper_functions'));
if (nargin==0)
    resume_fb_no = 0;
else
    if (nargin>1 || ~isnumeric(resume_fb_no))
        error('Wrong parameters -- the only parameter allowed is an iteration number corresponding to a filter bank to resume');
    end
end

[p] = get_config(); % <--- MODIFY HERE the algorithm's parameters

% Setup directories according to the parameters set in the configuration
% file and the iteration number that has to be resumed
setup_directories(p,resume_fb_no);

% Load the training data
[imgs,masks] = load_dataset(p);

filename_batch = 'results/fb_img/batch';
filename_ws = 'results/fb_img/workspace';

if (resume_fb_no>0)
    %load batch
    load(filename_batch)
    % If a filter bank to resume is specified, then load it
    [fb] = load_existing_filter_bank(p,resume_fb_no);
    load(filename_ws,'stat','p')
else
	% statistics variable
	stat = [];
	stat.fobj_avg = [];
	stat.fresidue_avg = [];
	stat.fsparsity_avg = [];
	stat.elapsed_time = 0;
    stat.tot_time = 0;
    time_init = tic;
    % No filter bank has been specified, initialize it according to the
    % parameters specified in the configuration structure
    if strcmp(p.fb.initmethod,'SCIRD-TS')
        [fb] = initialize_known_filter_bank(p);
    else
        [fb] = initialize_filter_bank(p);
    end
    stat.init_time = toc(time_init);
    % sample "p.data.batch_size" large patches randomly.
    batch = get_batch(p,imgs,masks,p.data.batch_size);
    save(filename_batch,'batch');
end

% Feature maps corresponding to the filters
t = cell(p.fb.filters_no,1);

fprintf('Learning CSC filter bank...\n');
i_it = resume_fb_no+1;
% Save the initial filter bank for reference
save_filter_bank(p,fb,i_it-1);

 while (true)

    fprintf('  + iteration %d\n',i_it);

    start_time = tic;
    stat.fobj_total=0;
    stat.fresidue_total=0;
    stat.fsparsity_total=0;

    %iterate over the batch
    for i_b = 1:p.data.batch_size
        % Pick a random sample from the dataset
        i_b
        x = batch{i_b};
        % Contrast normalisation
        if p.data.contrast_normalization == 1
            % Local Constrast Normalization
            k = fspecial('gaussian',[p.fb.filter_size p.fb.filter_size],p.data.sigma_gaussian_contrast_norm);

            lmn = convnfft(x,k,'same');
            lmnsq = convnfft(x.^2,k,'same');
            lvar = lmnsq - lmn.^2;
            lvar(lvar<0) = 0; % avoid numerical problems
            lstd = sqrt(lvar);

            q=sort(lstd(:));
            lq = round(length(q)/2);
            th = q(lq);
            if(th==0)
                q = nonzeros(q);
                if(~isempty(q))
                lq = round(length(q)/2);
                th = q(lq);
                else
                    th = 0;
                end
            end
            lstd(lstd<=th) = th;

            lstd(lstd(:)==0) = 1e-10;

            dim = x - lmn;
            x = dim ./ lstd;
        end

        % Initialize the feature maps
        for i_f = 1:p.fb.filters_no
            t{i_f} = convnfft(x,fb{i_f},'same');
        end
        % Optimize over the feature maps
        t = fista(x,p,fb,t);

        % Compute the residual for filter update
        rec_ft = compute_img_reconstruction(t,fb);
        res_ft = x-rec_ft;

        for i_f = 1:p.fb.filters_no
            % Update the fb filters
            % Remove the borders to avoid border effects
            fm = t{i_f}(ceil(p.fb.filter_size/2):end-floor(p.fb.filter_size/2),ceil(p.fb.filter_size/2):end-floor(p.fb.filter_size/2)); %#ok<PFBNS>
            res = res_ft(p.fb.filter_size:end-p.fb.filter_size+1,p.fb.filter_size:end-p.fb.filter_size+1); %#ok<PFBNS>

            % Compute filter's gradient
            grad_fb = -convnfft(rot90(fm,2),res,'valid');

            % Apply the gradient and normalize
            fb{i_f} = fb{i_f}-p.learning.fb_gd_step*grad_fb;
            fb{i_f} = fb{i_f}/norm(fb{i_f}(:));
        end
        norm_ft = 0;
        for i_f = 1:p.fb.filters_no
            norm_ft = norm_ft + norm(t{i_f}(:),1);
        end
        %stats
        rec_ft_obj = compute_img_reconstruction(t,fb);
        res_ft_obj = x-rec_ft_obj;
        fresidue =  0.5*norm(res_ft_obj(:))^2;
        fsparsity =  p.learning.lambda_1 * norm_ft;
        fobj = 0.5*norm(res_ft_obj(:))^2 + p.learning.lambda_1 * norm_ft;

        stat.fobj_total      = stat.fobj_total + fobj;
        stat.fresidue_total  = stat.fresidue_total + fresidue;
        stat.fsparsity_total = stat.fsparsity_total + fsparsity;

        %save result
        save_filter_bank(p,fb,i_it);
    end

    % get statistics
    Objective_avg(i_it)      = stat.fobj_total / p.data.batch_size
    stat.fobj_avg(i_it)      = stat.fobj_total / p.data.batch_size;
    stat.fresidue_avg(i_it)  = stat.fresidue_total / p.data.batch_size;
    stat.fsparsity_avg(i_it) = stat.fsparsity_total / p.data.batch_size;
    stat.elapsed_time(i_it)  = toc(start_time);
    %time = initialization + batch
    if i_it>1
        stat.tot_time(i_it)      = stat.tot_time(i_it-1) + stat.elapsed_time(i_it);
    else
        stat.tot_time(i_it)      = stat.init_time + stat.elapsed_time(i_it);
    end

    save(filename_ws,'stat','p','fb','batch')

    %check convergence
    if i_it>1
        if abs((stat.fresidue_avg(i_it) - stat.fresidue_avg(i_it-1))) < p.convergence_t
            disp('Local minima found.')
            break
        end
    end

    i_it = i_it + 1;
end

end