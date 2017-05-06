function [sample] = get_sample(p,imgs,masks)
%  get_sample  Pick a sample, with the size specified in the configuration
%              structure, from the given dataset
%
%  Synopsis:
%     [sample] = get_sample(p,imgs,masks)
%
%  Input:
%     p     = structure containing framework's configuration
%     imgs  = cell array containing the dataset's images
%     masks = cell array containing the dataset's masks
%  Output:
%     sample = extracted random image sample

%  author: Roberto Rigamonti, CVLab EPFL
%  e-mail: roberto <dot> rigamonti <at> epfl <dot> ch
%  web: http://cvlab.epfl.ch/~rigamont
%  date: June 2012
%  last revision: 21 June 2012

in_mask = false;
while (~in_mask)
    img_no = randi(length(imgs));
    img = imgs{img_no};
    rand_row = randi(size(img,1)-p.data.patch_size+1);
    rand_col = randi(size(img,2)-p.data.patch_size+1);
    mask_patch = masks{img_no}(rand_row:rand_row+p.data.patch_size-1,rand_col:rand_col+p.data.patch_size-1);
    in_mask = min(mask_patch(:)>0);
end

sample = imgs{img_no}(rand_row:rand_row+p.data.patch_size-1,rand_col:rand_col+p.data.patch_size-1);

end