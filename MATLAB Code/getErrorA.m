function UA = getErrorA(data,CILevel)
    arguments
        data double {isvector(data)};
        CILevel (1,1) double = 0.95;
    end
    n=numel(data);
    if n>1
        s=std(data);
        t=getTDistCI(n-1,CILevel);
        UA=t*s/sqrt(n);
    else
        UA=0;
    end
end

