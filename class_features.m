%% !!!!! remove clearing if converted to function !!!!!!
tic

%% Image Processing
x1 = im_features(num_box,num_box,{'Area','Centroid'});
x2 = im_features(num_box,num_box,{'Perimeter','Eccentricity','EulerNumber'});
toc

%% Plot
if doplots
   figure; show(num_box);
   figure; scatterd(x1,3,'legend')
   figure; scatterd(x2,3,'legend')
   showfigs
end
toc