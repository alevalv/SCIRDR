function [imgs,masks] = load_dataset(p)
%  load_dataset  Load images and masks for the considered dataset
%
%  Synopsis:
%     [imgs,masks] = load_dataset(p)
%
%  Input:
%     p = structure containing the parameters and the paths required by the
%         system
%  Ouput:
%     imgs  = cell array containing the dataset's images
%     masks = cell array containing the dataset's masks

%  author: Roberto Rigamonti, CVLab EPFL
%  e-mail: roberto <dot> rigamonti <at> epfl <dot> ch
%  web: http://cvlab.epfl.ch/~rigamont
%  date: June 2012
%  last revision: 21 June 2012

 [imgs_list,imgs_no] = get_list(p.data.imgs_filelist);
 [masks_list,masks_no] = get_list(p.data.masks_filelist);


    
imgs = cell(imgs_no,1);
masks = cell(masks_no,1);

for i_img = 1:imgs_no
    tmp_img = im2double(imread(imgs_list{i_img}));
    masks{i_img} = im2bw(imread(masks_list{i_img}));
    % Make images zero-mean, unit-variance
    imgs{i_img} = (tmp_img-mean(tmp_img(masks{i_img}~=0)))./(std(tmp_img(masks{i_img}~=0)));
end

end