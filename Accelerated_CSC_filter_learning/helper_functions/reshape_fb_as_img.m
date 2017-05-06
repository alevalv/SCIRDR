function [fb_img] = reshape_fb_as_img(p,fb)
%  reshape_fb_as_img  Reshape a filter bank as an image where each filter
%                     constitutes a block in a matrix
%
%  Synopsis:
%     [fb_img] = reshape_fb_as_img(p,fb)
%
%  Input:
%     p  = structure containing the parameters required by the system
%     fb = cell array containing the filters
%  Output:
%     fb_img = filter bank reshaped as image

%  author: Roberto Rigamonti, CVLab EPFL
%  e-mail: roberto <dot> rigamonti <at> epfl <dot> ch
%  web: http://cvlab.epfl.ch/~rigamont
%  date: June 2012
%  last revision: 21 June 2012

% Total number of blocks
blocks_no = length(fb);
% Number of rows in the block matrix
blocks_rows_no = ceil(sqrt(blocks_no));
% Number of cols in the block matrix
blocks_cols_no = ceil(sqrt(blocks_no));

filters_size = size(fb{1},1);

% Allocate the image with white background and the proper size
fb_img = 255*ones(blocks_rows_no*filters_size*p.results.pixel_size+(blocks_rows_no-1)*p.results.v_space,blocks_cols_no*filters_size*p.results.pixel_size+(blocks_cols_no-1)*p.results.h_space);

i_row = 0;
i_col = 0;
for i_filter = 1:length(fb)
    if(i_col==blocks_cols_no)
        i_row = i_row+1;
        i_col = 0;
    end
    
    % Magnify the filter and convert it to image
    filter_img = convert_img_visualization(magnify_matrix(fb{i_filter},p.results.pixel_size));
    % Set the filter in the image
    fb_img(i_row*(filters_size*p.results.pixel_size+p.results.v_space)+1:(i_row+1)*filters_size*p.results.pixel_size+i_row*p.results.v_space,i_col*(filters_size*p.results.pixel_size+p.results.h_space)+1:(i_col+1)*filters_size*p.results.pixel_size+i_col*p.results.h_space) = filter_img;
    
    i_col = i_col+1;
end

end