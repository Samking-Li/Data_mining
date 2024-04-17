function [re]=in(a,b)
re=0;
b=b';
m=size(b,1);
n=length(a);
        if(sum(all(b == repmat(a,size(b,1),1),2))==1)
            re=1;
        end

end    