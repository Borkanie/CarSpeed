classdef car
    %UNTITLED2 Summary of this class goes here
    %   Detailed explanation goes here

    properties
        BB;
        moved;
        speed=0;
    end

    methods
        function obj = car(BB)
            %UNTITLED2 Construct an instance of this class
            %   Detailed explanation goes here
            obj.BB = BB;
            obj.moved=0;
            obj.speed=0;
        end

        function obj=move(obj,BB)
            %MOVE
            %   Detailed explanation goes here
            cog1=getCOG(BB);
            sp=sqrt(sum((cog1-getCOG(obj.BB)).^2))/24;
            if sp<obj.BB(3)/2
                obj.speed=sp;
                obj.BB=BB;
                obj.moved=obj.moved+1;
            else
                cog=getCOG(obj.BB);
                if cog(2)<600
                    obj.speed=-100;
                    obj.moved=-100;
                else
                    obj.speed=-1;
                end                
            end            
        end
    end
end