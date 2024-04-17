function Apriori(data, item)
min_sup=input("��������С֧�ֶ�\n"); % ��С֧�ֶ�(δ����n)
min_con=input("��������С���Ŷ�\n"); % ��С���Ŷ�(�ѳ���n)


[n,m]=size(data);
for i=1:n
	x{i}=find(data(i,:)==1); % ��ÿ�й�����Ʒ�ı��
end

k=0;
while 1
	k=k+1;
	L{k}={};
	if k==1
		C{k}=(1:m)';
	else
		[nL,mL]=size(L{k-1});
		cnt=0;
		for i=1:nL
			for j=i+1:nL
				tmp=union(L{k-1}(i,:),L{k-1}(j,:)); % �����ϲ���
				if length(tmp)==k
					cnt=cnt+1;
					C{k}(cnt,1:k)=tmp;
				end
			end
		end
		C{k}=unique(C{k},'rows'); % ȥ���ظ�����
    end
	[nC,mC]=size(C{k}); % ��ѡ����С
	for i=1:nC
		cnt=0;
		for j=1:n
			if all(ismember(C{k}(i,:),x{j}),2)==1 % all�����ж������Ƿ�ȫΪ1������2��ʾ�����ж�
				cnt=cnt+1;
			end
		end
		C_sup{k}(i,1)=cnt; % ÿ�д��ѡ����Ӧ��֧�ֶ�
    end
	L{k}=C{k}(C_sup{k}>=(9835*min_sup),:);
	if isempty(L{k}) % ���û���ҳ�Ƶ���
		break;
	end
	if size(L{k},1)==1 % Ƶ�������Ϊ1����һ���޷����ɺ�ѡ����ֱ�ӽ���
		k=k+1;
		C{k}={};
		L{k}={};
		break
	end
end

fprintf("\n");
for i=1:k
	fprintf("��%d�ֵĺ�ѡ��Ϊ:",i); C{i}
	fprintf("��%d�ֵ�Ƶ����Ϊ:",i); L{i}
end
fprintf("��%d�ֽ��������Ƶ���Ϊ:",k);
L{k-1}

[nL,mL]=size(L{k-1});
rule_count=0;
for p=1:nL % ��p��Ƶ����
	L_last=L{k-1}(p,:); % ֮��L_last�ֳ������������֣���ʾ�����ǰ���ͺ��
	cnt_ab=0;
	for i=1:n
		if all(ismember(L_last,x{i}),2)==1 % all�����ж������Ƿ�ȫΪ1������2��ʾ�����ж�
			cnt_ab=cnt_ab+1;
		end
	end
	len=floor(length(L_last)/2);
	for i=1:len
		s=nchoosek(L_last,i); % ѡi�������������
		[ns,ms]=size(s);
		for j=1:ns
			a=s(j,:);
			b=setdiff(L_last,a);
			[na,ma]=size(a);
			[nb,mb]=size(b);
			cnt_a=0;
			for i=1:na
				for j=1:n
					if all(ismember(a,x{j}),2)==1 % all�����ж������Ƿ�ȫΪ1������2��ʾ�����ж�
						cnt_a=cnt_a+1;
					end
				end
			end
			pab=cnt_ab/cnt_a;
			if pab>=min_con % ��������a->b�����Ŷȴ��ڵ�����С���Ŷȣ���ǿ��������
				rule_count=rule_count+1;
				rule(rule_count,1:ma)=a;
				rule(rule_count,ma+1:ma+mb)=b;
				rule(rule_count,ma+mb+1)=ma; % �����ڶ��м�¼�ָ�λ��(�ֳɹ����ǰ�������)
				rule(rule_count,ma+mb+2)=pab; % ������һ�м�¼���Ŷ�
            end
			cnt_b=0;
			for i=1:na
				for j=1:n
					if all(ismember(b,x{j}),2)==1 % all�����ж������Ƿ�ȫΪ1������2��ʾ�����ж�
						cnt_b=cnt_b+1;
					end
				end
			end
			pba=cnt_ab/cnt_b;
			if pba>=min_con % ��������b->a�����Ŷȴ��ڵ�����С���Ŷȣ���ǿ��������
				rule_count=rule_count+1;
				rule(rule_count,1:mb)=b;
				rule(rule_count,mb+1:mb+ma)=a;
				rule(rule_count,mb+ma+1)=mb; % �����ڶ��м�¼�ָ�λ��(�ֳɹ����ǰ�������)
				rule(rule_count,mb+ma+2)=pba; % ������һ�м�¼���Ŷ�
			end
		end
	end
end

fprintf("����С֧�ֶ�Ϊ%d����С���Ŷ�Ϊ%.2fʱ�����ɵ�ǿ��������\n",min_sup,min_con);
fprintf("ǿ��������\t\t���Ŷ�\n");
[nr,mr]=size(rule);
for i=1:nr
	pos=rule(i,mr-1); % �Ͽ�λ�ã�1:posΪ����ǰ����pos+1:mr-2Ϊ������
	for j=1:pos
		if j==pos
			fprintf("%s",item{rule(i,j)});
		else 
			fprintf("%s��",item{rule(i,j)});
		end
	end
	fprintf(" => ");
	for j=pos+1:mr-2
		if j==mr-2
			fprintf("%s",item{rule(i,j)});
		else 
			fprintf("%s",item{rule(i,j)});
		end
	end
	fprintf("\t\t%f\n",rule(i,mr));
end
end