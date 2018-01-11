

x = 0;
y = 0;
z = 0;
e = 1;

dim = 16;

for i =1:dim

    for j = 1:dim
        
        xyz(e,1) = x;
        xyz(e,2) = y;
        xyz(e,3) = z;
        int(e) = im3(i,j);
        
        y = y + 1;
        e = e + 1;
    end
    
    x = x + 1;
    y = 0;
    
end

im3cloud = pointCloud(xyz, 'Intensity', int);