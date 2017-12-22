%% create dataset
display('loading data')
m = prnist([0,1,2,3,4,5,6,7,8,9],[1:1000]);
a = my_rep(m);

%% 
display('crossvalidating')

var = [0.9 0.91 0.92 0.93 0.94 0.95];
for i = 1:6
    u = pcam([],var(i))*parzenc;
    eCross(i) = prcrossval(a,u,20,1);
    w = a*u;
    e(i) = nist_eval('my_rep',w,100);
end