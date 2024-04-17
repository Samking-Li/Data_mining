close all;
clear all;
clc;

%¶ÁÈ¡Êý¾Ý
[attrib1, attrib2, attrib3, attrib4, class] = textread('iris.data', '%f%f%f%f%s', 'delimiter', ',');
data = [attrib1, attrib2, attrib3, attrib4];
label_set = char('Iris-setosa','Iris-versicolor','Iris-virginica');
label = zeros(150, 1);
label(strcmp(class, 'Iris-setosa')) = 1;
label(strcmp(class, 'Iris-versicolor')) = 2;
label(strcmp(class, 'Iris-virginica')) = 3;
[vec,val] =LDA(data',label');
data=val'.*data;

x1=data(1:50,1);x2=data(51:100,1);x3=data(101:150,1);
y1=data(1:50,2);y2=data(51:100,2);y3=data(101:150,2);
figure
hold on
scatter(x1,y1,"red");
scatter(x2,y2,"green");
scatter(x3,y3,"blue");