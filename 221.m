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
    mov(k).cdata = rgb2grey(read(obj,k))
end
implay(mov)