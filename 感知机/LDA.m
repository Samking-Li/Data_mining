function [vec,val] = LDA(xtr,ytr)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Input:                                                             
%     xtr:  data matrix (Each column is a data point)                
%     ytr:  class label (class 1, ..., k) 
% Output:                                                            
%     vec:  sorted discriminative components
%     val:  corresponding eigenvalues
%%%%%%%%%%%%%%%%%%%%%%%%%%%%

[D, ntr] = size(xtr);
classnum = length(unique(ytr));
miu=mean(xtr,2);

sigmaB = sparse(D, D);
for i = 1:classnum
    miu_class(:,i) = mean(xtr(:,find(ytr==i)),2);
    sigmaB  = sigmaB+length(find(ytr==i))*(miu_class(:,i)-miu)*(miu_class(:,i)-miu)';
end
sigmaB = (sigmaB+sigmaB')/2;

sigmaT = (ntr-1)*cov(xtr');
sigmaT = (sigmaT+sigmaT')/2;

sigmaW = sigmaT-sigmaB;
sigmaW = (sigmaW+sigmaW')/2;

[eigvector,eigvalue] = eig(sigmaB, sigmaW);
[val,id] = sort(-diag(eigvalue));
vec=eigvector(:,id);
val=-val;
 
