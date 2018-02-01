%% NIST_start.m
%  This m-file starts op the process for the image-classification of 
%  numbers from the NIST-list. It loads in the selected data, and asks the
%  user which methid should be used.
%% TU Delft, Stijn van der Smagt, Jurriaan Govers, Sebastiaan Joosten

%% initialize
clear all
close all
tic
global W_dis

firsttime   = input('First time? [y/n]','s');

if firsttime == 'y'
    addpath(genpath(pwd))
    mypool = parpool()
end

prwaitbar off
prwarning off

clc

%% Load in NIST-data
toc
Nsamp       = 1000;
Ntrn        = 10;
Ntst        = Nsamp - Ntrn;
samp        = randsample(1000,Nsamp);
samptrn     = samp(1:Ntrn)';
samptst     = samp((Nsamp-Ntst+1):Nsamp)';  

data_trn    = prnist(0:9,samptrn);      % Read in training data
data_tst    = prnist(0:9,samptst);      % Read in test data

%%
disp('Preprocessing data in my_rep...')
W_dis = [];
a_trn   = my_rep(data_trn);
toc
a_tst   = my_rep(data_tst);

%% Classiefier training and evaluation
toc
disp('Training and testing classifiers...')
    
Wldc = a_trn*ldc([]);
[E,C] = testd(a_tst*Wldc)

%%
e_eval = nist_eval('my_rep',Wldc,100)
toc
disp('Done')