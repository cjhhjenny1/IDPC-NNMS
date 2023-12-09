function [cl] = initalCluster(rho,centInd,nneigh,numClust)
    n=length(rho);
    [~,ordrho]=sort(rho,'descend');
    cl=cell(numClust,1);
    for i=1:n
        if(centInd(ordrho(i))==0)
            centInd(ordrho(i))=centInd(nneigh(ordrho(i)));
        end
    end
    for j=1:n
        cl{centInd(j)}(end+1)=j;
    end
end