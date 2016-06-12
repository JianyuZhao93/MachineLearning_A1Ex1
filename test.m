
clear all; close all; clc;

load('Data.mat');

i = 6;
j = 6;

% determine the training set
trin = Input; 
trout = Output;

n = size(Input,2);

trin = trin';
trout = trout';
trin = [trin trin(:,1).*trin(:,2)];
            
% parameter extraction
%para = LinearRegression(trin,trout,i,j);
trin1 = ones(n,1);
for l=1:i
    trin1 = [trin1 trin.^l];
end
ax = (trin1'*trin1)^(-1)*(trin1)'*trout(:,1);
ay = (trin1'*trin1)^(-1)*(trin1)'*trout(:,2);

trin2 = ones(n,1);
for m=1:j
    trin2 = [trin2 trin.^m];
end

atheta = (trin2'*trin2)^(-1)*(trin2)'*trout(:,3);
