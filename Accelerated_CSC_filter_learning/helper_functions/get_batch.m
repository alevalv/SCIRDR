function [batch] = get_batch(p,imgs,masks,N)

    %N is the number of large patches in the batch
    batch = cell(N,1);
    for i=1:N
        in_mask = false;
        while (~in_mask)
            img_no = randi(length(imgs));
            img = imgs{img_no};
            rand_row = randi(size(img,1)-p.data.patch_size+1);
            rand_col = randi(size(img,2)-p.data.patch_size+1);
            mask_patch = masks{img_no}(rand_row:rand_row+p.data.patch_size-1,rand_col:rand_col+p.data.patch_size-1);
            in_mask = min(mask_patch(:)>0);
        end

        batch{i} = imgs{img_no}(rand_row:rand_row+p.data.patch_size-1,rand_col:rand_col+p.data.patch_size-1);
    end
end