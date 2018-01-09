%% create dataset
%!!! use only for Case 2! (batch check of cheques)
display('loading data')
samp = randsample(1000,10); % randomize data to train on, 10 digits per class
m = prnist([0,1,2,3,4,5,6,7,8,9],samp); 
a = my_rep(m);

%% 
display('crossvalidating')

var = [0.9 0.91 0.92 0.93 0.94 0.95];
%eCross = zeros(
for i = 1:6
    u = pcam([],var(i))*ldc; % ldc met 0.95 geeft e = 0.2450
    eCross(i) = prcrossval(a,u,20,1);
    w = a*u;
    e(i) = nist_eval('my_rep',w,100);
end