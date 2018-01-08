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
doplots     = false;

if firsttime 
    addpath(genpath(pwd))
end

prwaitbar off
prwarning off
% run('C:\Program Files\DIPimage 2.8.1\dipstart.m') % check if you have
% dip-toolbox and download it if you haven't!

%% Load in NIST-data
data = prnist([0:9],[1:end]);        % Read in training data
% data_tst = prnist([0:9],[990:1000]); 	% Read in test data

toc
disp('Preprocessing data in my_rep...')
a = my_rep(data);
toc
% a_tst = my_rep(data_tst);
% toc

save('all_processed_images','a')

%% Plots
if doplots
    figure; show(a_trn);
%     figure; show(a_tst);
    showfigs
end

%% Run the desired classification method
% !! maybe in the future build functions out of each classification method?

% run class_pixeldata.m
% run class_features.m
% run class_dissimil.m

toc
disp('Done')