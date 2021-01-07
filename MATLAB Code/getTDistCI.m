function CIhw = getTDistCI(DoF,CILevel)
    arguments
        DoF (1,1) double;
        CILevel (1,1) double = 0.95;
    end
    C=sqrt(DoF*pi)*gamma(DoF/2)/gamma((DoF+1)/2);
    t=sym('t',{'real'});
    x=sym('x',{'positive'});
    lhs=int((1+t^2/DoF)^(-(DoF+1)/2),t,-x,x);
    CIhw=double(vpasolve(lhs==C*CILevel,x,2));
end

