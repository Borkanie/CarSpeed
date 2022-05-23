clc
clear all
close all

img1=imread('imagColor.jpg');
gray=rgb2gray(img1);
BW=imbinarize(gray);
SE = strel('disk',[10]);
    BW2 = imerode(BW,SE);
    BW3 = imdilate(BW2,SE);
% imshow(BW3);

C = imfuse(img1,BW3,'blend','Scaling','joint');
imshow(C)