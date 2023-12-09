function [lemda,nnb,fnn] = NNSearch(X)
%% 自然邻居搜索算法，反向邻居为0的点的个数不变时停止，得到的最近邻的个数相对来说较小
    n=size(X,1);
    kdtree=KDTreeSearcher(X,'bucketsize',1); % 1表示选用欧式距离
    [index,~] = knnsearch(kdtree,X,'k',100);% 返回排好序的索引和距离
    r=1;
    flag=0;         
    nnb=zeros(n,1);  %自然邻居个数
    fnn=cell(n,1);
    count=0;         %自然最近邻数为零的数据量连续相同的次数
    count1=0;        %前一次自然最近邻数为零的数据量
    count2=0;        %此次自然最近邻数为零的数据量
    while flag==0
        for i=1:n
            k=index(i,r+1);
            nnb(k)=nnb(k)+1;
        end
        r=r+1;
        count2=0;
        [~,count2]=size(find(nnb==0));
        for i=1:n
            if nnb(i)==0
                count2=count2+1;
            end
        end
        %计算nb(i)=0的点的数量连续不变化的次数
        if count1==count2
            count=count+1;
        else
            count=1;
        end
        if count2==0 || (r>2 && count>=2)   %邻居搜索终止条件
            flag=1;
        end
        count1=count2;
    end
    lemda = r-1;
    for i=1:n
        fnn{i}=index(i,2:4*lemda+1);
    end
%     max_nb = max(nnb);         %自然邻居的最大数目
%     min_nb = min(nnb);         %自然邻居的最小数目;

%% 自然邻居搜索算法，当所有点都存在互相最近邻的邻居是停止，得到的最近邻的个数相对来说大一些
%     kdtree=KDTreeSearcher(X,'bucketsize',1); % 1表示选用欧式距离
%     [index,~] = knnsearch(kdtree,X,'k',100);% 返回排好序的索引和距离
%     mnn = zeros(n,n);
%     nnb = zeros(n,1);
%     r = 1;
%     flag = 0;
%     count=zeros(n,1);
%     while r<lemda
%         for i=1:n
%             k = index(i,r+1);
%             nnb(k) = nnb(k)+1;
%             mnn(i,k) = 1;
%         end
%         r = r+1;
%         for ii=1:n
%             count(ii)=mnn(ii,:)*mnn(:,ii);
%         end
%         if ismember(0,count)==1
%             flag = 0;
%         else
%             flag = 1; 
%         end
%     end
%     lemda = r-1;
end