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
global W_dis

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
toc

Nsamp   = 4;
Ntrn    = 2;
Ntst    = Nsamp - Ntrn;
samp    = randsample(1000,Nsamp);
samptrn = samp(1:Ntrn)';
samptst = samp(Ntrn+1:Nsamp)';

data_trn = prnist(0:9,samptrn);     % Read in training data
data_tst = prnist(0:9,samptst); 	% Read in test data

disp('Preprocessing data in my_rep...')
W_dis = [];
a_trn = my_rep(data_trn);
toc
a_tst = my_rep(data_tst);
toc
disp('Selecting features')
% [W_qdc,RES_qdc] = featsellr(a_trn,qdc([]),[],2,1,a_tst);
% a_trn_qdcm = a_trn*W_qdc;
% % a_tst_qdcm = a_tst*W_qdc;
% 
[W_ldcfeat,RES_ldc] = featsellr(a_trn,ldc([]),[],2,1,a_tst);
a_trn_ldcm = a_trn*W_ldcfeat;
a_tst_ldcm = a_tst*W_ldcfeat;

% W_pca = pca(a_trn,21);
% a_trn_ldcm = a_trn*W_pca;
% a_tst_ldcm = a_tst*W_pca;

%% 
toc
% W_qdc = qdc(a_trn);
% [E_qdc,C_qdc] = testd(a_tst*W_qdc)
% 
% W_qdcm = qdc(a_trn_qdcm);
% [E_qdcm,C_qdcm] = testd(a_tst_qdcm*W_qdcm)

W_ldc = ldc(a_trn);
[E_ldc,C_ldc] = testd(a_tst*W_ldc)

W_ldcm = ldc(a_trn_ldcm);
[E_ldcm,C_ldcm] = testd(a_tst_ldcm*W_ldcm)

%% Plots
if doplots
    figure; show(a_trn);
    figure; show(a_tst);
    showfigs
end

toc
disp('Done')