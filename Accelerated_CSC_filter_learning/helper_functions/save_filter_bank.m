function [] = save_filter_bank(p,fb,i_it)
%  save_filter_bank  Save the filter bank both as TXT files and as image
%
%  Synopsis:
%     save_filter_bank(p,fb,i_it)
%
%  Input:
%     p    = structure containing the parameters required by the system
%     fb   = cell array containing the image filters
%     i_it = iteration counter

%  author: Roberto Rigamonti, CVLab EPFL
%  e-mail: roberto <dot> rigamonti <at> epfl <dot> ch
%  web: http://cvlab.epfl.ch/~rigamont
%  date: June 2012
%  last revision: 21 June 2012

% Save the filter bank as an image
imwrite(reshape_fb_as_img(p,fb)/255,['results/fb_img/fb_',sprintf('%06d',i_it),'.png'],'png');

% Save the filter bank in a text file for later usage in then classification
% framework. The adopted format simply stacks the different filters one on top
% of the other, preserving their shapes.
%fd = fopen(sprintf(p.results.fb_txt_fileformat,i_it/p.results.iterations_no),'wt');
fd = fopen(['results/fb_img/fb_txt/fb_',sprintf('%06d',i_it),'.txt'],'wt');
for i_f = 1:p.fb.filters_no
    % Dump the filters a row at a time
    for r = 1:p.fb.filter_size
        fprintf(fd,'%f ',fb{i_f}(r,:));
        fprintf(fd,'\n');
    end
end
fclose(fd);

end