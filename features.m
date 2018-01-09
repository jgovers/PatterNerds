%% Init
clear all
close all
clc
tic
prwaitbar off
load('all_processed_images')
load('optimf_ldc','optimf_ldc')



for j = 1:40

    samp(:,j) = randsample(1000,20);
    samptrn = samp(1:10,j)';
    samptst = samp(11:20,j)';

    for i = 1:10
        samptrni(1+(i-1)*10:10+(i-1)*10) = samptrn + (i-1)*1000;
        samptsti(1+(i-1)*10:10+(i-1)*10) = samptst + (i-1)*1000;
    end

    a_trn = a([samptrni],:);
    a_tst = a([samptsti],:);

    x_trn   = im_features(a_trn,a_trn,{'Area','Centroid','ConvexArea','Eccentricity','EquivDiameter','EulerNumber','Extent','FilledArea','MajorAxisLength','MinorAxisLength','Orientation','Perimeter','Solidity'});
    x_tst   = im_features(a_tst,a_tst,{'Area','Centroid','ConvexArea','Eccentricity','EquivDiameter','EulerNumber','Extent','FilledArea','MajorAxisLength','MinorAxisLength','Orientation','Perimeter','Solidity'});

        for k = 7:11
            x_trnk = x_trn(:,optimf_ldc(k,1:k));
            x_tstk = x_tst(:,optimf_ldc(k,1:k));

            W{k,j} = ldc(x_trnk);
            E(k,j) = testc(x_tstk,W{k,j});
        end
end

m7 = mean(E(7,:))
m8 = mean(E(8,:))
m9 = mean(E(9,:))
m10 = mean(E(10,:))
m11 = mean(E(11,:))

figure;
hold on;
plot(E(7,:));plot(E(8,:));plot(E(9,:));plot(E(10,:));plot(E(11,:));
legend('7','8','9','10','11')
toc