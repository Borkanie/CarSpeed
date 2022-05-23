% //Read in the image from StackOverflow
x=imread('http://i.stack.imgur.com/mRWId.png');

% //Threshold and remove last 10 rows
y=im2bw(x);
y = y(1:end-10,:);

% //Calculate all bounding boxes
s=regionprops(y, 'BoundingBox');

%// Obtain all of the bounding box co-ordinates
bboxCoords = reshape([s.BoundingBox], 4, []).';

% // Calculate top left corner
topLeftCoords = bboxCoords(:,1:2);

% // Calculate top right corner
topRightCoords = [topLeftCoords(:,1) + bboxCoords(:,3) topLeftCoords(:,2)];

% // Calculate bottom left corner
bottomLeftCoords = [topLeftCoords(:,1) topLeftCoords(:,2) + bboxCoords(:,4)];

% // Calculate bottom right corner
bottomRightCoords = [topLeftCoords(:,1) + bboxCoords(:,3) ...
    topLeftCoords(:,2) + bboxCoords(:,4)];

% // Calculating the minimum and maximum X and Y values
finalCoords = [topLeftCoords; topRightCoords; bottomLeftCoords; bottomRightCoords];
minX = min(finalCoords(:,1));
maxX = max(finalCoords(:,1));
minY = min(finalCoords(:,2));
maxY = max(finalCoords(:,2));

% Draw the rectangle on the screen
width = (maxX - minX + 1);
height = (maxY - minY + 1);
rect = [minX minY width height];

% // Show the image
imshow(y);
hold on;
rectangle('Position', rect, 'EdgeColor', 'yellow');