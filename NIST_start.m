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

data_trn        = prnist(0:9,samptrn);      % Read in training data
data_tst        = prnist(0:9,samptst);      % Read in test data

%%
disp('Preprocessing data in my_rep...')
W_dis = [];
a_trn   = my_rep(data_trn);
toc
a_tst   = my_rep(data_tst);

%% Classiefier training and evaluation
toc
disp('Training and testing classifiers...')

E = zeros(1,99);
C = zeros(1,10,99);

parfor i = 2:100
    
    prwarning off
    Wpca = a_trn*pcam(a_trn,i);
    d_tst = a_tst*pcam(a_trn,i);
    
    Wldc = Wpca*ldc([]);
%     Wqdc = Wpca*qdc([]);
%     Wsvc = Wpca*svc([]);
%     Wpar = Wpca*parzenc([]);
%     Wnmc = Wpca*nmc([]);
%     Wknn = Wpca*knnc([]);
    
    Ei = zeros(1,1);
    Ci = zeros(1,10);
    [Ei(1),Ci(1,:)] = testd(d_tst*Wldc);
%     [Ei(2),Ci(2,:)] = testd(d_tst*Wqdc);
%     [Ei(3),Ci(3,:)] = testd(d_tst*Wsvc);
%     [Ei(4),Ci(4,:)] = testd(d_tst*Wpar);
%     [Ei(5),Ci(5,:)] = testd(d_tst*Wnmc);
%     [Ei(6),Ci(6,:)] = testd(d_tst*Wknn);

    E(:,i) = Ei;
    C(:,:,i) = Ci;
     
end

%%
figure; hold on;
for i = 1:1
    plot(E(i,:))
end
legend('ldc','qdc','svc','parzenc','nmc','knnc')

%%
% e_ldc = nist_eval('my_rep',W_ldc,100)
toc
save('dissim_1-2-1555')
disp('Done')