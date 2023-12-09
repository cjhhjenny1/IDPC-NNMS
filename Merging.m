function [numClust,center,labels] = Merging(lemda,numClust,rho,nnb,fnn,dist,cl,center)
    n=length(rho);
    flag = 0;
    a=[1,2];
    labels=zeros(n,1);
    [Sim,NN,SNN,WS] = SimSubClust(lemda,numClust,rho,nnb,fnn,dist,cl,center);
    %相似度最大的两个子簇
    for i=1:numClust-1
        for j=i+1:numClust
            if(Sim(i,j)>Sim(a(1),a(2)))
                a(1)=i;
                a(2)=j;
            end
        end
    end
    %计算合并后的簇内相似度
    c=union(cl{a(1)},cl{a(2)});
    W=0;
    if(rho(center(a(1)))>rho(center(a(2))))
        for ii=1:length(c)
            if(c(ii)~=center(a(1)))
                W=W+1/((length(c)-1)*dist(c(ii),center(a(1)))); %W为合并后的簇间相似度
            end
        end
    else
        for ii=1:length(c)
            if(c(ii)~=center(a(2)))
                W=W+1/((length(c)-1)*dist(c(ii),center(a(2))));
            end
        end
    end
    %根据条件判断是否合并
    if(isempty(NN(a(1),a(2)))||isempty(SNN(a(1),a(2)))||WS(a(1))+WS(a(2))>W)
        flag=1;
    end
    %每次合并相似度最大的两个子集群，每次合并后重新计算相似度和判别条件
    while (flag==0)
        cl1=cl;
        center1=center;
        cl=cell(numClust-1,1);
        center=zeros(numClust-1,1);
        b=0;
        for i=1:numClust
            if (i~=a(1)&&i~=a(2))
                b=b+1;
                cl{b}=cl1{i};
                center(b)=center1(i);
            end
        end
        cl{numClust-1}=union(cl1{a(1)},cl1{a(2)});
        if(rho(center(a(1)))>rho(center(a(2))))
            center(mumClust-1)=center1(a(1));
        else
            center(numClust-1)=center1(a(2));
        end
        numClust=numClust-1;
        [Sim,NN,SNN] = SimSubClust(lemda,numClust,rho,nnb,fnn,dist,cl,center);
        for i=1:numClust-1
            for j=i+1:numClust
                if(Sim(i,j)>Sim(a(1),a(2)))
                    a(1)=i;
                    a(2)=j;
                end
            end
        end
        W=0;
        if(rho(center(a(1)))>rho(center(a(2))))
            for ii=1:length(c)
                if(c(ii)~=center(a(1)))
                    W=W+1/((length(c)-1)*dist(c(ii),center(a(1))));
                end
            end
        else
            for ii=1:length(c)
                if(c(ii)~=center(a(2)))
                    W=W+1/((length(c)-1)*dist(c(ii),center(a(2))));
                end
            end
        end
        if(isempty(NN(a(1),a(2)))||isempty(SNN(a(1),a(2)))||WS(a(1))+WS(a(2))>W)
            flag=1;
        end
    end
    for i=1:numClust
        labels(cl{i}(1:end))=i;
    end
end

