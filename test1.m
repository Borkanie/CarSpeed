

BW3=imread('img2.png');
BW3=im2uint8(BW3);
BW3(find(BW3>=7))=255;

info = regionprops(BW3,'Boundingbox') ;
imshow(BW3)
hold on
for k = 1 : length(info)
     BB = info(k).BoundingBox;
     rectangle('Position', [BB(1),BB(2),BB(3),BB(4)],'EdgeColor','r','LineWidth',2) ;
end
figure()
imshow(BW3);


