%% NIST_start.m
%  This m-file starts op the process for the image-classification of 
%  numbers from the NIST-list. It loads in the selected data, and asks the
%  user which methid should be used.
%% TU Delft, Stijn van der Smagt, Jurriaan Govers, Sebastiaan Joosten

%% initialize
clear all
close all
clc

firsttime   = false;
doplots     = true;

if firsttime 
    addpath(genpath(pwd))
end

prwaitbar off
 run('C:\Program Files\DIPimage 2.8.1\dipstart.m') % check if you have
% dip-toolbox and download it if you haven't!

%% Load in NIST-data
num = prnist([0,1,2,3,4,5,6,7,8,9],[1:10]); % read in data
num_box = im_box(num,[],1); % add bounding box to make all images same size
width = 32;
num_box_dwn = im_resize(num_box,[width,width]); % Downsample
num_box_dwn_gauss = im_gauss(num_box_dwn, 0.8, 0.8, 'full'); % gauss-filter over de images om losse pixels te verwijderen
numset = prdataset(num_box_dwn_gauss, getlab(num)); % turn datafile to dataset (see documentation for why)

% showing the preprocessed images
figure; show(numset) 
show(num_box_dwn)

%% Image Processing
i = 0;
image_processed2 = zeros(width, width, length(num_box_dwn));
%image_processed = zeros(length(num_box_dwn),im_dim^2);
%numsetzeros = zeros(length(num_box_dwn),im_dim^2);
%image_set = prdataset(numsetzeros, getlab(num_box_dwn));
for i = 1:length(num_box_dwn)
image = data2im(num_box_dwn(i));

%image2 = image(:,[1:2]);
image_clean = bwmorph(image, 'clean', 2); % remove single pixels
image_clean2 = bwareaopen(image_clean, 5); % remove small blobs of pixels

% ----Image Operation with potential benefits, but doesn't work yet...----
% image_open = bwmorph(image_clean, 'open', 1);
% image_skel = bwmorph(image_clean, 'skel', Inf);
% image_end = bwmorph(image_skel, 'endpoints', 1);
% image_branch = bwmorph(image_skel, 'branchpoints', 1);
% image_seed = imadd(image_end, image_branch);
% image_seed = (image_seed > 0.5);
% image_adapt = im_bpropagation(image_end, num_box_dwn(i));
%image_reshape = reshape(image_adapt.',1,[]);
%image_processed(i,:) = image_reshape;
% ------------------------------------------------------------------------

image_adapt = image_clean2;
image_processed2(:,:,i) = image_adapt; % store every image in the same matrix
%im2obj(image_processed);
%image_set = im2obj(image_skel, image_set);
%im2obj(image_skel, A);

end

images_processed = im2obj(image_processed2);
images_processed_gauss = im_gauss(images_processed, 0.8, 0.8, 'full'); % gauss-filter over de images om losse pixels te verwijderen
numset2 = prdataset(images_processed_gauss, getlab(num_box_dwn));

%numset2 = prdataset(image_processed, getlab(num_box_dwn));
%show(numset2)


%% Run the desired classification method
% !! maybe in the future build functions out of each classification method?

% run class_pixeldata.m
% run class_features.m
% run class_dissimil.m