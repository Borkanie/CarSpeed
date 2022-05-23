clc
clear all
close all

implay('film_circulatie2.mp4');
obj=VideoReader('film_circulatie2.mp4');
nFrames=obj.NumberOfFrames;
vidHeight=obj.Height;
vidWidth=obj.Width;

mov(1:nFrames)=struct('cdata',zeros(vidHeight,vidWidth,1,'uint8'),'colormap',[]);
for k=1:nFrames
    frame = read(obj,k);
    gray_frame = 0.3*frame(:,:,1) + 0.6*frame(:,:,2) + 0.1*frame(:,:,3);
    images(:,:,k)=gray_frame;

end

%% diferenta intre frameuri
[lini, coloane, Nr_poze] = size (images)
for i=1:Nr_poze-5
  differenceImage =(abs(im2double(images(:,:,i))) - im2double(images(:,:,i+5)));
    imshow(differenceImage, []);
    level=graythresh(differenceImage);
    BW1 = im2bw(differenceImage,level);
  
    SE = strel('disk',[3]);
    BW2 = imerode(BW1,SE);
%     figure();
%     imshow(BW2)
    title('IMAGINE DUPA ERODARE');
    BW3 = imdilate(BW2,SE);
%     BW3=im2uint8(BW3);
%     BW3(find(BW3>=7))=255;
%     figure(1);
%     imshow(BW3);
%     title('IMAGINE DUPA ERODARE+DILATARE');
%     Nume = ['Img',num2str(i),'.png']
%     imwrite(BW3, Nume);
%     st(i)=regionprops(BW3,'BoundingBox');
%     thisBB = st(i).BoundingBox; rectangle('Position', [thisBB(1),thisBB(2),thisBB(3),thisBB(4)],'EdgeColor','r','LineWidth',2)
info = regionprops(BW3,'Boundingbox','Area') ;
imshow(BW3)
hold on
N=180;
for k = 1 : size(info,1)
     BB = info(k).BoundingBox;
     area = info(k) .Area;
     if(area>N)
         hold on
     rectangle('Position', [BB(1),BB(2),BB(3),BB(4)],'EdgeColor','r','LineWidth',2) ;
     end
end
figure(5)
imshow(BW3);
end

%     st=imread(['Img',num2str(k),'.JPG']) 
%     st=regionprops(BW3,'BoundingBox')
% thisBB = st(k).BoundingBox; rectangle('Position', [thisBB(1),thisBB(2),thisBB(3),thisBB(4)],'EdgeColor','r','LineWidth',2)


% for k = 1:i
% st=imread(['Img',num2str(k),'.jpg']) 
% level=graythresh(st)
% bw = im2bw(st,level);
% st=regionprops(bw,'BoundingBox')
% thisBB = st(k).BoundingBox; rectangle('Position', [thisBB(1),thisBB(2),thisBB(3),thisBB(4)],'EdgeColor','r','LineWidth',2) 
% 
% end

