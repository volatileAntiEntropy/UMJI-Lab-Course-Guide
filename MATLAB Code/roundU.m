function [V,uV] = roundU(V0,uV0)
if size(V0)==size(uV0)
    V=V0;
    uV=round(uV0,2,'significant');
    selector=~isFirstOne(uV);
    uV(selector)=round(uV(selector),1,'significant');
    decimals=-getOrder(uV);decimals(decimals==inf)=zeros(size(decimals(decimals==inf)));
    for j=1:size(V,2)
        for i=1:size(V,1)
            V(i,j)=round(V(i,j),decimals(i,j));
        end
    end
end
end

function n=getOrder(x)
estimation=-round(log10(x));
x=x.*(10.^estimation);
n=-(estimation+(x<1)+(floor(x)==1));
end

function result=isFirstOne(x)
element=log10(round(x,1,'significant'));
result=element==round(element);
end