clc
clear all
close all

 implay('trafic_Trim.mp4');
 obj=VideoReader('trafic_Trim.mp4');
 nFrames=obj.NumberOfFrames;
 vidHeight=obj.Height;
 vidWidth=obj.Width;
 mov(1:nFrames)=struct('cdata',zeros(vidHeight,vidWidth,1,'uint8'),'colormap',[]);
 for k=1:nFrames
     frame = read(obj,k);
      gray_frame = 0.3*frame(:,:,1) + 0.6*frame(:,:,2) + 0.1*frame(:,:,3);
images(:,:,k)=gray_frame;
%      mov(k).cdata = 0.3*image(:,:,1) + 0.6*image(:,:,2) + 0.1*image(:,:,3);
 end
%  implay(mov)

%  %binarizare
%   v = VideoReader('trafic_Trim.mp4');
%   i = 0
%   while hasFrame(v)
%       frame = readFrame(v);
%       gray_frame = 0.3*frame(:,:,1) + 0.6*frame(:,:,2) + 0.1*frame(:,:,3);
% images(:,:,i+1)=gray_frame;
%   end

%       binary_frame = imbinarize(gray_frame)
%       file = sprintf('a_frame%d.png',i);
%       imwrite(binary_frame,file);
%       i = i + 1; 
%   end
  diferenta intre frameuri
a_frame = (im2double(imread('a_frame1.png')));
a_frame1 = (im2double(imread('a_frame40.png')));
differenceImage =segmentare(abs(im2double(imread('a_frame1.png'))) - im2double(imread('a_frame5.png')));
imshow(differenceImage, []);
Obj=VideoReader('trafic_Trim.mp4');
% 
% BW1 = differenceImage;
% SE = strel('disk',[3]);
% BW2 = imerode(BW1,SE);
% figure();
% imshow(BW2)
% title('IMAGINE DUPA ERODARE');
% BW3 = imdilate(BW2,SE);
% figure();
% imshow(BW3)
% title('IMAGINE DUPA ERODARE+DILATARE');
% 
% video = VideoWriter('rezvid.avi'); %creaza vd obj
% open(video); %deschidem fila pt scriere
% for ii=1:1 %N nr img
%   I = BW3; %citim urm img
%   writeVideo(video,I); %scriem img 
% end
% close(video); 
% 
% v = imgs;
% 
% vl = length(v);
% 
% im1 = 1;
% while  
% % im2 = 10;
% for i = im1:5
%  differenceImage =segmentare(abs(im2double(imread(v(im1-1)))) - im2double(imread(v(im1+5))));
% 
% end
% im1 = im1+5;
% end
% 
% 




 