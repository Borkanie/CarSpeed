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
    image = read(obj,k);
    mov(k).cdata = 0.3image(:,:,1) + 0.6image(:,:,2) + 0.1*image(:,:,3);
end
implay(mov)