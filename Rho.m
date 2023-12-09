function [rho] = Rho(dist,fnn,lemda)
    n=size(dist,1);
    d=zeros(n,1);
    rho=zeros(n,1);
    for i=1:n
        d(i)=sum(dist(i,fnn{i}(1:end)));
    end
    for ii=1:n
        for jj=1:4*lemda
            rho(ii)=rho(ii)+1/(d(i)+dist(ii,fnn{ii}(jj)));
        end
        rho(ii)=rho(ii)*exp(-lemda);
    end
end

