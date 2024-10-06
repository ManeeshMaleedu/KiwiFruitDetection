% Load the saved camera parameters
load('cameraParams.mat');

% Display the reprojection errors
disp(cameraParams.ReprojectionErrors);

% Visualize the calibration accuracy
figure;
showReprojectionErrors(cameraParams);
title('Reprojection Errors');

% Optionally, you can check how well the calibration worked by undistorting one of the images
sampleImage = imread(fullfile('Calibration_Images', 'calibration_1.jpg'));
undistortedImage = undistortImage(sampleImage, cameraParams);

figure;
subplot(1,2,1);
imshow(sampleImage);
title('Original Image');

subplot(1,2,2);
imshow(undistortedImage);
title('Undistorted Image');
