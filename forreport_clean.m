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

clc

%% Load in NIST-data
Nsamp       = 110;
Ntrn        = 10;
Ntst        = Nsamp - Ntrn;
Nit         = 3;
data_trn    = cell(1,Nit);
data_tst    = cell(1,Nit);
a_trn       = cell(1,Nit);
a_tst       = cell(1,Nit);
W           = cell(2,Nit);
E           = zeros(2,Nit);
C           = cell(2,Nit);

%%
disp('Starting iterations')

for i = 1:Nit
    toc
    samp        = randsample(1000,Nsamp);
    samptrn     = samp(1:Ntrn)';
    samptst     = samp((Nsamp-Ntst+1):Nsamp)';  

    data_trn{i} = prnist(0:9,samptrn); 
    data_tst{i} = prnist(0:9,samptst); 

    W_dis = [];
    a_trn{i}   = my_rep(data_trn{i});
    a_tst{i}   = my_rep(data_tst{i});

    W{1,i} = ldc(a_trn{i});
    [E(1,i),C{1,i}] = testd(a_tst{i}*W{1,i});
   
    W{2,i} = qdc(a_trn{i});
    [E(2,i),C{2,i}] = testd(a_tst{i}*W{2,i});

end

%%
disp('Done')
toc