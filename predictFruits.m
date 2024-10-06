clc;
clear all;
close all;

load('detector.mat')

%% Run the detector on a test image.
I = imread(uigetfile('*.*'));
[bboxes,scores,labels] = detect(detector,I);

% Display the results.
I = insertObjectAnnotation(I,"rectangle",bboxes,scores);
figure
imshow(I)
