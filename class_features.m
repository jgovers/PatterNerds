%% Feature Extraction
toc
x_tr    = im_features(num_tr_box,num_tr_box,{'Area','Centroid','ConvexArea','Eccentricity','EquivDiameter','EulerNumber','Extent','FilledArea','MajorAxisLength','MinorAxisLength','Orientation','Perimeter','Solidity'});
toc
x_test  = im_features(num_test_box,num_test_box,{'Area','Centroid','ConvexArea','Eccentricity','EquivDiameter','EulerNumber','Extent','FilledArea','MajorAxisLength','MinorAxisLength','Orientation','Perimeter','Solidity'});

%% Classification
% Training
toc
W_nmc = nmc(x_tr);
[W_ldc,R_ldc,S_ldc,M_ldc] = ldc(x_tr);
W_fis = fisherc(x_tr);
W_log = loglc(x_tr);
[W_par,H_par] = parzenc(x_tr);

% Testing
toc
[E_nmc,C_nmc] = testc(x_test,W_nmc);
[E_ldc,C_ldc] = testc(x_test,W_ldc);
[E_fis,C_fis] = testc(x_test,W_fis);
[E_log,C_log] = testc(x_test,W_log);
[E_par,C_par] = testc(x_test,W_par);

%% Plot
toc
if doplots
    if size(num_test,1) < 50
        figure; show(num_tr_box);
        figure; show(num_test_box);
    end
   figure; bar([E_nmc,E_ldc,E_fis,E_log,E_par]);
   figure; bar([C_nmc;C_ldc;C_fis;C_log;C_par]');
   showfigs
end
toc