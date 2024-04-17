close all;
clear all;
clc;
csv=csvread('Êý¾Ý¼¯2\iris.csv',1,0);
id=csv(:,1);
data=csv(:,2:5);
num=3;
ulist={};
newdata={};
ulist=BisectingKMeansForIris(data,num,ulist);
X1=[];X2=[];X3=[]; Y1=[];Y2=[];Y3=[]; 
Z1=[];Z2=[];Z3=[]; W1=[];W2=[];W3=[];
cls1=[];cls2=[];cls3=[];
sum1=0;sum2=0;sum3=0;
X=data(:,1);Y=data(:,2);
Z=data(:,3);W=data(:,4);
for i=(1:length(data))
    if min([dist([X(i) Y(i) Z(i) W(i)],ulist{1,1}'),dist([X(i) Y(i) Z(i) W(i)],ulist{1,2}')...
            ,dist([X(i) Y(i) Z(i) W(i)],ulist{1,3}')])==dist([X(i) Y(i) Z(i) W(i)],ulist{1,1}')
        
        X1=[X1 X(i)];Y1=[Y1 Y(i)];Z1=[Z1 Z(i)];W1=[W1 W(i)];cls1=[cls1 id(i)];
    elseif min([dist([X(i) Y(i) Z(i) W(i)],ulist{1,1}'),dist([X(i) Y(i) Z(i) W(i)],ulist{1,2}')...
            ,dist([X(i) Y(i) Z(i) W(i)],ulist{1,3}')])==dist([X(i) Y(i) Z(i) W(i)],ulist{1,2}')
    
        X2=[X2 X(i)];Y2=[Y2 Y(i)];Z2=[Z2 Z(i)];W2=[W2 W(i)];cls2=[cls2 id(i)];
    elseif min([dist([X(i) Y(i) Z(i) W(i)],ulist{1,1}'),dist([X(i) Y(i) Z(i) W(i)],ulist{1,2}')...
            ,dist([X(i) Y(i) Z(i) W(i)],ulist{1,3}')])==dist([X(i) Y(i) Z(i) W(i)],ulist{1,3}')
        
        X3=[X3 X(i)];Y3=[Y3 Y(i)];Z3=[Z3 Z(i)];W3=[W3 W(i)];cls3=[cls3 id(i)];
    end
end
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
