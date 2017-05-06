function [] = setup_directories(p,resume_fb_no)
%  setup_directories  Create the directories according to the parameters set in
%                     the configuration file
%
%  Synopsis:
%     setup_directories(p,resume_fb_no)
%
%  Input:
%     p            = structure containing framework's configuration
%     resume_fb_no = iteration number pointing to the filter banks to resume

%  author: Roberto Rigamonti, CVLab EPFL
%  e-mail: roberto <dot> rigamonti <at> epfl <dot> ch
%  web: http://cvlab.epfl.ch/~rigamont
%  date: June 2012
%  last revision: 21 June 2012

if (resume_fb_no<1)
    if (resume_fb_no==-1)
        % Remove previous simulation (if present)
        if (exist(p.results.results_dir,'dir'))
            fprintf('Removing previous simulation directory\n');
            [status,message,messageid] = rmdir(p.results.results_dir,'s'); %#ok<*NASGU,*ASGLU>
        end
    end
    if (resume_fb_no==0)
        % Remove previous results (if present)
        if (exist(p.results.fb_txt_dir,'dir'))
            fprintf('No resume requested, removing the previous fb txt directory\n');
            [status,message,messageid] = rmdir(p.results.fb_txt_dir,'s'); %#ok<*NASGU,*ASGLU>
        end
        if (exist(p.results.fb_img_dir,'dir'))
            fprintf('No resume requested, removing the previous fb img directory\n');
            [status,message,messageid] = rmdir(p.results.fb_img_dir,'s'); %#ok<*NASGU,*ASGLU>
        end
    end
    % Recreate directories
    [status,message,messageid] = mkdir(p.results.fb_img_dir);
    [status,message,messageid] = mkdir(p.results.fb_txt_dir);
else
%     % Check that the desired filter bank and the needed directories, are present
%     if (~exist(p.results.results_dir,'dir') || ~exist(p.results.fb_txt_dir,'dir'))
%         error('Resume requested, but needed directories are missing');
%     end
%     if (~exist(p.results.fb_img_dir,'dir'))
%         [status,message,messageid] = mkdir(p.results.fb_img_dir);
%     end
%     resume_fb_filename = sprintf(p.results.fb_txt_fileformat,resume_fb_no);
%     if (~exist(resume_fb_filename,'file'))
%         error('Resume from iteration %d requested, but the file %s, which is supposed to contain the filter bank to resume, does not exist',resume_fb_no,resume_fb_filename);
%     end
end

end