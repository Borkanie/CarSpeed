rgbImage = imread('rgb.bmp');
subplot(2, 1, 1);
imshow(rgbImage); % Show original image
[indexedImage, map] = rgb2ind(rgbImage, 8);
subplot(2, 1, 2);
imshow(indexedImage, map); % Show posterized version
colorbar;