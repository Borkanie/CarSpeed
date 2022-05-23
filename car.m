classdef car
    %UNTITLED2 Summary of this class goes here
    %   Detailed explanation goes here

    properties
        BB;
    end

    methods
        function obj = car(BB)
            %UNTITLED2 Construct an instance of this class
            %   Detailed explanation goes here
            obj.BB = BB;
        end

        function outputArg = method1(obj,BB)
            %MOVE
            %   Detailed explanation goes here
            cog1=cetCOG(BB);
            distance=sqrt(cog1.^2+getCOG(obj.BB).^2);
            if distance<obj.BB(3)
                outputArg=distance;
                obj.BB=BB;
            else
                outputArg=0;
            end            
        end
    end
end