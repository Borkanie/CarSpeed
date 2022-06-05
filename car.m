classdef car
    %UNTITLED2 Summary of this class goes here
    %   Detailed explanation goes here

    properties
        BB;
        speed=0;
        lastFrame=0;
    end

    methods
        function obj = car(BB,frame)
            %UNTITLED2 Construct an instance of this class
            %   Detailed explanation goes here
            obj.BB = BB;
            obj.speed=0;
            obj.lastFrame=frame;
        end
        
        function [isTheSame]=isTheSameCar(obj,car)
            isTheSame=isPointInBB(getCOG(car.BB),obj.BB);
        end
        function [isStillRelevant]=isStillInInteres(obj,interesRectangle,frame)             
            if obj.lastFrame-frame<50
                isStillRelevant=isPointInBB(getCOG(obj.BB),interesRectangle);
            else
                isStillRelevant=0;
            end
        end
        function obj=move(obj,BB,frame,yRatio,xRatio)
            framesMoved=frame-obj.lastFrame;%frames between locations            
            newcog=getCOG(BB);%get new location
            cog=getCOG(obj.BB);%get old location
            pixelDiff=(newcog-cog);%make location difference in pixels
            meterDiff=[pixelDiff(1)*xRatio;pixelDiff(2)*yRatio];%lienar transformatio to meters
            meterDistance=sqrt(sum(meterDiff.^2))/24;%distance in meters as vector from Pitagora
            recordingFrequency=24;%frames/second
            timeInterval=framesMoved/recordingFrequency;%seconds
            meterSpeed=meterDistance/timeInterval;

            obj.speed=meterSpeed;
            obj.BB=BB;
            obj.lastFrame=frame;%we move location
        end
    end
end