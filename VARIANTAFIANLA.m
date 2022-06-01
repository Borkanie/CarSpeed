clc
clear all
close all

P1=[600;750]*0.5;
P2=[600;750]*0.5;
P3=[680;725]*0.5;
% Lungime bara
LungimeBaraPixeli = sqrt(sum([440-760; 800-700].^2));

%% CITIREA VIDEO CLIPULUI/frame-uri
% implay('trimm.mp4');
obj=VideoReader('litere1.mp4');
nFrames=obj.NumFrames;
vidHeight=obj.Height;
vidWidth=obj.Width;

isCarInRectangle=false;
N1=0;
mov(1:nFrames)=struct('cdata',zeros(vidHeight,vidWidth,1,'uint8'),'colormap',[]);
for k=1:nFrames
    frame = read(obj,k);
    gray_frame=rgb2gray(frame);
    % gray_frame=imresize(gray_frame,0.5);
    % gray_frame=rgb2gray(gray_frame);
    images(:,:,k)=gray_frame;
    %  images1(:,:,k)=frame;
    % imshow(gray_frame);
end

%% diferenta intre frameuri
%areea of interes where we count car speed in pixels
interesRectangle=[100 200 200 1000];
count=0;
[lini, coloane, Nr_poze] = size (images)
bbox = [0 0 0 0];
cars=[car(bbox)];
for i=1:Nr_poze-5
    differenceImage =(abs(im2double(images(:,:,i))) - im2double(images(:,:,i+5)));
    level=graythresh(differenceImage);
    BW1 = im2bw(differenceImage,level);
    %imshow(differenceImage);
    SE = strel('disk',3);
    BW2 = imerode(BW1,SE);
    title('IMAGINE DUPA ERODARE');
    BW3 = imdilate(BW2,strel('disk',22));
    info = regionprops(BW3,'Boundingbox','Area') ;
    figure(5)
    clf();
    imshow(images(:,:,i+2));
    hold on
    N=1750;
    COG=0;
    for k = 1 : size(info,1)
        BB = info(k).BoundingBox;
        area=info(k).Area;
        if(BB(2)>1)
            if (area>N)
                if isPointInBB(getCOG(BB),interesRectangle)
                    newcar=car(BB);
                    cars=TryAddCarToCars(cars,newcar,interesRectangle);
                end
                cars=tryRemoveCarToCars(cars,interesRectangle);

                rectangle('Position', [BB(1),BB(2),BB(3),BB(4)],'EdgeColor','r','LineWidth',2) ;
                % showShape('line',[320 900 580 850]*0.5,'Color','green')
            end
            % showShape('line',[380 800 780 660]*0.5,'Color','green')
            for i=1:length(cars)
                chr=int2str(cars(i).speed*100);
                text(cars(i).BB(1),cars(i).BB(2),chr,'Color','green','FontSize',10);
            end
            hold on
            showShape('line',[440 800 760 700]*0.5,'Color','green');
            %disp(count);
        end
    end


end
%clasa de dreptunghiuri cu cog
%la fiecare iteratie verificam iara care sunt cele posibile sa fie noua
%pozitie a dreptunghiului vechi

function [cars]=TryAddCarToCars(cars,car,interesRectangle)
for i=1:length(cars)
    if cars(i).isStillInInteres(interesRectangle)
        if cars(i).isTheSameCar(car)
            cars(i)=cars(i).move(car.BB);
            fprintf('Speed of car %i is %i \n',[i,cars(i).speed]);
            return;
        end
    end

end
cars(length(cars)+1)=car;
fprintf('Added car %i \n',length(cars));
end

function [newcars]=tryRemoveCarToCars(cars,interesRectangle)
indexToBeRemoved=[];
for i=1:length(cars)
    if ~cars(i).isStillInInteres(interesRectangle)
        indexToBeRemoved=[indexToBeRemoved i];
        fprintf('Car %i is out of scope \n',i);
    end
end
cars(indexToBeRemoved)=[];
newcars=cars;
if length(indexToBeRemoved)>1
    fprintf('Removed %i cars \n',length(indexToBeRemoved));
end
end