%% Feature Extraction
toc
disp('Running module FEATURES')
disp('Extracting training features...')
x_trn   = im_features(numset_trn,numset_trn,{'Area','Centroid','ConvexArea','Eccentricity','EquivDiameter','EulerNumber','Extent','FilledArea','MajorAxisLength','MinorAxisLength','Orientation','Perimeter','Solidity'});

toc
disp('Extracting testing features...')
x_tst   = im_features(numset_tst,numset_tst,{'Area','Centroid','ConvexArea','Eccentricity','EquivDiameter','EulerNumber','Extent','FilledArea','MajorAxisLength','MinorAxisLength','Orientation','Perimeter','Solidity'});

%% Normalization

% LOOK AT scalem

x_trn_min = min(x_trn);
x_trn_max = max(x_trn);
x_trn_n = x_trn;
x_tst_n = x_tst;
for i = 1:size(x_trn,2)
    x_trn_n(:,i) = x_trn_n(:,i) - x_trn_min(i);
    x_trn_n(:,i) = x_trn_n(:,i)./(x_trn_max(i)-x_trn_min(i));
    x_tst_n(:,i) = x_tst_n(:,i) - x_trn_min(i);
    x_tst_n(:,i) = x_tst_n(:,i)./(x_trn_max(i)-x_trn_min(i));
end
x_tst_min = min(min(x_tst_n))
x_tst_max = max(max(x_tst_n))

%% Feature evaluation
[W_NN_for,    R_NN_for]    = featself(x_trn,'NN',0);
[W_NN_for_t,  R_NN_for_t]  = featself(x_trn,'NN',0,x_tst);
[W_NN_for_n,  R_NN_for_n]  = featself(x_trn_n,'NN',0);
[W_NN_for_nt, R_NN_for_nt] = featself(x_trn_n,'NN',0,x_tst_n);

[W_NN_bak,    R_NN_bak]    = featselb(x_trn,'NN',0);
[W_NN_bak_t,  R_NN_bak_t]  = featselb(x_trn,'NN',0,x_tst);
[W_NN_bak_n,  R_NN_bak_n]  = featselb(x_trn_n,'NN',0);
[W_NN_bak_nt, R_NN_bak_nt] = featselb(x_trn_n,'NN',0,x_tst_n);

[W_NN_lr,    R_NN_lr]    = featsellr(x_trn,'NN',0,2,1);
[W_NN_lr_t,  R_NN_lr_t]  = featsellr(x_trn,'NN',0,2,1,x_tst);
[W_NN_lr_n,  R_NN_lr_n]  = featsellr(x_trn_n,'NN',0,2,1);
[W_NN_lr_nt, R_NN_lr_nt] = featsellr(x_trn_n,'NN',0,2,1,x_tst_n);

W_sizes = [size(W_NN_for,2),size(W_NN_for_t,2),size(W_NN_for_n,2),size(W_NN_for_nt,2),...
    size(W_NN_bak,2),size(W_NN_bak_t,2),size(W_NN_bak_n,2),size(W_NN_bak_nt,2),...
    size(W_NN_lr,2),size(W_NN_lr_t,2),size(W_NN_lr_n,2),size(W_NN_lr_nt,2)];
W_mean = round(mean(W_sizes))

W_int_for = intersect(intersect(intersect(+W_NN_for,+W_NN_for_t),+W_NN_for_n),+W_NN_for_nt)
W_int_bak = intersect(intersect(intersect(+W_NN_bak,+W_NN_bak_t),+W_NN_bak_n),+W_NN_bak_nt)
W_int_lr  = intersect(intersect(intersect(+W_NN_lr,+W_NN_lr_t),+W_NN_lr_n),+W_NN_lr_nt)

W_int_o  = intersect(intersect(+W_NN_for,+W_NN_bak),+W_NN_lr)
W_int_t  = intersect(intersect(+W_NN_for_t,+W_NN_bak_t),+W_NN_lr_t)
W_int_n  = intersect(intersect(+W_NN_for_n,+W_NN_bak_n),+W_NN_lr_n)
W_int_nt = intersect(intersect(+W_NN_for_nt,+W_NN_bak_nt),+W_NN_lr_nt)


figure
hold on 
plot(R_NN_for(:,1),R_NN_for(:,2))
plot(R_NN_for_t(:,1),R_NN_for_t(:,2))
plot(R_NN_for_n(:,1),R_NN_for_n(:,2))
plot(R_NN_for_nt(:,1),R_NN_for_nt(:,2))
legend('Original','Original w Test','Norm','Norm w Test')
title('Feature selection "Forward" "NN"')

figure
hold on 
plot(R_NN_bak(:,1),R_NN_bak(:,2))
plot(R_NN_bak_t(:,1),R_NN_bak_t(:,2))
plot(R_NN_bak_n(:,1),R_NN_bak_n(:,2))
plot(R_NN_bak_nt(:,1),R_NN_bak_nt(:,2))
legend('Original','Original w Test','Norm','Norm w Test')
title('Feature selection "Backward" "NN"')

