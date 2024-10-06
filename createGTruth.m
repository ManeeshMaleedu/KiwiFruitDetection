% Clear command window, workspace, and close all figures
clc;
clear;
close all;

% Create an imageDatastore to read images from the 'train' folder
imageData = imageDatastore('train');

% Initialize ground truth cell array to store bounding boxes
groundTruth = {};

% Loop through each image in the datastore
for imageIdx = 1:length(imageData.Files)
    % Get the current image file name
    currentImageFile = imageData.Files{imageIdx};

    % Read the current image
    currentImage = imread(currentImageFile);

    % Replace '.jpg' with '.txt' to load the corresponding annotation file
    annotationFile = fopen(strrep(currentImageFile, '.jpg', '.txt'), 'r');

    % Read annotation data (YOLO format: class, x_center, y_center, width, height)
    annotationData = textscan(annotationFile, '%f %f %f %f %f');
    fclose(annotationFile);

    % Get the dimensions of the image (height and width)
    [imageHeight, imageWidth, ~] = size(currentImage);

    % Extract annotation values from the file
    classLabels = annotationData{1};  % Class labels (e.g., assuming kiwi)
    xCenterNorm = annotationData{2}; % Normalized x-center coordinates
    yCenterNorm = annotationData{3}; % Normalized y-center coordinates
    bboxWidthNorm = annotationData{4}; % Normalized bounding box width
    bboxHeightNorm = annotationData{5}; % Normalized bounding box height

    % Convert normalized coordinates to pixel values
    xCenter = xCenterNorm * imageWidth;
    yCenter = yCenterNorm * imageHeight;
    bboxWidth = bboxWidthNorm * imageWidth;
    bboxHeight = bboxHeightNorm * imageHeight;

    % Calculate the top-left corner (x_min, y_min) for the bounding boxes
    xMin = xCenter - bboxWidth / 2;
    yMin = yCenter - bboxHeight / 2;

    % Display the image and draw bounding boxes
    figure;
    imshow(currentImage);
    hold on;

    boxes = [];
    % Loop through all bounding boxes and draw them on the image
    for bboxIdx = 1:length(classLabels)
        % Draw rectangle at [x_min, y_min, width, height]
        rectangle('Position', [xMin(bboxIdx), yMin(bboxIdx), bboxWidth(bboxIdx), bboxHeight(bboxIdx)], ...
            'EdgeColor', 'r', 'LineWidth', 2);

        % Check if any bounding box coordinate or size is zero, and replace it with 1
        if xMin(bboxIdx) <= 0
            xMin(bboxIdx) = 1;
        end
        if yMin(bboxIdx) <= 0
            yMin(bboxIdx) = 1;
        end
        if bboxWidth(bboxIdx) <= 0
            bboxWidth(bboxIdx) = 1;
        end
        if bboxHeight(bboxIdx) <= 0
            bboxHeight(bboxIdx) = 1;
        end

        boxes = [ boxes; [xMin(bboxIdx), yMin(bboxIdx), bboxWidth(bboxIdx), bboxHeight(bboxIdx)]];
    end

    hold off;
    title('Annotated Kiwi with Bounding Boxes');

    % Store the bounding box information in the groundTruth cell array
    groundTruth = [groundTruth; currentImageFile, {boxes}];

    % Pause to visualize the annotations and close the figure
    % pause(1);
    close all;
end

save groundTruth groundTruth
