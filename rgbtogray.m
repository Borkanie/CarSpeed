rgb=imread('rgb.bmp');
rgb1=rgb2gray(rgb);
imshow(rgb1)
histograma=imhist(rgb1);
figure(1),bar([0:255], histograma)
xlabel('niveluri gri'), ylabel('numar aparitii niveluri gri')
% images(:,:,i+2) = insertShape(gray_frame,'line',[320 900 580 850]*0.5,'Color','green','LineWidth',5);