figure
hold on 
plot(R_NN_lr(:,1),R_NN_lr(:,2))
plot(R_NN_lr_t(:,1),R_NN_lr_t(:,2))
plot(R_NN_lr_n(:,1),R_NN_lr_n(:,2))
plot(R_NN_lr_nt(:,1),R_NN_lr_nt(:,2))
legend('Original','Original w Test','Norm','Norm w Test')
title('Feature selection "Left Right" "NN"')

showfigs

%% Classification
% Training
toc
W_nmc = nmc(x_trn);
W_nmc_n = nmc(x_trn_n);
[W_ldc,R_ldc,S_ldc,M_ldc] = ldc(x_trn);
[W_ldc_n,R_ldc_n,S_ldc_n,M_ldc_n] = ldc(x_trn_n);
W_fis = fisherc(x_trn);
W_fis_n = fisherc(x_trn_n);
W_log = loglc(x_trn);
W_log_n = loglc(x_trn_n);
[W_par,H_par] = parzenc(x_trn_n);
[W_par_n,H_par_n] = parzenc(x_trn_n);

% Testing
toc
[E_nmc,C_nmc] = testc(x_tst,W_nmc);
[E_nmc_n,C_nmc_n] = testc(x_tst_n,W_nmc_n);
[E_ldc,C_ldc] = testc(x_tst,W_ldc);
[E_ldc_n,C_ldc_n] = testc(x_tst_n,W_ldc_n);
[E_fis,C_fis] = testc(x_tst,W_fis);
[E_fis_n,C_fis_n] = testc(x_tst_n,W_fis_n);
[E_log,C_log] = testc(x_tst,W_log);
[E_log_n,C_log_n] = testc(x_tst_n,W_log_n);
[E_par,C_par] = testc(x_tst,W_par);
[E_par_n,C_par_n] = testc(x_tst_n,W_par_n);


%% Plot
if doplots
    if size(num_trn,1) < 500
        figure; show(numset_trn); title('Training Samples');
        figure; show(numset_tst); title('Test Samples');
    end
   figure; bar([E_nmc,E_nmc_n,E_ldc,E_ldc_n,E_fis,E_fis_n,E_log,E_log_n,E_par,E_par_n]);
   figure; bar([C_nmc;C_nmc_n;C_ldc;C_ldc_n;C_fis;C_fis_n;C_log;C_log_n;C_par;C_par_n]');
   showfigs
end


%% Reserve
% [W_MS_for,    R_MS_for]    = featself(x_trn,'maha-s',0);
% % [W_MS_for_t,  R_MS_for_t]  = featself(x_trn,'maha-s',0,x_tst);
% [W_MS_for_n,  R_MS_for_n]  = featself(x_trn_n,'maha-s',0);
% % [W_MS_for_nt, R_MS_for_nt] = featself(x_trn_n,'maha-s',0,x_tst_n);
% 
% [W_MS_bak,    R_MS_bak]    = featselb(x_trn,'maha-s',0);
% % [W_MS_bak_t,  R_MS_bak_t]  = featselb(x_trn,'maha-s',0,x_tst);
% [W_MS_bak_n,  R_MS_bak_n]  = featselb(x_trn_n,'maha-s',0);
% % [W_MS_bak_nt, R_MS_bak_nt] = featselb(x_trn_n,'maha-s',0,x_tst_n);
% 
% [W_MS_lr,    R_MS_lr]    = featsellr(x_trn,'maha-s',0,2,1);
% % [W_MS_lr_t,  R_MS_lr_t]  = featsellr(x_trn,'maha-s',0,1,0,x_tst);
% [W_MS_lr_n,  R_MS_lr_n]  = featsellr(x_trn_n,'maha-s',0,2,1);
% % [W_MS_lr_nt, R_MS_lr_nt] = featsellr(x_trn_n,'maha-s',0,1,0,x_tst_n);
% 
% figure
% hold on 
% plot(R_MS_for(:,1),R_MS_for(:,2))
% % plot(R_MS_for_t(:,1),R_MS_for_t(:,2))
% plot(R_MS_for_n(:,1),R_MS_for_n(:,2))
% % plot(R_MS_for_nt(:,1),R_MS_for_nt(:,2))
% legend('Original','Norm')
% title('Feature selection "Forward" "Maha-s"')
% 
% figure
% hold on 
% plot(R_MS_bak(:,1),R_MS_bak(:,2))
% % plot(R_MS_bak_t(:,1),R_MS_bak_t(:,2))
% plot(R_MS_bak_n(:,1),R_MS_bak_n(:,2))
% % plot(R_MS_bak_nt(:,1),R_MS_bak_nt(:,2))
% legend('Original','Norm')
% title('Feature selection "Backward" "Maha-s"')
% 
% figure
% hold on 
% plot(R_MS_lr(:,1),R_MS_lr(:,2))
% % plot(R_MS_lr_t(:,1),R_MS_lr_t(:,2))
% plot(R_MS_lr_n(:,1),R_MS_lr_n(:,2))
% % plot(R_MS_lr_nt(:,1),R_MS_lr_nt(:,2))
% legend('Original','Norm')
% title('Feature selection "Left Right" "Maha-s"')
