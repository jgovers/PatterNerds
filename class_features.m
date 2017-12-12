%% !!!!! remove clearing if converted to function !!!!!!
tic

%% Image Processing
x1 = im_features(num_box,num_box,{'Area','Centroid','ConvexArea','Eccentricity','EquivDiameter','EulerNumber','Extent','FilledArea','MajorAxisLength','MinorAxisLength','Orientation','Perimeter','Solidity'});
toc

%% Plot
if doplots
   figure; show(num_box);
   figure; scatterd(x1,3,'legend')
   showfigs
end
toc