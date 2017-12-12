%% NIST_start.m
%  This m-file starts op the process for the image-classification of 
%  numbers from the NIST-list. It loads in the selected data, and asks the
%  user which methid should be used.
%% TU Delft, Stijn van der Smagt, Jurriaan Govers, Sebastiaan Joosten

%% initialize
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

%% Load in NIST-data
toc
% Training data
num_tr          = prnist([0:9],[1:900]);             % Read in data
num_tr_box      = im_box(num_tr,[],1);              % Add bounding box to make all images same size
num_tr_box_dwn  = im_resize(num_tr_box,[25,25]);    % Downsample

% Test data
num_test         = prnist([0:9],[901:1000]);           % Read in data
num_test_box     = im_box(num_test,[],1);           % Add bounding box to make all images same size
num_test_box_dwn = im_resize(num_test_box,[25,25]); % Downsample

%% Run the desired classification method
% !! maybe in the future build functions out of each classification method?
toc

% run class_pixeldata.m
run class_features.m
% run class_dissimil.m