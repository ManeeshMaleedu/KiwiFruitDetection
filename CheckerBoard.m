function CreateCheckerboard()
    % Define the number of squares along each dimension
    % (n, m) where n and m are the number of internal corners, not squares
    n = 8; % number of horizontal corners
    m = 5; % number of vertical corners
    
    % Square size in pixels
    squareSize = 50; % Change this based on how large you want the squares to be
    
    % Generate checkerboard
    checkerboardImage = checkerboard(squareSize, m, n) > 0.5;
    
    % Show the image
    figure;
    imshow(checkerboardImage);
    title('Checkerboard for Camera Calibration');
    
    % Save the image to disk
    imwrite(checkerboardImage, 'checkerboard.png');
    disp('Checkerboard image saved as checkerboard.png');
end
