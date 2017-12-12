%% !!!!! remove clearing if converted to function !!!!!!
clear all
close all
clc

tic

firsttime   = false;
doplots     = true;

if firsttime 
    addpath(genpath(pwd))
end

prwaitbar off

%% Reading in NIST data
toc
a = prnist([0:9],[1:10]); % read in data
toc
b = im_box(a,[],1); % add bounding box to make all images same size
toc

%% Image Processing
x1 = im_features(b,b,{'Area','Centroid'});
x2 = im_features(b,b,{'Perimeter','Eccentricity','EulerNumber'});
toc
%% Plot
if doplots
   figure; show(a);
   figure; show(b);
   figure; scatterd(x1,3,'legend')
   figure; scatterd(x2,3,'legend')
   showfigs
end
toc