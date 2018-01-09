%% Init
clear all
close all
clc
tic
addpath(genpath(pwd))
load('all_processed_images')
% myPool = parpool();

prwaitbar off
prwarning off

% minmat = zeros(2,2);
minE = zeros(30,14);
IminE = zeros(30,14);
optimf_ldc = zeros(30,14,14);
Errormat1 = zeros(30,3432,14);

for k = 1:30
    toc
    samp(:,k) = randsample(1000,20);
    samptrn = samp(1:10,k)';
    samptst = samp(11:20,k)';

    for i = 1:10
        samptrni(1+(i-1)*10:10+(i-1)*10) = samptrn + (i-1)*1000;
        samptsti(1+(i-1)*10:10+(i-1)*10) = samptst + (i-1)*1000;
    end

    a_trn = a([samptrni],:);
    a_tst = a([samptsti],:);

    %% Feature Extraction
    x_trn   = im_features(a_trn,a_trn,{'Area','Centroid','ConvexArea','Eccentricity','EquivDiameter','EulerNumber','Extent','FilledArea','MajorAxisLength','MinorAxisLength','Orientation','Perimeter','Solidity'});
    x_tst   = im_features(a_tst,a_tst,{'Area','Centroid','ConvexArea','Eccentricity','EquivDiameter','EulerNumber','Extent','FilledArea','MajorAxisLength','MinorAxisLength','Orientation','Perimeter','Solidity'});

    %% Normalization
    % W_dom = scalem(x_trn,'domain');
    % x_trn = x_trn*W_dom;
    % x_tst = x_tst*W_dom;

    %%

    for i = 6:14

        opts{k,i} = nchoosek([1:14],i);

        parfor j = 1:size(opts{k,i},1)
            W_ldc{k,i,j} = ldc(x_trn(:,opts{k,i}(j,:)));
            Errormat_ldc(k,j,i) = testc(x_tst(:,opts{k,i}(j,:)),W_ldc{k,i,j});
        end

    end

    Errormat1(:,:) = Errormat_ldc(k,:,:);
    Errormat1(Errormat1 == 0) = NaN;
    [minE(k,:),IminE(k,:)] = min(Errormat1);

    for i = 6:14
        optimf_ldc(k,i,1:i) = opts{k,i}(IminE(k,i),:);
    end
end

save('workspace_ldc_longrun')
toc
disp('Done...')