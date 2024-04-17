%----------------------- ������Ϊ�����¸�֪���㷨��ʾ������ -----------------------%
close all;
clear all;
clc;
%��ȡ����
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
 
w0=[0,0,0,0,0]; % ��֪��������Ȩ�����ĳ�ʼֵ
%c=1; % ����ϵ��
c=0.5;
[w, k] = PA(attrib, w0, c, classes); % ����ִ�и�֪���㷨��PA�Ӻ�����wΪ���յ�����Ȩ������ kΪw�ĵ������´���
 
syms x1 x2; % ������ű���x1��x2���ֱ��ʾ�����ĵ�һ���͵ڶ������ԣ������������б����ı�ʾ
d=w(1)*x1+w(2)*x2+w(3); % �����б����ı�ʾ
 
% ���w��ֵ��w�ĵ������´���
fprintf('w��ֵΪw(1)=%4.2f, w(2)=%4.2f, w(3)=%4.2f\n,w(4)=%4.2f, w(5)=%4.2f\n',w(1),w(2),w(3),w(4),w(5));
fprintf('w�ĵ������´���Ϊ%d\n',k);
