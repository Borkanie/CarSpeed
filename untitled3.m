clc
clear all
close all

P1=[450;875];
P2=[395;885];
P3=[505;865];

% implay('trimm.mp4');
obj=VideoReader('krb1.mp4');
nFrames=obj.NumberOfFrames;
vidHeight=obj.Height;
vidWidth=obj.Width;


mov(1:nFrames)=struct('cdata',zeros(vidHeight,vidWidth,1,'uint8'),'colormap',[]);
for k=1:nFrames
    frame = read(obj,k);
%     gray_frame = 0.3*frame(:,:,1) + 0.6*frame(:,:,2) + 0.1*frame(:,:,3);
gray_frame=rgb2gray(frame);
gray_frame=imresize(gray_frame,0.5);
    images(:,:,k)=gray_frame;

end

%% diferenta intre frameuri
[lini, coloane, Nr_poze] = size (images)
for i=1:Nr_poze-5
  differenceImage =(abs(im2double(images(:,:,i))) - im2double(images(:,:,i+5)));
%     imshow(differenceImage, []);
    level=graythresh(differenceImage);
    BW1 = im2bw(differenceImage,level);
  
    SE = strel('disk',[2]);
    BW2 = imerode(BW1,SE);
%     figure();
%     imshow(BW2)
    title('IMAGINE DUPA ERODARE');
    BW3 = imdilate(BW2,strel('disk',[17]));
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
Line_Insert_frame = insertShape(frame,'line',[310 192 640 192],'LineWidth',2);
figure(5)
imshow(images(:,:,i+2))
hold on
% images(:,:,i+2)
N=940;
for k = 1 : size(info,1)
     BB = info(k).BoundingBox;
     area=info(k).Area
     BB(2);

    if(BB(2)>50)
             if (area>N)
                if (BB(1)<=P1.X<=BB(1)+BB(3)) && (BB(2)<=P1.Y<=BB(2)+BB(4))
                elseif (BB(1)<=P2.X<=BB(1)+BB(3)) && (BB(2)<=P2.Y<=BB(2)+BB(4))
                elseif (BB(1)<=P3.X<=BB(1)+BB(3)) && (BB(2)<=P3.Y<=BB(2)+BB(4))
                end
             
                
                  

       
     rectangle('Position', [BB(1),BB(2),BB(3),BB(4)],'EdgeColor','r','LineWidth',2) ;
     
             end
hold off
end
end

%     st=imread(['Img',num2str(k),'.JPG']) 
%     st=regionprops(BW3,'BoundingBox')
% thisBB = st(k).BoundingBox; rectangle('Position', [thisBB(1),thisBB(2),thisBB(3),thisBB(4)],'EdgeColor','r','LineWidth',2)
end