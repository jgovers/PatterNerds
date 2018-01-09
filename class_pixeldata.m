%% class_pixeldata.m
% This m-file trains a classifier to distinguish numbers from the
% NIST-list. It uses pixeldata to accomplish this. It is started by
% NIST_start.m
% !!! Use for Case 2 only! (batch of cheques to be processed, 100 digits
% each time !!!

%% 
clear all; close all; clc; 
prwaitbar off;
display('loading')
samp = randsample(1000,10);
m = prnist([0,1,2,3,4,5,6,7,8,9],samp); % should be 1:1000
a = my_rep(m);

%% 
display('training')
u = pcam([],0.95)*ldc; 

display('crossvalidating')
eCross = prcrossval(a,u,10,1);


display('benchmark-testing')
w = a*u;
e = nist_eval('my_rep',w,100);