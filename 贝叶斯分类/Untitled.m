close all;
clear all;
clc;
%%
%读取数据
filename = 'breast-cancer\breast-cancer.txt';
fileID = fopen(filename);
data = textscan(fileID,'%s%s%s%s%s%s%s%s%s%s','Delimiter',',');
fclose(fileID);
attrib = [data{1,1}, data{1,2}, data{1,3}, data{1,4}, data{1,5}, data{1,6}, data{1,7}, data{1,8}, data{1,9}, data{1,10}];

X1=floor(201*0.8);
X2=floor(85*0.8);

c1=attrib(1:X1,:);c2=attrib(202:201+X2,:);
c3=attrib(X1+1:201,:);c4=attrib(201+X2:286,:);

tdata=cat(1,c3,c4);
n_age=[];n_menopause=[];n_tumor_size=[];
n_inv_nodes=[];n_node_caps=[];n_deg_malig=[];
n_breast=[];n_breast_quad=[];n_irradiat=[];

n1_age=[];n1_menopause=[];n1_tumor_size=[];
n1_inv_nodes=[];n1_node_caps=[];n1_deg_malig=[];
n1_breast=[];n1_breast_quad=[];n1_irradiat=[];
%%
%计算各后验概率
age = {"10-19","20-29","30-39","40-49","50-59","60-69","70-79","80-89","90-99"};
for i =1:9
    n_age(1,i)=length(find(c1(:,2)==age{i}))/X1;
    n1_age(1,i)=length(find(c2(:,2)==age{i}))/X2;
end

menopause={"lt40","ge40","premeno"};
for i =1:3
    n_menopause(1,i)=length(find(c1(:,3)==menopause{i}))/X1;
    n1_menopause(1,i)=length(find(c2(:,3)==menopause{i}))/X2;
end

tumor_size={"0-4","5-9","10-14","15-19","20-24","25-29","30-34","35-39","40-44","45-49","50-54","55-59"};
for i =1:12
    n_tumor_size(1,i)=length(find(c1(:,4)==tumor_size{i}))/X1;
    n1_tumor_size(1,i)=length(find(c2(:,4)==tumor_size{i}))/X2;
end

inv_nodes={"0-2","3-5","6-8","9-11","12-14","15-17","18-20","21-23","24-26","27-29","30-32","33-35","36-39"};
for i =1:13
    n_inv_nodes(1,i)=length(find(c1(:,5)==inv_nodes{i}))/X1;
    n1_inv_nodes(1,i)=length(find(c2(:,5)==inv_nodes{i}))/X2;
end

node_caps={"yes","no"};
for i =1:2
    n_node_caps(1,i)=length(find(c1(:,6)==node_caps{i}))/X1;
    n1_node_caps(1,i)=length(find(c2(:,6)==node_caps{i}))/X2;
end

deg_malig={"1","2","3"};
for i =1:3
    n_deg_malig(1,i)=length(find(c1(:,7)==deg_malig{i}))/X1;
    n1_deg_malig(1,i)=length(find(c2(:,7)==deg_malig{i}))/X2;
end

breast={"left","right"};
for i =1:2
    n_breast(1,i)=length(find(c1(:,8)==breast{i}))/X1;
    n1_breast(1,i)=length(find(c2(:,8)==breast{i}))/X2;
end

breast_quad={"left-up","left-low","right-up","right-low","central"};
for i =1:5
    n_breast_quad(1,i)=length(find(c1(:,9)==breast_quad{i}))/X1;
    n1_breast_quad(1,i)=length(find(c2(:,9)==breast_quad{i}))/X2;
end

irradiat={"yes","no"};
for i =1:2
    n_irradiat(1,i)=length(find(c1(:,10)==irradiat{i}))/X1;
    n1_irradiat(1,i)=length(find(c2(:,10)==irradiat{i}))/X2;
end
a={age,menopause,tumor_size,inv_nodes,node_caps,deg_malig,breast,breast_quad,irradiat};
n={n_age,n_menopause,n_tumor_size,n_inv_nodes,n_node_caps,n_deg_malig,n_breast,n_breast_quad,n_irradiat};
n1={n1_age,n1_menopause,n1_tumor_size,n1_inv_nodes,n1_node_caps,n1_deg_malig,n1_breast,n1_breast_quad,n1_irradiat};
%%
%
sum=0;
p1=X1/(X1+X2);
p2=X2/(X1+X2);

for k =i:length(tdata(:,1))
    for i =1:9
        for j=1:length(n{i})
            if tdata{k,i+1}==a{1,i}{1,j}
                p1=p1*n{1,i}(1,j);
            end
        end
    end

    for i =1:9
        for j=1:length(n1{i})
            if tdata{k,i+1}==a{1,i}{1,j}
                p2=p2*n1{1,i}(1,j);
            end
        end
    end
    if p1>p2
        result="no-recurrence-events"
    else
        result="recurrence-events"
    end
    if result ==tdata{k,1}
        sum=sum+1;
    end
end

right_rate=sum/length(tdata(:,1))
