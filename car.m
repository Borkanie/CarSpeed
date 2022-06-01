classdef car
    %UNTITLED2 Summary of this class goes here
    %   Detailed explanation goes here

    properties
        BB;
        speed=0;
    end

    methods
        function obj = car(BB)
            %UNTITLED2 Construct an instance of this class
            %   Detailed explanation goes here
            obj.BB = BB;
            obj.speed=0;
        end
        
        function [isTheSame]=isTheSameCar(obj,car)
             isTheSame=isPointInBB(getCOG(car.BB),obj.BB);
        end
        function [isStillRelevant]=isStillInInteres(obj,interesRectangle)
             isStillRelevant=isPointInBB(getCOG(obj.BB),interesRectangle);
        end
        function obj=move(obj,BB)
            newcog=getCOG(BB);
            cog=getCOG(obj.BB);
            sp=sqrt(sum((newcog-cog).^2))/24;
            obj.speed=sp;
            obj.BB=BB;
        end
    end
end