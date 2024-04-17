close all;
clear all;
clc;


filename = 'Groceries1.csv';
fileID = fopen(filename);
X = textscan(fileID,'%s','Delimiter',',');
item=unique(X{1,1});
fclose(fileID);
X = importdata(filename);
data=[];custom={};
for i =(1:length(X))
    custom(1,i)=textscan(X{i,1},'%s','Delimiter',',');
end
for i =(1:length(custom))
    for j=(1:length(custom{1,i}))
        for k=(1:length(item))
            if strcmp(custom{1,i}{j,1},item{k,1})
                data(i,k)=1;
            end
        end
    end
end
Apriori(data,item);