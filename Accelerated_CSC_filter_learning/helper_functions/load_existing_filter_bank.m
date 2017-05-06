function [fb] = load_existing_filter_bank(p,resume_fb_no)
%  load_existing_filter_bank  Load the specified filter bank
%
%  Synopsis:
%     [fb] = load_existing_filter_bank(p,resume_fb_no)
%
%  Input:
%     resume_fb_no = learning iteration to resume
%  Output:
%     fb = cell array containing the image filter bank loaded from the specified
%          file

%  author: Roberto Rigamonti, CVLab EPFL
%  e-mail: roberto <dot> rigamonti <at> epfl <dot> ch
%  web: http://cvlab.epfl.ch/~rigamont
%  date: June 2012
%  last revision: 21 June 2012

resume_fb_filename = ['results\fb_img\fb_txt\fb_',sprintf('%06d',resume_fb_no),'.txt'];%sprintf(p.results.fb_txt_fileformat,resume_fb_no);

fb_file = load(resume_fb_filename);
fb = cell(p.fb.filters_no,1);
for i_f = 1:p.fb.filters_no
    fb{i_f} = fb_file((i_f-1)*p.fb.filter_size+1:i_f*p.fb.filter_size,:);
end

end