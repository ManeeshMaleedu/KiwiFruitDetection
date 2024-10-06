function centroid = boundingBoxToCentroid(bbox)
    % bbox is a vector in the form [x, y, width, height]
    % Calculate the centroid
    x = bbox(1);        % X-coordinate of the top-left corner
    y = bbox(2);        % Y-coordinate of the top-left corner
    width = bbox(3);    % Width of the bounding box
    height = bbox(4);   % Height of the bounding box

    % Centroid calculation
    centroidX = x + width / 2;
    centroidY = y + height / 2;

    % Return centroid as [centroidX, centroidY]
    centroid = [centroidX, centroidY];
end
