prwaitbar off

samp = randsample(1000,10)
m = prnist(0:9,samp);
a = my_rep(m);

w_pca = parzenc;%pcam([],0.9)*
w = a*w_pca;

e = nist_eval('my_rep',w,100)