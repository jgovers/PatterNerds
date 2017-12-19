%% class_pixeldata.m
% This m-file trains a classifier to distinguish numbers from the
% NIST-list. It uses pixeldata to accomplish this. It is started by
% NIST_start.m

%% 
clear all
close all
clc
prwaitbar off

width = 32;

a = im_box([],0,1)*im_resize([],[width,width])*im_gauss([], 0.6, 0.6, 'full');

'preparing trainset'
train = prnist([0,1,2,3,4,5,6,7,8,9],[1:900]);
train = train*a;
labtrain = getlab(train);
trainset = prdataset(train,labtrain);

'preparing testset'
test = prnist([0,1,2,3,4,5,6,7,8,9],[901:1000]);
test = test*a;
labtest = getlab(test);
testset = prdataset(test,labtest);

%%

'scaling'
b = scalem(trainset,'c-mean');
c = scalem(trainset,'c-variance');

'feature extraction'
[ext, ~] = pcam(trainset,0.9);

% 'feature extraction2'
% ext2 = fisherm(train);

'training'
u = ext*qdc;
w = trainset*u;
[e, o] = testset*w*testc