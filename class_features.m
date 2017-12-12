%% Feature Extraction
toc
disp('Extracting training features...')
x_trn   = im_features(num_trn_box,num_trn_box,{'Area','Centroid','ConvexArea','Eccentricity','EquivDiameter','EulerNumber','Extent','FilledArea','MajorAxisLength','MinorAxisLength','Orientation','Perimeter','Solidity'});
x_trn_n = normc(+x_trn);
x_trn_n = prdataset(x_trn_n,getlab(x_trn));

toc
disp('Extracting testing features...')
x_tst   = im_features(num_tst_box,num_tst_box,{'Area','Centroid','ConvexArea','Eccentricity','EquivDiameter','EulerNumber','Extent','FilledArea','MajorAxisLength','MinorAxisLength','Orientation','Perimeter','Solidity'});
x_tst_n = normc(+x_tst);
x_tst_n = prdataset(x_tst_n,getlab(x_tst));


%% Classification
% Training
toc
W_nmc = nmc(x_trn);
W_nmc_n = nmc(x_trn_n);
[W_ldc,R_ldc,S_ldc,M_ldc] = ldc(x_trn);
W_fis = fisherc(x_trn);
W_log = loglc(x_trn);
[W_par,H_par] = parzenc(x_trn);

% Testing
toc
[E_nmc,C_nmc] = testc(x_tst,W_nmc);
[E_nmc_n,C_nmc_n] = testc(x_tst_n,W_nmc_n);
[E_ldc,C_ldc] = testc(x_tst,W_ldc);
[E_fis,C_fis] = testc(x_tst,W_fis);
[E_log,C_log] = testc(x_tst,W_log);
[E_par,C_par] = testc(x_tst,W_par);

%% Plot
toc
if doplots
    if size(num_trn,1) < 500
        figure; show(num_trn_box);
        figure; show(num_tst_box);
    end
   figure; bar([E_nmc,E_nmc_n,E_ldc,E_fis,E_log,E_par]);
   figure; bar([C_nmc;C_nmc_n;C_ldc;C_fis;C_log;C_par]');
   showfigs
end
toc