%% class_pixeldata.m
% This m-file trains a classifier to distinguish numbers from the
% NIST-list. It uses pixeldata to accomplish this. It is started by
% NIST_start.m

%% 
clear all; close all; clc; 
prwaitbar off;
display('loading')
m = prnist([0,1,2,3,4,5,6,7,8,9],[1:1000]);
a = my_rep(m);

%% 
display('training')
u = pcam([],0.9)*parzenc;


display('crossvalidating')
eCross = prcrossval(a,u,10,1);


display('benchmark-testing')
w = a*u;
e = nist_eval('my_rep',w,100);