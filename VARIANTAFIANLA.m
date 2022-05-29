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
count=0;
[lini, coloane, Nr_poze] = size (images)
bbox = [0 0 0 0];
cars=[car(bbox)];
for i=1:Nr_poze-5
    differenceImage =(abs(im2double(images(:,:,i))) - im2double(images(:,:,i+5)));
    level=graythresh(differenceImage);
    BW1 = im2bw(differenceImage,level);
    imshow(differenceImage);
    SE = strel('disk',3);
    BW2 = imerode(BW1,SE);
    title('IMAGINE DUPA ERODARE');
    BW3 = imdilate(BW2,strel('disk',22));
    info = regionprops(BW3,'Boundingbox','Area') ;
    figure(5)
    imshow(images(:,:,i+2))
    hold on
    N=1750;
    COG=0;
    for k = 1 : size(info,1)
        BB = info(k).BoundingBox;        
        area=info(k).Area;
        BB(2)
        if(BB(2)>1)
            if (area>N)
                newcar=car(BB);
                cars=TryAddCarToCars(cars,newcar);
                if (BB(1)<=P1(1)&&P1(1)<=BB(1)+BB(3)) && (BB(2)<=P1(2)&&P1(2)<=BB(2)+BB(4))
                    if isCarInRectangle==false
                        count=count+1;
                    end

                elseif (BB(1)<=P2(1)&&P2(1)<=BB(1)+BB(3)) && (BB(2)<=P2(2)&&P2(2)<=BB(2)+BB(4))
                    if isCarInRectangle==false
                        count=count+1;
                    end
                    isCarInRectangle=true;
                elseif (BB(1)<=P3(1)&&P3(1)<=BB(1)+BB(3)) && (BB(2)<=P3(2)&&P3(2)<=BB(2)+BB(4))
                    if isCarInRectangle==false
                        count=count+1;
                    end
                    isCarInRectangle=true;
                elseif (isCarInRectangle==true)
                    if (N1>=70)
                        isCarInRectangle=false;
                        N1=0;
                    else
                        N1=N1+1;
                    end
                end            

                rectangle('Position', [BB(1),BB(2),BB(3),BB(4)],'EdgeColor','r','LineWidth',2) ;
                % showShape('line',[320 900 580 850]*0.5,'Color','green')
            end
            % showShape('line',[380 800 780 660]*0.5,'Color','green')
            hold off
            showShape('line',[440 800 760 700]*0.5,'Color','green')
            disp(count);
        end
    end


end
%clasa de dreptunghiuri cu cog
%la fiecare iteratie verificam iara care sunt cele posibile sa fie noua
%pozitie a dreptunghiului vechi

function [cars]=TryAddCarToCars(cars,car)

    for i=1:length(cars)
        cars(i)=cars(i).move(car.BB);
        if cars(i).speed>0
            fprintf('Speed of car %i is %i',[i,cars(i).speed]);
            return;
        end
    end  
    toRemove=[];
    for i=1:length(cars)
         if cars(i).speed==-100
             toRemove=[toRemove i];            
        end
    end
    for j=length(toRemove):1
         if toRemove(j)==1
                  cars=[cars(toRemove(j)+1:length(cars))];
         else
                cars=[cars(1:toRemove(j)-1),cars(toRemove(j)+1:length(cars))];
         end
         fprintf('Removed car %i',i);
    end
      cars(length(cars)+1)=car;
end