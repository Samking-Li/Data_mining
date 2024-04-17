function [w, k] = PA (X, w, c, classes)

% 输入：X为训练样本矩阵，每行为一个样本；w为初始的增广权向量； c为修正系数； classes为训练样本的类别向量，其长度等于X的行数
% 输出：w为最终的增广权向量； k为w的迭代更新次数
[N, d] = size(X); % N为训练样本的数目，d为每个训练样本的维数
A=ones(N,1);
X=[X, A]; % 将训练样本表示为增广特征向量的形式
for i=1:N
    X(i, :)=classes(i)*X(i, :); %  将负类的训练样本乘以-1，以便对训练样本进行统一处理
end
k=0; % k为迭代次数（即对w进行更新的次数），初始化为0
a=0; % a为每一轮迭代中被错误判别的训练样本数
for i=1:N
    if w*X(i, :)' > 0
        k=k+1;
    else
        a=a+1; 
        w=w+c*X(i, :); % 对w进行迭代更新
        k=k+1; % 迭代次数加1
    end
end
while a>=1
    a=0; % 每完成一轮迭代后，a需要重新置零
    for i=1:N
        if w*X(i, :)' > 0
            k=k+1;
        else
            a=a+1; 
            w=w+c*X(i, :); % 对w进行迭代更新
            k=k+1; % 迭代次数加1
        end
    end
end

end 
