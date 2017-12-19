function [a] = my_rep(m)
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here

width = 16;

b = im_box([],0,1)*im_resize([],[width,width])*im_gauss([], 0.6, 0.6, 'full');
b = m*b;
labels = getlab(b);
a = prdataset(b,labels);
end

