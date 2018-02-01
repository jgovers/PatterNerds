function [a] = my_rep(data)
% All the image porcessing is done in this function
global W_dis

width = 16;     % afmetingen van de images (x bij y)

num_box     = im_box(data,[],1);                % add bounding box to make all images same size
num_box_dwn = im_resize(num_box,[width,width]); % Downsample

%% Image processing
image_processed = zeros(width, width, length(num_box_dwn)); % set matrix dimensions to improve speed

Nloop = length(num_box_dwn);

parfor i = 1:Nloop
    image = data2im(num_box_dwn(i));
    image_clean = bwmorph(image, 'clean', 2);   % remove single pixels
    image_clean = bwareaopen(image_clean, 5);   % remove small blobs of pixels
    image_processed(:,:,i) = image_clean;       % store every image in the same matrix
end
obj_processed = im2obj(image_processed);
obj_processed_gauss = im_gauss(obj_processed, 0.8, 0.8, 'full');    % gauss-filter over de images om losse pixels te verwijderen

%% End of image processing
a_raw = prdataset(obj_processed_gauss, getlab(num_box_dwn));        % nieuwe dataset met bewerkte images

if isempty(W_dis)
    W_dis = proxm(a_raw,'c');
    a_temp = a_raw*W_dis;
    W_dis = W_dis*pcam(a_temp,29);
end

a = a_raw*W_dis;   

end