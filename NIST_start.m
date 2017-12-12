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

%% Load in NIST-data
num = prnist([0,1,2,3,4,5,6,7,8,9],[1:10]); % read in data
num_box = im_box(num,[],1); % add bounding box to make all images same size
num_box_dwn = im_resize(num_box,[25,25]); % Downsample
num_box_dwn_gauss = im_gauss(num_box_dwn, 0.8, 0.8, 'full'); % gauss-filter over de images om losse pixels te verwijderen
numset = prdataset(num_box_dwn_gauss, getlab(num)); % turn datafile to dataset (see documentation for why)

% Vanaf 'numset' kunnen allerlei image operations gebruikt worden. Zie de 
% Lab-manual pagina 113. Hieronder de syntax voor een erosion
% im_bpropagation lijkt handig om slecht geschreven lijnen te corrigeren,
% maar geeft een rare foutmelding....
% numset_ero = im_berosion(numset, 1, 4, 1);

% showing the preprocessed images
figure; show(numset) 

%% Run the desired classification method
% !! maybe in the future build functions out of each classification method?

% run class_pixeldata.m
% run class_features.m
% run class_dissimil.m