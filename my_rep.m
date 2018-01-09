function [a] = my_rep(data)
% All the image porcessing is done in this function

width = 16;     % afmetingen van de images (x bij y)

num_box = im_box(data,[],1); % add bounding box to make all images same size
num_box_dwn = im_resize(num_box,[width,width]); % Downsample

%% Image processing
image_processed = zeros(width, width, length(num_box_dwn)); % set matrix dimensions to improve speed

for i = 1:length(num_box_dwn)
    h = waitbar(i/length(num_box_dwn));
    image = data2im(num_box_dwn(i));

    %image2 = image(:,[1:2]);
    image_clean = bwmorph(image, 'clean', 2); % remove single pixels
    image_clean = bwareaopen(image_clean, 5); % remove small blobs of pixels

    % ----Image Operation with potential benefits, but doesn't work yet...----
    % image_open = bwmorph(image_clean, 'open', 1);
    % image_skel = bwmorph(image_clean, 'skel', Inf);
    % image_end = bwmorph(image_skel, 'endpoints', 1);
    % image_branch = bwmorph(image_skel, 'branchpoints', 1);
    % image_seed = imadd(image_end, image_branch);
    % image_seed = (image_seed > 0.5);
    % image_adapt = im_bpropagation(image_end, m(i));
    %image_reshape = reshape(image_adapt.',1,[]);
    %image_processed2(i,:) = image_reshape;
    % ------------------------------------------------------------------------

    image_processed(:,:,i) = image_clean; % store every image in the same matrix
end
close(h)
obj_processed = im2obj(image_processed);
obj_processed_gauss = im_gauss(obj_processed, 0.8, 0.8, 'full'); % gauss-filter over de images om losse pixels te verwijderen

%% End of image processing
a_raw = prdataset(obj_processed_gauss, getlab(num_box_dwn)); % nieuwe dataset met bewerkte images

% a_feat = im_features(a_raw,a_raw,{'Area','Centroid','ConvexArea','Eccentricity','EquivDiameter','EulerNumber','Extent','FilledArea','MajorAxisLength','MinorAxisLength','Orientation','Perimeter','Solidity'});
% a = a(:,[1,2,3,9:14]);
a_feat = im_features(a_raw,a_raw,{'Area','Centroid','FilledArea','MajorAxisLength','MinorAxisLength','Orientation','Perimeter','Solidity'});

W_dom = scalem(a_feat,'domain');

a = a_feat*W_dom;

end

