function [a] = my_rep(m)
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here

width = 16;

b = im_box([],0,1)*im_resize([],[width,width])*im_gauss([], 0.6, 0.6, 'full');
b = m*b;
labels = getlab(b);
a = prdataset(b,labels);

%% vanaf hier is het sebas werk
% width = 16;
% b = im_box([],0,1)*im_resize([],[width,width]);
% m = m*b;
% 
% i = 0; 
% image_processed2 = zeros(width, width, length(m)); % set matrix dimensions to improve speed
% 
% for i = 1:length(m)
% image = data2im(m(i));
% 
% %image2 = image(:,[1:2]);
% image_clean = bwmorph(image, 'clean', 2); % remove single pixels
% image_clean2 = bwareaopen(image_clean, 5); % remove small blobs of pixels
% 
% % ----Image Operation with potential benefits, but doesn't work yet...----
% % image_open = bwmorph(image_clean, 'open', 1);
% % image_skel = bwmorph(image_clean, 'skel', Inf);
% % image_end = bwmorph(image_skel, 'endpoints', 1);
% % image_branch = bwmorph(image_skel, 'branchpoints', 1);
% % image_seed = imadd(image_end, image_branch);
% % image_seed = (image_seed > 0.5);
% % image_adapt = im_bpropagation(image_end, m(i));
% %image_reshape = reshape(image_adapt.',1,[]);
% %image_processed(i,:) = image_reshape;
% % ------------------------------------------------------------------------
% 
% image_adapt = image_clean2;
% image_processed2(:,:,i) = image_adapt; % store every image in the same matrix
% 
% end
% 
% images_processed = im2obj(image_processed2);
% images_processed_gauss = im_gauss(images_processed, 0.8, 0.8, 'full'); % gauss-filter over de images om losse pixels te verwijderen
% a = prdataset(images_processed_gauss, getlab(m)); % nieuwe dataset met bewerkte images



end

