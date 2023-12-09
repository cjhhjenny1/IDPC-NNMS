clear all; close all; clc;

fileName = 'flame.txt';
X = load(fileName);
T = X(:,end);                                  
X(:,end) = [];                                 
%% 
X = Normalize(X);                                                     
[dist] = Dist(X);                                                        
[lemda,nnb,fnn] = NNSearch(X);                                          
[rho] = Rho(dist,fnn,lemda);                                               
[delta,nneigh] = Delta(rho,dist);                                           
isManualSelect=1;
[numClust,centInd,center] = decisionGraph(rho, delta, isManualSelect);       
[cl] = initalCluster(rho,centInd,nneigh,numClust);                             
[numClust,center,labels] = Merging(lemda,numClust,rho,nnb,fnn,dist,cl,center); 
Plot(X,labels);