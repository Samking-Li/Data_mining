function [ulist]=BisectingKMeansForIris(data,num,ulist)
X=data(:,1);
Y=data(:,2);
Z=data(:,3);
W=data(:,4);
newu1 = [];newu2 = [];
curcls1 = [];curcls2 = [];
cls1 = [];cls2 = [];
newSSE=inf;
minSSE=inf;
X1=[];X2=[];Y1=[];Y2=[];Z1=[];Z2=[];W1=[];W2=[];
curX1=[];curX2=[];curY1=[];curY2=[];curZ1=[];curZ2=[];curW1=[];curW2=[];
for time=1:50
    u1 = [rand(1,1)*max(X),rand(1,1)*max(Y),rand(1,1)*max(Z),rand(1,1)*max(W)]; 
    u2 = [rand(1,1)*max(X),rand(1,1)*max(Y),rand(1,1)*max(Z),rand(1,1)*max(W)]; 
    for i=(1:length(data))
        if min([dist([X(i) Y(i) Z(i) W(i)],u1'),dist([X(i) Y(i) Z(i) W(i)],u2')])...
            ==dist([X(i) Y(i) Z(i) W(i)],u1')
            curX1=[curX1 X(i)];curY1=[curY1 Y(i)];curZ1=[curZ1 Z(i)];
        else
            curX2=[curX2 X(i)];curY2=[curY2 Y(i)];curZ2=[curZ2 Z(i)];
        end
    end

    SSE=sum((X-u1(1)).^2+(Y-u1(2)).^2+(Z-u1(3)).^2+(W-u1(4)).^2)+...
    sum((X-u2(1)).^2+(Y-u2(2)).^2+(Z-u2(3)).^2+(W-u2(4)).^2);
    while abs(SSE-newSSE)>0
        SSE=newSSE;
        newu1 =[sum(curX1)/length(curX1) sum(curY1)/length(curY1) sum(curZ1)/length(curZ1) sum(curW1)/length(curW1)];
        newu2 =[sum(curX2)/length(curX2) sum(curY2)/length(curY2) sum(curZ2)/length(curZ2) sum(curW2)/length(curW2)];
        curX1=[];curX2=[];curY1=[];curY2=[];curZ1=[];curZ2=[];curW1=[];curW2=[];curcls1=[];curcls2=[];
        for i=(1:length(X))
            if sqrt((X(i)-newu1(1))^2+(Y(i)-newu1(2))^2+(Z(i)-newu1(3))^2)<sqrt((X(i)-newu2(1))^2 ...
                +(Y(i)-newu2(2))^2+(Z(i)-newu2(3))^2)
                curX1=[curX1 X(i)];curY1=[curY1 Y(i)];curZ1=[curZ1 Z(i)];curW1=[curW1 W(i)];
            else
                curX2=[curX2 X(i)];curY2=[curY2 Y(i)];curZ2=[curZ2 Z(i)];curW2=[curW2 W(i)];
            end
        end
        newSSE=sum((X-newu1(1)).^2+(Y-newu1(2)).^2+(Z-newu1(3)).^2+(W-u1(4)).^2)...
            +sum((X-newu2(1)).^2+(Y-newu2(2)).^2+(Z-newu2(3)).^2+(W-u2(4)).^2);
    end
end
    if newSSE<minSSE
        X1=curX1;Y1=curY1;Z1=curZ1;W1=curW1;
        X2=curX2;Y2=curY2;Z2=curZ2;W2=curW2;
        cls1=curcls1;cls2=curcls2;
        minSSE=newSSE;
end


while length(ulist)<(num-2)
   if sum((X-newu1(1)).^2+(Y-newu1(2)).^2+(Z-newu1(3)).^2+(W-newu1(4)).^2)<...
       sum((X-newu2(1)).^2+(Y-newu2(2)).^2+(Z-newu2(3)).^2+(W-newu2(4)).^2)
        ulist=[ulist newu1];
        newdata=cat(2,cls2',X2',Y2',Z2',W2');
    else
        ulist=[ulist newu2];
        newdata=cat(2,cls1',X1',Y1',Z1',W1');
   end
    BisectingKMeansForIris(newdata,num,ulist);
end
ulist=[ulist newu1 newu2];
end



