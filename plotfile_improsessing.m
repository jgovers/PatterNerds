%% this m-file is used to plot a few selections of the NIST-set during the image processing fase.
% Make sure to run NIST_start.m before running this file!

dig = [5 13 17 69];
figure; show(a_trn(dig,:));
title('4. Digits after processing')
figure; show(b(dig,:))
title('1. Digits after Resizing')
figure; show(c(dig,:))
title('2. Digits after Downsampling')
figure; show(d(dig,:))
title('3. Digits after Blob-removal')