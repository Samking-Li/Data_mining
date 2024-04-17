close all;
clear all;
clc;

X=[2;2;8;5;7;6;1;4];
Y=[10;5;4;8;5;4;2;9];
u1 = [2,10];
u2 = [5,8]; 
u3 = [1,2]; 

newu1 =[];newu2 =[];newu3 =[];
newSSE=inf;
X1=[];X2=[];X3=[];Y1=[];Y2=[];Y3=[];
k=1;
newu1 =[];newu2 =[];newu3 =[];
newSSE=inf;
 
for i=(1:length(X))
    if min([dist([X(i) Y(i)],u1'),dist([X(i) Y(i)],u2'),dist([X(i) Y(i)],u3')])...
        ==dist([X(i) Y(i)],u1')
        X1=[X1 X(i)];Y1=[Y1 Y(i)];
    elseif min([dist([X(i) Y(i)],u1'),dist([X(i) Y(i)],u2'),dist([X(i) Y(i)],u3')])...
        ==dist([X(i) Y(i)],u2')
        X2=[X2 X(i)];Y2=[Y2 Y(i)];
    else
        X3=[X3 X(i)];Y3=[Y3 Y(i)];
    end
end

SSE=sum((X1-u1(1)).^2)+sum((Y1-u1(2)).^2)+...
sum((X2-u2(1)).^2)+sum((Y2-u2(2)).^2)+...
sum((X3-u3(1)).^2)+sum((Y3-u3(2)).^2);

figure;
scatter(X1,Y1,'.','red');
hold on
scatter(X2,Y2,'.','blue');
scatter(X3,Y3,'.','green');
scatter(u1(1),u1(2),'*','red');
scatter(u2(1),u2(2),'*','blue');
scatter(u3(1),u3(2),'*','green');
title(sprintf("第%d次迭代",k));
hold off

while abs(SSE-newSSE)>0
    SSE=newSSE;
    newu1 =[sum(X1)/length(X1) sum(Y1)/length(Y1)];
    newu2 =[sum(X2)/length(X2) sum(Y2)/length(Y2)];
    newu3 =[sum(X3)/length(X3) sum(Y3)/length(Y3)];
    X1=[];X2=[];X3=[]; Y1=[];Y2=[];Y3=[]; 
    for i=(1:length(X))
        if min([dist([X(i) Y(i)],newu1'),dist([X(i) Y(i)],newu2'),dist([X(i) Y(i)],newu3')])...
            ==dist([X(i) Y(i)],newu1')
            X1=[X1 X(i)];Y1=[Y1 Y(i)];
        elseif min([dist([X(i) Y(i)],newu1'),dist([X(i) Y(i)],newu2'),dist([X(i) Y(i)],newu3')])...
            ==dist([X(i) Y(i)],newu2')
            X2=[X2 X(i)];Y2=[Y2 Y(i)];
        else
            X3=[X3 X(i)];Y3=[Y3 Y(i)];
        end
    end
    k=k+1;
    figure;
    scatter(X1,Y1,'.','red');
    hold on
    scatter(X2,Y2,'.','blue');
    scatter(X3,Y3,'.','green');
    scatter(newu1(1),newu1(2),'*','red');
    scatter(newu2(1),newu2(2),'*','blue');
    scatter(newu3(1),newu3(2),'*','green');
    title(sprintf("第%d次迭代",k));
    hold off
    newSSE=sum((X1-newu1(1)).^2)+sum((Y1-newu1(2)).^2)...
        +sum((X-newu2(1)).^2)+sum((Y-newu2(2)).^2)...
        +sum((X-newu1(1)).^2)+sum((Y-newu1(2)).^2);
end

