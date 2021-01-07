function [X,Y,XErr,YErr]=trimData(x,y,xErr,yErr)
    arguments
        x double {isvector(x)}
        y double {isvector(y)}
        xErr double {isvector(xErr)}
        yErr double {isvector(yErr)}
    end
    if isequal(size(x),size(y)) && isequal(size(x),size(xErr))...
            && isequal(size(y),size(yErr))
        xIndex=find(isinf(x));
        yIndex=find(isinf(x));
        x([xIndex,yIndex])=[];
        xErr([xIndex,yIndex])=[];
        y([xIndex,yIndex])=[];
        yErr([xIndex,yIndex])=[];
        xErrIndex=find(isinf(xErr));
        yErrIndex=find(isinf(yErr));
        xErr(xErrIndex)=x(xErrIndex);
        yErr(yErrIndex)=y(yErrIndex);
        X=x;Y=y;XErr=xErr;YErr=yErr;
    else
        error('Dimension not match!');
    end
end