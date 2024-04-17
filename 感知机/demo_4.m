%----------------------- 本程序为第四章感知器算法的示例代码 -----------------------%
close all;
clear all;
clc;
%读取数据
[attrib1, attrib2, attrib3, attrib4, class] = textread('iris.data', '%f%f%f%f%s', 'delimiter', ',');
attrib = [attrib1, attrib2, attrib3, attrib4];
label_set = char('Iris-setosa','Iris-versicolor','Iris-virginica');
label = zeros(150, 1);
label(strcmp(class, 'Iris-setosa')) = 1;
label(strcmp(class, 'Iris-versicolor')) = 2;
label(strcmp(class, 'Iris-virginica')) = 3;
attrib(label==3,:)=[];
label(label==3)=[];
label(label==2)=-1;
classes=label;
 
w0=[0,0,0,0,0]; % 感知器的增广权向量的初始值
%c=1; % 修正系数
c=0.5;
[w, k] = PA(attrib, w0, c, classes); % 调用执行感知器算法的PA子函数，w为最终的增广权向量， k为w的迭代更新次数
 
syms x1 x2; % 定义符号变量x1和x2（分别表示样本的第一个和第二个属性），用于线性判别函数的表示
d=w(1)*x1+w(2)*x2+w(3); % 线性判别函数的表示
 
% 输出w的值和w的迭代更新次数
fprintf('w的值为w(1)=%4.2f, w(2)=%4.2f, w(3)=%4.2f\n,w(4)=%4.2f, w(5)=%4.2f\n',w(1),w(2),w(3),w(4),w(5));
fprintf('w的迭代更新次数为%d\n',k);
