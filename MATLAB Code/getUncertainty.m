function [V,uV] = getUncertainty(data,errorB,CILevel)
    arguments
        data double {isvector(data)};
        errorB double {isvector(errorB)};
        CILevel (1,1) double = 0.95;
    end
    if numel(data)==numel(errorB)
        UB=norm(errorB)/numel(data);
        UA=getErrorA(data,CILevel);
        [V,uV]=roundU(mean(data),sqrt(UA^2+UB^2));
    else
        error('Data Dimension not Match!');
    end
end

