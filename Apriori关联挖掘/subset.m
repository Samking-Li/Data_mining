function [a]=subset(b)
%���ں���k��Ԫ�صļ��ϣ����ɸü��ϵ�����k-1���Ӽ�
%���ɹ��̣���ȫ���ֱ��ȥĳһ��Ԫ�ؾͿ��Եõ�һ��K-1���Ӽ�
m=length(b);
a{1}=b(2:m);
    for i=2:m
        NEW=b;
        NEW(i)=[];
        a{i}=NEW;
    end
end        