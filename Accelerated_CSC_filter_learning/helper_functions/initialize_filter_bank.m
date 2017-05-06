function [fb] = initialize_filter_bank(p)
%  initialize_filter_bank  Initialize a filter bank according to the specified
%                          parameters
%
%  Synopsis:
%     [fb] = initialize_filter_banks(p)
%
%  Input:
%     p = structure containing framework's configuration
%  Output:
%     fb = cell array containing the initialized image filter bank

%  author: Roberto Rigamonti, CVLab EPFL
%  e-mail: roberto <dot> rigamonti <at> epfl <dot> ch
%  web: http://cvlab.epfl.ch/~rigamont
%  date: June 2012
%  last revision: 21 June 2012

fb = cell(p.fb.filters_no,1);

% Initialize a new filter bank with random values (the first one is set to a
% uniform value)
fb{1} = 1/(p.fb.filter_size^2)*ones(p.fb.filter_size);
for i_f = 2:p.fb.filters_no
    fb{i_f} = randn(p.fb.filter_size);
end
%  Normalize the filter bank
for i_f = 1:p.fb.filters_no
    fb{i_f} = fb{i_f}/(norm(fb{i_f}(:)));
end

end