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
doplots     = false;

if firsttime 
    addpath(genpath(pwd))
end

prwaitbar off

%% Load in NIST-data
num = prnist([0,1,2,3,4,5,6,7,8,9],[1:10]); % read in data
num_box = im_box(num,[],1); % add bounding box to make all images same size
num_box_dwn = im_resize(num_box,[25,25]); % Downsample

%% Run the desired classification method
% !! maybe in the future build functions out of each classification method?

% run class_pixeldata.m
run class_features.m
% run class_dissimil.m