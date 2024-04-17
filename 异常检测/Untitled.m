close all;
clear all;
clc;

%读取数据，该脚本由matlab自动生成。
importdata;
n=size(iris,1);
sum=0;
for i = 1:n
    for j = 1:n
        sum=sum+pdist2(iris(i,2:5),iris(j,2:5));
    end
end
r = sum/(n*(n-1));
p = 0.8;
err = [];
for i = 1:n
    count=0;
    for j =1:n
        if and(i~=j,pdist2(iris(i,2:5),iris(j,2:5)) <= r)
            count=count+1;
        end
    end
    if count < p*n
        err=cat(1,err,iris(i,1));
    end
end


disp('离群点编号为：');
err