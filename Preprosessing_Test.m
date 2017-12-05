

% !!!!! remove clearing if converted to function !!!!!!
clear all
close all
clc

prwaitbar off

%% Reading in NIST data
a = prnist([0,1,2,3,4,5,6,7,8,9],[1:10]); figure; show(a) % read in data
b = im_box(a,[],1); figure; show(b) % add bounding box to make all images same size
c = im_resize(b,[25,25]); figure; show(c) % Downsample
d = im_mean(c); % compute mean
d = prdataset(d,[],'featlab',char('mean-x','mean-y')); % place mean in dataset
figure
scatterd(d, 'legend') % visualize

%% Image processing
% start up image processing library, download at http://www.diplib.org/download
run('C:\Program Files\DIPimage 2.8.1\dipstart.m') 

%% 
features = 'center'; % see measurementhelp to check all available measures
%features = 'all';
F = im_measure(b, features); 
figure
scatterd(F, 'legend');