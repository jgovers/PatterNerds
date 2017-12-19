%% create dataset
display('loading data')
m = prnist([0,1,2,3,4,5,6,7,8,9],[1:1000]);
a = my_rep(m);

%% 
display('crossvalidating')
u = pcam([],0.9)*qdc;
eCross = prcrossval(a,u,20,1);
w = a*u;
e = nist_eval('my_rep',w,100);