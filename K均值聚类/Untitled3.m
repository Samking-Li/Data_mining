close all;
clear all;
clc;

csv=csvread('Êý¾Ý¼¯2\iris.csv',1,0);
id=csv(:,1);
data=csv(:,2:5);
X=data(:,1);
Y=data(:,2);
Z=data(:,3);
W=data(:,4);
u1list={};u2list={};u3list={};
cls1=[];cls2=[];cls3=[];
u1 = [rand(1,1)*max(X),rand(1,1)*max(Y),rand(1,1)*max(Z)]; 
u2 = [rand(1,1)*max(X),rand(1,1)*max(Y),rand(1,1)*max(Z)]; 
u3 = [rand(1,1)*max(X),rand(1,1)*max(Y),rand(1,1)*max(Z)]; 
newu1 =[];newu2 =[];newu3 =[];
newSSE=inf;
X1=[];X2=[];X3=[]; Y1=[];Y2=[];Y3=[]; 
Z1=[];Z2=[];Z3=[]; W1=[];W2=[];W3=[];

u1 = [rand(1,1)*max(X),rand(1,1)*max(Y),rand(1,1)*max(Z),rand(1,1)*max(W)]; 
u2 = [rand(1,1)*max(X),rand(1,1)*max(Y),rand(1,1)*max(Z),rand(1,1)*max(W)]; 
u3 = [rand(1,1)*max(X),rand(1,1)*max(Y),rand(1,1)*max(Z),rand(1,1)*max(W)]; 
    for i=(1:length(data))
        if min([dist([X(i) Y(i) Z(i) W(i)],u1'),dist([X(i) Y(i) Z(i) W(i)],u2'),dist([X(i) Y(i) Z(i) W(i)],u3')])...
            ==dist([X(i) Y(i) Z(i) W(i)],u1')
            X1=[X1 X(i)];Y1=[Y1 Y(i)];Z1=[Z1 Z(i)];W1=[W1 W(i)];cls1=[cls1 id(i)];
        elseif min([dist([X(i) Y(i) Z(i) W(i)],u1'),dist([X(i) Y(i) Z(i) W(i)],u2'),dist([X(i) Y(i) Z(i) W(i)],u3')])...
            ==dist([X(i) Y(i) Z(i) W(i)],u2')
            X2=[X2 X(i)];Y2=[Y2 Y(i)];Z2=[Z2 Z(i)];W2=[W1 W(i)];cls2=[cls2 id(i)];
        else
            X3=[X3 X(i)];Y3=[Y3 Y(i)];Z3=[Z3 Z(i)];W3=[W1 W(i)];cls3=[cls3 id(i)];
        end
    end

    SSE=sum((X-u1(1)).^2+(Y-u1(2)).^2+(Z-u1(3)).^2+(W-u1(4)).^2)+...
    sum((X-u2(1)).^2+(Y-u2(2)).^2+(Z-u2(3)).^2+(W-u2(4)).^2)+...
    sum((X-u3(1)).^2+(Y-u3(2)).^2+(Z-u3(3)).^2+(W-u3(4)).^2);
while abs(SSE-newSSE)>0
    SSE=newSSE;
    newu1 =[sum(X1)/length(X1) sum(Y1)/length(Y1) sum(Z1)/length(Z1) sum(W1)/length(W1)];
    newu2 =[sum(X2)/length(X2) sum(Y2)/length(Y2) sum(Z2)/length(Z2) sum(W2)/length(W2)];
    newu3 =[sum(X3)/length(X3) sum(Y3)/length(Y3) sum(Z3)/length(Z3) sum(W3)/length(W3)];
    X1=[];X2=[];X3=[]; Y1=[];Y2=[];Y3=[]; 
    Z1=[];Z2=[];Z3=[]; W1=[];W2=[];W3=[];
    for i=(1:length(data))
        if min([dist([X(i) Y(i) Z(i) W(i)],newu1'),dist([X(i) Y(i) Z(i) W(i)],newu2'),dist([X(i) Y(i) Z(i) W(i)],newu3')])...
            ==dist([X(i) Y(i) Z(i) W(i)],newu1')
            X1=[X1 X(i)];Y1=[Y1 Y(i)];Z1=[Z1 Z(i)];
        elseif min([dist([X(i) Y(i) Z(i) W(i)],newu1'),dist([X(i) Y(i) Z(i) W(i)],newu2'),dist([X(i) Y(i) Z(i) W(i)],newu3')])...
            ==dist([X(i) Y(i) Z(i) W(i)],newu2')
            X2=[X2 X(i)];Y2=[Y2 Y(i)];Z2=[Z2 Z(i)];
        else
            X3=[X3 X(i)];Y3=[Y3 Y(i)];Z3=[Z3 Z(i)];
        end
    end
    newSSE=sum((X-newu1(1)).^2+(Y-newu1(2)).^2+(Z-newu1(3)).^2+(W-newu1(4)).^2)...
        +sum((X-newu2(1)).^2+(Y-newu2(2)).^2+(Z-newu2(3)).^2+(W-newu2(4)).^2)...
        +sum((X-newu1(1)).^2+(Y-newu1(2)).^2+(Z-newu1(3)).^2+(W-newu1(4)).^2);
end

sum1=0;sum2=0;sum3=0;
for i=1:length(cls1)
    if cls1(i)<=50
        sum1=sum1+1;
    elseif cls1(i)<=100 && cls1(i)>50
        sum2=sum2+1;
    elseif cls1(i)<=150 && cls1(i)>100
        sum3=sum3+1;
    end
end
sumT1=max([sum1 sum2 sum3]);
sum1=0;sum2=0;sum3=0;
for i=1:length(cls2)
    if cls2(i)<=50
        sum1=sum1+1;
    elseif cls2(i)<=100 && cls2(i)>50
        sum2=sum2+1;
    elseif cls2(i)<=150 && cls2(i)>100
        sum3=sum3+1;
    end
end
sumT2=max([sum1 sum2 sum3]);
sum1=0;sum2=0;sum3=0;
for i=1:length(cls3)
    if cls3(i)<=50
        sum1=sum1+1;
    elseif cls3(i)<=100 && cls3(i)>50
        sum2=sum2+1;
    elseif cls3(i)<=150 && cls3(i)>100
        sum3=sum3+1;
    end
end
sumT3=max([sum1 sum2 sum3]);
sum1=0;sum2=0;sum3=0;

purity=(sumT1+sumT2+sumT3)/length(data);