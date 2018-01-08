%% Init
clear all
close all
clc
tic
disp('Running module FEATURES')
load('all_processed_images')
doplots = true;

prwaitbar off

a_trn = a([1:10 1001:1010 2001:2010 3001:3010 4001:4010 5001:5010 6001:6010 ...
    7001:7010 8001:8010 9001:9010],:);
a_tst = a([991:1000 1991:2000 2991:3000 3991:4000 4991:5000 5991:6000 6991:7000 ...
    7991:8000 8991:9000 9991:10000],:);

%% Feature Extraction
disp('Extracting training features...')
x_trn   = im_features(a_trn,a_trn,{'Area','Centroid','ConvexArea','Eccentricity','EquivDiameter','EulerNumber','Extent','FilledArea','MajorAxisLength','MinorAxisLength','Orientation','Perimeter','Solidity'});

toc
disp('Extracting testing features...')
x_tst   = im_features(a_tst,a_tst,{'Area','Centroid','ConvexArea','Eccentricity','EquivDiameter','EulerNumber','Extent','FilledArea','MajorAxisLength','MinorAxisLength','Orientation','Perimeter','Solidity'});

%% Normalization

W_cvar = scalem(x_trn,'c-variance');
W_var = scalem(x_trn,'variance');
W_2sig = scalem(x_trn,'2-sigma');
W_dom = scalem(x_trn,'domain');

test_cvar   = +x_trn*W_cvar;
test_var    = +x_trn*W_var;
test_2sig   = x_trn*W_2sig;
test_2sig   = +test_2sig;
test_dom    = +x_trn*W_dom;


%% Feature evaluation
[W_NN_for,    R_NN_for]    = featself(x_trn,'NN',0);
[W_NN_for_t,  R_NN_for_t]  = featself(x_trn,'NN',0,x_tst);
[W_NN_for_n,  R_NN_for_n]  = featself(x_trn*W_dom,'NN',0);
[W_NN_for_nt, R_NN_for_nt] = featself(x_trn*W_dom,'NN',0,x_tst*W_dom);

figure
hold on 
plot(R_NN_for(:,1),R_NN_for(:,2))
plot(R_NN_for_t(:,1),R_NN_for_t(:,2))
plot(R_NN_for_n(:,1),R_NN_for_n(:,2))
plot(R_NN_for_nt(:,1),R_NN_for_nt(:,2))
legend('Original','Original w Test','Norm','Norm w Test')
title('Feature selection "Forward" "NN"')

showfigs

%% Classification

E = clevalf(x_trn,fisherc,[3:10],[],1,x_tst,[])

% % Training
% toc
% W_nmc = nmc(x_trn);
% W_nmc_n = nmc(x_trn_n);
% [W_ldc,R_ldc,S_ldc,M_ldc] = ldc(x_trn);
% [W_ldc_n,R_ldc_n,S_ldc_n,M_ldc_n] = ldc(x_trn_n);
% W_fis = fisherc(x_trn);
% W_fis_n = fisherc(x_trn_n);
% W_log = loglc(x_trn);
% W_log_n = loglc(x_trn_n);
% [W_par,H_par] = parzenc(x_trn_n);
% [W_par_n,H_par_n] = parzenc(x_trn_n);
% 
% % Testing
% toc
% [E_nmc,C_nmc] = testc(x_tst,W_nmc);
% [E_nmc_n,C_nmc_n] = testc(x_tst_n,W_nmc_n);
% [E_ldc,C_ldc] = testc(x_tst,W_ldc);
% [E_ldc_n,C_ldc_n] = testc(x_tst_n,W_ldc_n);
% [E_fis,C_fis] = testc(x_tst,W_fis);
% [E_fis_n,C_fis_n] = testc(x_tst_n,W_fis_n);
% [E_log,C_log] = testc(x_tst,W_log);
% [E_log_n,C_log_n] = testc(x_tst_n,W_log_n);
% [E_par,C_par] = testc(x_tst,W_par);
% [E_par_n,C_par_n] = testc(x_tst_n,W_par_n);


