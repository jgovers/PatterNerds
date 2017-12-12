%% class_pixeldata.m
% This m-file trains a classifier to distinguish numbers from the
% NIST-list. It uses pixeldata to accomplish this. It is started by
% NIST_start.m

%% 
clear all
close all
clc
prwaitbar off

width = 26;

train = prnist([0,1,2,3,4,5,6,7,8,9],[1:900]);
train = im_box(train,[],1);
train = im_resize(train,[width,width]);
train = im_gauss(train, 0.6, 0.6, 'full');
labtrain = getlab(train);
train = prdataset(train,labtrain);

test = prnist([0,1,2,3,4,5,6,7,8,9],[901:1000]);
test = im_box(test,[],1);
test = im_resize(test,[width,width]);
test = im_gauss(test, 0.6, 0.6, 'full');
labtest = getlab(test);
test = prdataset(test,labtest);

[selection, ~] = pcam(train,20);
train = train*selection;
test = test*selection;


%%
w = qdc(train);
[e, o] = test*w*testc;