classdef Literal
    properties
        literalName (1,:) char = '';
        value (1,1) double = 0;
        error (1,1) double = 0;
        unit (1,:) char = '';
    end
    
    methods
        function obj = Literal(Name,Unit)
            arguments
                Name (1,:) char;
                Unit (1,:) char;
            end
            obj.literalName=Name;
            obj.unit=Unit;
        end
        
        function latex = str(obj)
            arguments
                obj (1,1) Literal;
            end
            [val,err]=roundU(obj.value,obj.error);
            latex=['$',obj.literalName,'=',sprintf('%g',val),'\pm ',sprintf('%g',err),'\,\mathrm{',obj.unit,'}$'];
        end
    end
end

