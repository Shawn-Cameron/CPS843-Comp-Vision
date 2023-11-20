close all;
% Loads the file
load("object3d.mat");

%displays the point cloud file contents
figure
pcshow(ptCloud)
title("Detect a sphere in a point cloud")

% sets the maximum distance of fitting
maxDistance = 0.01;

% Defines the region of interest.
roi = [-inf,0.5;0.2,0.4;0.1,inf];
indices = findPointsInROI(ptCloud,roi);

% Detects the globe in the point cloud and extacts it
[model,inlierIndices] = pcfitsphere(ptCloud,maxDistance,SampleIndices=indices);
globe = select(ptCloud,inlierIndices);

% Plots/Shows the results
figure
pcshow(globe)
title("Globe Point Cloud")