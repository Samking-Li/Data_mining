close all;
clear all;
clc;

data=csvread('数据集1\数据集1.csv',1,1);
X=data(:,1);
Y=data(:,2);
Z=data(:,3);
u1 = [0,0,0];
u2 = [1,1,-1]; 
u1list={};u2list={};
%u1 = [rand(1,1)*max(X),rand(1,1)*max(Y),rand(1,1)*max(Z)]; 
%u2 = [rand(1,1)*max(X),rand(1,1)*max(Y),rand(1,1)*max(Z)]; 
newu1 =[];newu2 =[];
newSSE=inf;
X1=[];X2=[];Y1=[];Y2=[];Z1=[];Z2=[];
k=1;
for i=(1:length(X))
    if sqrt((X(i)-u1(1))^2+(Y(i)-u1(2))^2+(Z(i)-u1(3))^2)<sqrt((X(i)-u2(1))^2+(Y(i)-u2(2))^2+(Z(i)-u2(3))^2)
         X1=[X1 X(i)];Y1=[Y1 Y(i)];Z1=[Z1 Z(i)];
    else
         X2=[X2 X(i)];Y2=[Y2 Y(i)];Z2=[Z2 Z(i)];
    end
end

figure;
scatter3(X1,Y1,Z1,'.','red');
hold on
scatter3(X2,Y2,Z2,'.','blue');
scatter3(u1(1),u1(2),u1(3),'*','red');
scatter3(u2(1),u2(2),u2(3),'*','blue');
title(sprintf("第%d次迭代",k));
hold off
SSE=sum((X-u1(1)).^2+(Y-u1(2)).^2+(Z-u1(3)).^2)+sum((X-u2(1)).^2+(Y-u2(2)).^2+(Z-u2(3)).^2);
u1list{k}=u1;u2list{k}=u2;
while abs(SSE-newSSE)>1e+04
    SSE=newSSE;
    k=k+1;
    newu1 =[sum(X1)/length(X1) sum(Y1)/length(Y1) sum(Z1)/length(Z1)];
    newu2 =[sum(X2)/length(X2) sum(Y2)/length(Y2) sum(Z2)/length(Z2)];
    X1=[];X2=[];Y1=[];Y2=[];Z1=[];Z2=[];
    for i=(1:length(X))
        if sqrt((X(i)-newu1(1))^2+(Y(i)-newu1(2))^2+(Z(i)-newu1(3))^2)<sqrt((X(i)-newu2(1))^2 ...
            +(Y(i)-newu2(2))^2+(Z(i)-newu2(3))^2)
            X1=[X1 X(i)];Y1=[Y1 Y(i)];Z1=[Z1 Z(i)];
        else
            X2=[X2 X(i)];Y2=[Y2 Y(i)];Z2=[Z2 Z(i)];
        end
    end
    figure;
    scatter3(X1,Y1,Z1,'.','red');
    hold on
    scatter3(X2,Y2,Z2,'.','blue');
    scatter3(newu1(1),newu1(2),newu1(3),'*','red');
    scatter3(newu2(1),newu2(2),newu2(3),'*','blue');
    title(sprintf("第%d次迭代",k));
    hold off
    newSSE=sum((X-newu1(1)).^2+(Y-newu1(2)).^2+(Z-newu1(3)).^2)...
        +sum((X-newu2(1)).^2+(Y-newu2(2)).^2+(Z-newu2(3)).^2);
    u1list{k}=newu1;u2list{k}=newu2;
end