%% Plot
if doplots
%     if size(a_trn,1) < 500
%         figure; show(a_trn); title('Training Samples');
%         figure; show(a_tst); title('Test Samples');
%     end
    figure;
    hold on;
    plot(test_cvar(:,6))
    plot(test_var(:,6))
    plot(test_2sig(:,6))
    plot(test_dom(:,6))
    legend('cvar','var','2sig','dom')
    
%    figure; bar([E_nmc,E_nmc_n,E_ldc,E_ldc_n,E_fis,E_fis_n,E_log,E_log_n,E_par,E_par_n]);
%    figure; bar([C_nmc;C_nmc_n;C_ldc;C_ldc_n;C_fis;C_fis_n;C_log;C_log_n;C_par;C_par_n]');
   showfigs
end

toc
disp('Done')


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

% [W_NN_bak,    R_NN_bak]    = featselb(x_trn,'NN',0);
% [W_NN_bak_t,  R_NN_bak_t]  = featselb(x_trn,'NN',0,x_tst);
% [W_NN_bak_n,  R_NN_bak_n]  = featselb(x_trn_n,'NN',0);
% [W_NN_bak_nt, R_NN_bak_nt] = featselb(x_trn_n,'NN',0,x_tst_n);
% 
% [W_NN_lr,    R_NN_lr]    = featsellr(x_trn,'NN',0,2,1);
% [W_NN_lr_t,  R_NN_lr_t]  = featsellr(x_trn,'NN',0,2,1,x_tst);
% [W_NN_lr_n,  R_NN_lr_n]  = featsellr(x_trn_n,'NN',0,2,1);
% [W_NN_lr_nt, R_NN_lr_nt] = featsellr(x_trn_n,'NN',0,2,1,x_tst_n);
% 
% W_sizes = [size(W_NN_for,2),size(W_NN_for_t,2),size(W_NN_for_n,2),size(W_NN_for_nt,2),...
%     size(W_NN_bak,2),size(W_NN_bak_t,2),size(W_NN_bak_n,2),size(W_NN_bak_nt,2),...
%     size(W_NN_lr,2),size(W_NN_lr_t,2),size(W_NN_lr_n,2),size(W_NN_lr_nt,2)];
% W_mean = round(mean(W_sizes))
% 
% W_int_for = intersect(intersect(intersect(+W_NN_for,+W_NN_for_t),+W_NN_for_n),+W_NN_for_nt)
% W_int_bak = intersect(intersect(intersect(+W_NN_bak,+W_NN_bak_t),+W_NN_bak_n),+W_NN_bak_nt)
% W_int_lr  = intersect(intersect(intersect(+W_NN_lr,+W_NN_lr_t),+W_NN_lr_n),+W_NN_lr_nt)
% 
% W_int_o  = intersect(intersect(+W_NN_for,+W_NN_bak),+W_NN_lr)
% W_int_t  = intersect(intersect(+W_NN_for_t,+W_NN_bak_t),+W_NN_lr_t)
% W_int_n  = intersect(intersect(+W_NN_for_n,+W_NN_bak_n),+W_NN_lr_n)
% W_int_nt = intersect(intersect(+W_NN_for_nt,+W_NN_bak_nt),+W_NN_lr_nt)


% figure
% hold on 
% plot(R_NN_bak(:,1),R_NN_bak(:,2))
% plot(R_NN_bak_t(:,1),R_NN_bak_t(:,2))
% plot(R_NN_bak_n(:,1),R_NN_bak_n(:,2))
% plot(R_NN_bak_nt(:,1),R_NN_bak_nt(:,2))
% legend('Original','Original w Test','Norm','Norm w Test')
% title('Feature selection "Backward" "NN"')
% 
% figure
% hold on 
% plot(R_NN_lr(:,1),R_NN_lr(:,2))
% plot(R_NN_lr_t(:,1),R_NN_lr_t(:,2))
% plot(R_NN_lr_n(:,1),R_NN_lr_n(:,2))
% plot(R_NN_lr_nt(:,1),R_NN_lr_nt(:,2))
% legend('Original','Original w Test','Norm','Norm w Test')
% title('Feature selection "Left Right" "NN"')

