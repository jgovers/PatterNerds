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
prwarning off
% run('C:\Program Files\DIPimage 2.8.1\dipstart.m') % check if you have
% dip-toolbox and download it if you haven't!

%% Load in NIST-data
% Training data
num_trn                 = prnist([0:9],[1:]);                             % read in data
num_trn_box             = im_box(num_trn,[],1);                             % add bounding box to make all images same size
num_trn_box_dwn         = im_resize(num_trn_box,[25,25]);                   % Downsample
num_trn_box_dwn_gauss   = im_gauss(num_trn_box_dwn, 0.8, 0.8, 'full');      % gauss-filter over de images om losse pixels te verwijderen
numset_trn              = prdataset(num_trn_box_dwn_gauss, getlab(num_trn));% turn datafile to dataset (see documentation for why)

% Testing data
num_tst                 = prnist([0:9],[990:1000]);                         % read in data
num_tst_box             = im_box(num_tst,[],1);                             % add bounding box to make all images same size
num_tst_box_dwn         = im_resize(num_tst_box,[25,25]);                   % Downsample
num_tst_box_dwn_gauss   = im_gauss(num_tst_box_dwn, 0.8, 0.8, 'full');      % gauss-filter over de images om losse pixels te verwijderen
numset_tst              = prdataset(num_tst_box_dwn_gauss, getlab(num_tst));% turn datafile to dataset (see documentation for why)

% Vanaf 'numset' kunnen allerlei image operations gebruikt worden. Zie de 
% Lab-manual pagina 113. Hieronder de syntax voor een erosion
% im_bpropagation lijkt handig om slecht geschreven lijnen te corrigeren,
% maar geeft een rare foutmelding....
% numset_ero = im_berosion(numset, 1, 4, 1);

%% Run the desired classification method
% !! maybe in the future build functions out of each classification method?

% run class_pixeldata.m
run class_features.m
% run class_dissimil.m