
close all;
clear all;
clc;

%��ȡ����
filename = 'iris\iris.data';
fileID = fopen(filename);
data = textscan(fileID,'%f%f%f%f%s','Delimiter',',','TreatAsEmpty',{'Null'});
fclose(fileID);
attrib = [data{1,1}, data{1,2}, data{1,3}, data{1,4}];
class = data{1,5};

setosa = attrib(1:50,1:4);
versicolor = attrib(51:100,1:4);
virginica = attrib(101:149,1:4);

u1=nanmean(setosa);u2=nanmean(versicolor);u3=nanmean(virginica); % ����ѵ�������ľ�ֵ
%������ݿ�ֵ
for i=1:50
    for j = 1:4
        if isnan(setosa(i,j))
            setosa(i,j) = u1(1,j);
        end
        if isnan(versicolor(i,j))
            versicolor(i,j) = u2(1,j);
        end
        if i<=49
            if isnan(virginica(i,j))
                virginica(i,j) = u3(1,j);
            end
        end
    end
end


%���ݹ淶��
setosa=mapminmax(setosa',0,1)';
versicolor=mapminmax(versicolor',0,1)';
virginica=mapminmax(virginica',0,1)';
u1=nanmean(setosa);u2=nanmean(versicolor);u3=nanmean(virginica);
%���ڸ�����iris.data�����һ�150�У������Ϊ�գ������÷������ж����ں������
%��Ҷ˹��������
c1=cov(setosa);c2=cov(versicolor);c3=cov(virginica);
% ������ѵ��������Э��������Ϊ�ԽǾ�����������Ϊ����������ԣ�����������������
t1=diag(c1);t2=diag(c2);t3=diag(c3);
c1=diag(t1);c2=diag(t2);c3=diag(t3);
% ����ѵ��������Э�������������
inv_c1=inv(c1);inv_c2=inv(c2);inv_c3=inv(c3);
% ����ѵ��������Э������������ʽ
d1=det(c1);d2=det(c2);d3=det(c3);

x_test=[attrib(150,1), attrib(150,2), attrib(150,3), attrib(150,4)];

p1=-0.5*(x_test-u1)*inv_c1*(x_test-u1)'-0.5*log(d1);
p2=-0.5*(x_test-u2)*inv_c2*(x_test-u2)'-0.5*log(d2);
p3=-0.5*(x_test-u3)*inv_c3*(x_test-u3)'-0.5*log(d3);

[~,max_id]=max([p1,p2,p3]);
if max_id == 1
    fprintf('x_test����iris-setosa\n');
    class{150}='iris-setosa';
elseif max_id == 2
    fprintf('x_test����iris-versicolor\n');
    class{150}='iris-versicolor';
elseif max_id == 3
    fprintf('x_test����iris-virginica\n');
    class{150}='iris-virginica';
end

figure(1);subplot(1,4,1);histogram(setosa(:,1));title("iris-setosa 1")
figure(1);subplot(1,4,2);histogram(setosa(:,2));title("iris-setosa 2")
figure(1);subplot(1,4,3);histogram(setosa(:,3));title("iris-setosa 3")
figure(1);subplot(1,4,4);histogram(setosa(:,4));title("iris-setosa 4")

figure(2);subplot(1,4,1);histogram(versicolor(:,1));title("iris-versicolor 1")
figure(2);subplot(1,4,2);histogram(versicolor(:,2));title("iris-versicolor 2")
figure(2);subplot(1,4,3);histogram(versicolor(:,3));title("iris-versicolor 3")
figure(2);subplot(1,4,4);histogram(versicolor(:,4));title("iris-versicolor 4")

figure(3);subplot(1,4,1);histogram(virginica(:,1));title("iris-virginica 1")
figure(3);subplot(1,4,2);histogram(virginica(:,2));title("iris-virginica 2")
figure(3);subplot(1,4,3);histogram(virginica(:,3));title("iris-virginica 3")
figure(3);subplot(1,4,4);histogram(virginica(:,4));title("iris-virginica 4")