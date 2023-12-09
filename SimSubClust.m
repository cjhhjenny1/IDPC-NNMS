function [Sim,NN,SNN,WS] = SimSubClust(lemda,numClust,rho,nnb,fnn,dist,cl,center)
%% 
    n1=numClust;
    rho_cl=zeros(n1,1);
    knn_cl=cell(n1,1);
    nnb_cl=cell(n1,1);
    dist_cl=zeros(n1,n1);
    Sim=zeros(n1,n1);
    MDD=zeros(n1,n1);
    SNN=cell(n1,n1);
    NN=cell(n1,n1);
    WS=zeros(n1,1);%簇内相似度
    dis=cell(n1,n1);
    for i=1:n1
        rho_cl(i)=sum(rho(cl{i}(1:end)))/length(cl{i});
        for j=1:length(cl{i})
            knn_cl{i}=union(knn_cl{i},fnn{cl{i}(j)}(1:lemda));
            nnb_cl{i}=union(nnb_cl{i},fnn{cl{i}(j)}(1:nnb(cl{i}(j))));
            if(cl{i}(j)~=center(i))
                WS(i)=WS(i)+1/((length(cl{i})-1)*dist(center(i),cl{i}(j)));
            end
        end
    end
    for i=1:n1-1
        for j=i+1:n1
            MDD(i,j)=abs(rho_cl(i)-rho_cl(j));
            MDD(j,i)=MDD(i,j);
            SNN{i,j}=intersect(knn_cl{i},knn_cl{j});
            SNN{j,i}=SNN{i,j};
            NN{i,j}=intersect(nnb_cl{i},nnb_cl{j});
            NN{j,i}=NN{i,j};
            for ii=1:length(cl{i})
                for jj=1:length(cl{j})
                    dis{i,j}(end+1)=dist(cl{i}(ii),cl{j}(jj));
                end
            end
        end
    end
    for i=1:n1-1
        for j=i+1:n1
            n2=round(0.01*length(cl{i})*length(cl{j}));
            [dis_ord,~]=sort(dis{i,j},'ascend');
            dist_cl(i,j)=sum(dis_ord(1:n2))/n2;
            dist_cl(j,i)=dist_cl(i,j);
        end
    end
    for i=1:n1-1
        for j=i+1:n1
            Sim(i,j)=(length(NN{i,j})+length(SNN{i,j})+1)/((dist(center(i),center(j))*MDD(i,j)+1)*dist_cl(i,j));
            Sim(j,i)=Sim(i,j);
        end
    end
end