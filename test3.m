clc
clear all
close all

P1=[600;750]*0.5;
P2=[600;750]*0.5;
P3=[680;725]*0.5;
% implay('trimm.mp4');
obj=VideoReader('litere.mp4');
nFrames=obj.NumberOfFrames;
vidHeight=obj.Height;
vidWidth=obj.Width;

isCarInRectangle=false;
N1=0;
mov(1:nFrames)=struct('cdata',zeros(vidHeight,vidWidth,1,'uint8'),'colormap',[]);
for k=1:nFrames
    frame = read(obj,k);
    gray_frame=rgb2gray(frame);
    % gray_frame=imresize(gray_frame,0.5);

    % gray_frame = insertShape(gray_frame,'line',[320 900 580 850]*0.5,'Color','green','LineWidth',5);
    % gray_frame=rgb2gray(gray_frame);
    images(:,:,k)=gray_frame;
    %     images1(:,:,k)=frame;

end

%% diferenta intre frameuri
count=0;
[lini, coloane, Nr_poze] = size (images)

for i=1:Nr_poze-5
    differenceImage =(abs(im2double(images(:,:,i))) - im2double(images(:,:,i+5)));
    %     imshow(differenceImage, []);
    level=graythresh(differenceImage);
    BW1 = im2bw(differenceImage,level);

    SE = strel('disk',[3]);
    BW2 = imerode(BW1,SE);
    %     figure();
    %     imshow(BW2)
    title('IMAGINE DUPA ERODARE');
    BW3 = imdilate(BW2,strel('disk',[20]));
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
    figure(5)
    imshow(images(:,:,i+2))
    hold on
    % images(:,:,i+2)
    N=1350;
    % isCarInRectangle=false;

    for k = 1 : size(info,1)
        BB = info(k).BoundingBox;
        area=info(k).Area
        BB(2)

        if(BB(2)>1)
            if (area>N)
                if (BB(1)<=P1(1)&&P1(1)<=BB(1)+BB(3)) && (BB(2)<=P1(2)&&P1(2)<=BB(2)+BB(4))
                    if isCarInRectangle==false
                        count=count+1
                    end
                    isCarInRectangle=true;

                elseif (BB(1)<=P2(1)&&P2(1)<=BB(1)+BB(3)) && (BB(2)<=P2(2)&&P2(2)<=BB(2)+BB(4))
                    if isCarInRectangle==false
                        count=count+1
                    end
                    isCarInRectangle=true;
                elseif (BB(1)<=P3(1)&&P3(1)<=BB(1)+BB(3)) && (BB(2)<=P3(2)&&P3(2)<=BB(2)+BB(4))
                    if isCarInRectangle==false
                        count=count+1
                    end
                    isCarInRectangle=true;
                elseif (isCarInRectangle==true)
                    if (N1>=70)
                    isCarInRectangle=false;
                    N1=0;
                    else N1=N1+1
                    end
                end


                rectangle('Position', [BB(1),BB(2),BB(3),BB(4)],'EdgeColor','r','LineWidth',2) ;
                % showShape('line',[320 900 580 850]*0.5,'Color','green')
            end
            % showShape('line',[380 800 780 660]*0.5,'Color','green')
            hold off
            showShape('line',[440 800 760 700]*0.5,'Color','green')
        end
    end


end