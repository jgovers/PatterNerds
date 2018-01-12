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
global a_trn

firsttime   = true;
doplots     = true;

if firsttime 
    addpath(genpath(pwd))
end

prwaitbar off
prwarning off
% run('C:\Program Files\DIPimage 2.8.1\dipstart.m') % check if you have
% dip-toolbox and download it if you haven't!

%% Load in NIST-data
toc

Nsamp   = 20;
Ntrn    = 10;
Ntst    = Nsamp - Ntrn;
samp    = randsample(1000,Nsamp);
samptrn = samp(1:Ntrn)';
samptst = samp(Ntrn+1:Nsamp)';

data_trn = prnist(0:9,samptrn);     % Read in training data
data_tst = prnist(0:9,samptst); 	% Read in test data

disp('Preprocessing data in my_rep...')
a_trn = 0;
a_trn = my_rep(data_trn);
toc
a_tst = my_rep(data_tst);
toc

%% Plots
if doplots
    figure; show(a_trn);
    figure; show(a_tst);
    showfigs
end
nist_eval

%% Run the desired classification method
% !! maybe in the future build functions out of each classification method?

% run class_pixeldata.m
% run class_features.m
% run class_dissimil.m

toc
disp('Done')