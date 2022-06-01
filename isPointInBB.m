function [isInRectangle] = isPointInBB(point,boundingBox)
isInRectangle=false;
if point(1)>boundingBox(1) && point(1)<boundingBox(1)+boundingBox(3) && point(2)>boundingBox(2) && point(2)<boundingBox(2)+boundingBox(4)
    isInRectangle=true;
end
end