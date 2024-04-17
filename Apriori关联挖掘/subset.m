function [a]=subset(b)
%对于含有k个元素的集合，生成该集合的所有k-1项子集
%生成过程，用全集分别减去某一个元素就可以得到一个K-1项子集
m=length(b);
a{1}=b(2:m);
    for i=2:m
        NEW=b;
        NEW(i)=[];
        a{i}=NEW;
    end
end        