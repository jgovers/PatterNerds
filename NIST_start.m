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
end

prwaitbar off
prwarning off
% run('C:\Program Files\DIPimage 2.8.1\dipstart.m') % check if you have
% dip-toolbox and download it if you haven't!
clc

%% Load in NIST-data
toc
Nsamp       = 20;
Ntrn        = 10;
Ntrn_tst    = 0;
Ntst        = Nsamp - (Ntrn+Ntrn_tst);
samp        = randsample(1000,Nsamp);
samptrn     = samp(1:Ntrn)';
% samptrn_tst = samp(Ntrn+1:(Ntrn+Ntrn_tst))';
samptst     = samp((Nsamp-Ntst+1):Nsamp)';  

data_trn        = prnist(0:9,samptrn);      % Read in training data
% data_trn_tst    = prnist(0:9,samptrn_tst);
data_tst        = prnist(0:9,samptst);      % Read in test data

disp('Preprocessing data in my_rep...')
W_dis = [];
a_trn   = my_rep(data_trn);
% a_trn_tst   = my_rep(data_trn_tst);
toc
a_tst   = my_rep(data_tst);
toc

%%
disp('Selecting features...')
% [W_qdc,RES_qdc] = featsellr(a_trn,qdc([]),[],2,1,a_tst);
% a_trn_qdcm = a_trn*W_qdc;
% % a_tst_qdcm = a_tst*W_qdc;
% 
% [W_ldcfeat,RES_ldc] = featsellr(a_trn,ldc([]),[],2,1);
% a_trn_ldcm = a_trn*W_ldcfeat;
% a_tst_ldcm = a_tst*W_ldcfeat;

% [W_ldcfeattst,RES_ldctst] = featsellr(a_trn,ldc([]),[],2,1,a_trn_tst);
% a_trntst_ldcm = a_trn*W_ldcfeattst;
% a_tsttst_ldcm = a_tst*W_ldcfeattst;

% W_pca = pca(a_trn,21);
% a_trn_ldcm = a_trn*W_pca;
% a_tst_ldcm = a_tst*W_pca;

%% Classiefier training and evaluation
toc
disp('Training and testing classifiers...')
% W_qdc = qdc(a_trn);
% [E_qdc,C_qdc] = testd(a_tst*W_qdc)
% 
% W_qdcm = qdc(a_trn_qdcm);
% [E_qdcm,C_qdcm] = testd(a_tst_qdcm*W_qdcm)
% a_trn_com = a_trn;
% a_trn_com(size(a_trn,1)+1:size(a_trn,1)+size(a_trn_tst),:) = a_trn_tst;

W_ldc = ldc(a_trn);
[E_ldc,C_ldc] = testd(a_tst*W_ldc)

% W_ldcm = ldc(a_trn_ldcm);
% [E_ldcm,C_ldcm] = testd(a_tst_ldcm*W_ldcm)
% 
% W_ldctstm = ldc(a_trntst_ldcm);
% [E_ldctstm,C_ldctstm] = testd(a_tsttst_ldcm*W_ldctstm)

%%
% e_ldc = nist_eval('my_rep',W_ldc,100)
toc
disp('Done')