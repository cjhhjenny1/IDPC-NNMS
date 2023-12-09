function  Plot(A,labels)
%% 可视化聚类结果
NC=length(unique(labels));
figure;
% colormap jet
% cmap=colormap;
% cmap=cmap(round(linspace(1,length(cmap),NC+1)),:);
% cmap=cmap(1:end-1,:);
colormap hsv
cmap=colormap;
cmap=cmap(round(linspace(1,length(cmap),NC+1)),:);
cmap=cmap(1:end-1,:)*0.5+0.4;
for i=1:NC
    plot(A(labels == i,1), A(labels == i,2),'.','Markersize',18,'color',cmap(i,:));
    hold on;
end
xlabel('');
ylabel('');
title('');
% figure;
% for i=1:NC
%     plot(A(A(:,end) == i,1), A(A(:,end) == i,2),'.','Markersize',18,'color',cmap(i,:));
%     hold on;
% end
% title('real');
end

