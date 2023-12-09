function [dist] = Dist(X)
%CACULATEDISTANCE 此处显示有关此函数的摘要
%   此处显示详细说明
    dist=pdist2(X,X);
    n = size(dist,1);
    for i=1:n
        dist(i,i)=inf;
    end
end

