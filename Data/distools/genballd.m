%GENBALLD Generate ball distance matrix
%
%   D = GENBALLD(N,K,E)
%
%  N 1xC vector with number of objects per class
%  K Dimensionality
%  E 1xC with ball sizes, default: class number/100
%
% This routine generates C classes of balls in a K-dimensional hypercube 
% with edges of length 1. The radii for class n is given in E(n). Balls do
% not intersect. The distances between the ball surfaces are returned in D.

function d = genballd(n,k,e)

c = length(n); % number of classes
if nargin < 2, k = 1; end
if nargin < 3, e = [1:c]/100; end
m = sum(n); 

x = 100*rand(m,k); % to avoid numerical inaccurcies
r = [];
for j=1:c
    r = [r; e(j).*ones(n(j),1)];
end
%r = r*100;

d = sqrt(distm(x)) - repmat(r,1,m) - repmat(r',m,1); 
d = d - diag(diag(d));
attempts = 0;
while(any(d(:)<0))
for j=2:m
    while any(d(j,:) < 0)
				attempts = attempts + 1;
				if attempts > 50*m
					error('No solution found, shrink ball sizes or number of balls, or enlarge dimensionality')
				end
        x(j,:) = 100*rand(1,k);
        d(j,:) = sqrt(distm(x(j,:),x)) - repmat(r(j),1,m) - repmat(r',1,1);
        d(:,j) = d(j,:)';
        d(j,j) = 0;
    end
end

end         

labs = genlab(n);
d = prdataset(d,labs);
d = setfeatlab(d,labs);
d = setprior(d,0);
desc = ['This dataset has been generated by the DisTools command GENBALLD(['...
    num2str(classsizes(d)) '], ' int2str(k) ', [' num2str(e) ']) which generates the' ...
    ' given numbers of ' int2str(k) '-D balls with sizes [' num2str(e) '] in a' ...
      int2str(k) '-D hypercube. Balls do not overlap. Dissimilarities are computed as the' ...
    ' shortest distance between two points on the surface of two balls.' ...
    ' The intention is to study strong examples in which non-Euclidean dissimilarities are informative.'];
ref = {['E. Pekalska, A. Harol, R.P.W. Duin, D. Spillman, and H. Bunke, Non-Euclidean'...
     ' or non-metric measures can be informative, in: D.-Y. Yeung et al., Proc. SSSPR2006'... 
     ' Lecture Notes in Comp. Sc., vol. 4109, Springer, Berlin, 2006, 871-880.'], ...
      ['R.P.W. Duin, E. Pekalska, A. Harol, W.J. Lee, and H. Bunke, On Euclidean'...
     ' corrections for non-Euclidean dissimilarities, in: N. da Vitoria Lobo et al.,'...
     ' Proc. SSSPR2008, Lecture Notes in Comp.Sc., vol. 5342, Springer, Berlin, 2008, 551-561.'], ...
     ['J. Laub, V. Roth, J.M. Buhmann, K.R. Mueller, On the information'...
     ' and representation of non-euclidean pairwise data, Pattern Recognition, vol. 39, 2006, 1815-1826.']};
link = {'The PRTools version of the data:','http://prtools.org/files/CoilYork.zip'; ...
    'The DisTools package which contains the routine','http://prtools.org/files/DisTools.zip'};
d = setname(d,'Ball Dissimilarities');
d = setuser(d,desc,'desc');
d = setuser(d,ref,'ref');
d = setuser(d,link,'link');