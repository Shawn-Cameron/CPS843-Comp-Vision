clear;
close all;

% Read in images
Img1 = imread('img3.JPEG');
Img2 = imread('img4.JPEG');

%figure, imshowpair(Img1, Img2, 'montage'), title('Original Images');

% Load Camera Parameters
load('calibrationSession.mat')
intrinsics = calibrationSession.CameraParameters.Intrinsics;

% Remove lens distortion
Img1 = undistortImage(Img1, intrinsics);
Img2 = undistortImage(Img2, intrinsics);
%figure, imshowpair(Img1, Img2, 'montage'), title('Undistorted Images');

%%Finding Point Correspondances%%

imgPoint1 = detectMinEigenFeatures(im2gray(Img1), MinQuality = 0.01); % Detect feature points
imgPoint2 = detectMinEigenFeatures(im2gray(Img2), MinQuality = 0.01);

% Visualize detected points
figure, imshow(Img1), title('500 Strongest Corners from the First Image');
hold on
plot(selectStrongest(imgPoint1, 500));

% Create the point tracker
tracker = vision.PointTracker(MaxBidirectionalError=2, NumPyramidLevels=6);

% Initialize the point tracker
imgPoint1 = imgPoint1.Location;
initialize(tracker, imgPoint1, Img1);

% Track the points
[imgPoint2, validIdx] = step(tracker, Img2);
matchedPoints1 = imgPoint1(validIdx, :);
matchedPoints2 = imgPoint2(validIdx, :);

% Visualize correspondences
figure
showMatchedFeatures(Img1, Img2, matchedPoints1, matchedPoints2);
title('Tracked Features');


% Estimate the fundamental matrix
[E, epipolarInliers] = estimateEssentialMatrix(...
    matchedPoints1, matchedPoints2, intrinsics, Confidence = 49.99);

% Find epipolar inliers
inlierPoints1 = matchedPoints1(epipolarInliers, :);
inlierPoints2 = matchedPoints2(epipolarInliers, :);

% Display inlier matches
figure
showMatchedFeatures(Img1, Img2, inlierPoints1, inlierPoints2);
title('Epipolar Inliers');

%Compute camera pose
relPose = estrelpose(E, intrinsics, inlierPoints1, inlierPoints2);

%%Reconstruct the 3D Locations of Matched points%%
% Detect dense feature points. Use an ROI to exclude points close to the
% image edges.
border = 30;
roi = [border, border, size(Img1, 2)- 2*border, size(Img1, 1)- 2*border];
imgPoint1 = detectMinEigenFeatures(im2gray(Img1), ROI = roi, ...
    MinQuality = 0.001);

% Compute the camera matrices for each position of the camera
camMatrix1 = cameraProjection(intrinsics, rigidtform3d); 
camMatrix2 = cameraProjection(intrinsics, pose2extr(relPose));

% Compute the 3-D points
points3D = triangulate(matchedPoints1, matchedPoints2, camMatrix1, camMatrix2);

% Get the color of each reconstructed point
numPixels = size(Img1, 1) * size(Img1, 2);
allColors = reshape(Img1, [numPixels, 3]);
colorIdx = sub2ind([size(Img1, 1), size(Img1, 2)], round(matchedPoints1(:,2)), ...
    round(matchedPoints1(:, 1)));
color = allColors(colorIdx, :);

% Create the point cloud
ptCloud = pointCloud(points3D, 'Color', color);


% Visualize the camera locations and orientations
cameraSize = 0.2;
figure
plotCamera(Size=cameraSize, Color='r', Label='1', Opacity=0);
hold on
grid on
plotCamera(AbsolutePose=relPose, Size=cameraSize, ...
    Color='b', Label='2', Opacity=0);

% Visualize the point cloud
pcshow(ptCloud, VerticalAxis='y', VerticalAxisDir='down', MarkerSize=45);

% Rotate and zoom the plot
camorbit(0, -30);
camzoom(1.5);

% Label the axes
xlabel('x-axis'), ylabel('y-axis'), zlabel('z-axis');

title('Up to Scale Reconstruction of the Scene');

% Determine the scale factor
scaleFactor = 5;

% Scale the point cloud
ptCloud = pointCloud(points3D * scaleFactor, Color=color);
relPose.Translation = relPose.Translation * scaleFactor;

% Visualize the point cloud in centimeters
cameraSize = 0.5; 
figure
plotCamera(Size=cameraSize, Color='r', Label='1', Opacity=0);
hold on
grid on
plotCamera(AbsolutePose=relPose, Size=cameraSize, ...
    Color='b', Label='2', Opacity=0);

% Visualize the point cloud
pcshow(ptCloud, VerticalAxis='y', VerticalAxisDir='down', MarkerSize=45);
camorbit(0, -30);
camzoom(1.5);

% Label the axes
xlabel('x-axis (cm)'), ylabel('y-axis (cm)'), zlabel('z-axis (cm)')
title('Metric Reconstruction of the Scene');
