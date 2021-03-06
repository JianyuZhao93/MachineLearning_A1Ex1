
clear all; close all; clc;

load('Data.mat');

% calculate the errors for given model complexity
for i=1:6
    for j=1:6
        for K=1:k % loop for k folds
            %% Training for parameters
            % determine the training set
            trin = Input; trout = Output;
            trin(:,1+(K-1)*(n/k):K*(n/k)) = [];% discard the testing part
            trout(:,1+(K-1)*(n/k):K*(n/k)) = [];
            trin = trin';
            trout = trout';
            trin = [trin trin(:,1).*trin(:,2)];% initialization step
            
            % parameter extraction
            trin1 = ones(n-n/k,1);
            for l=1:i
                trin1 = [trin1 trin.^l];
            end
            ax = (trin1'*trin1)^(-1)*(trin1)'*trout(:,1);
            ay = (trin1'*trin1)^(-1)*(trin1)'*trout(:,2);
            
            trin2 = ones(n-n/k,1);
            for m=1:j
                trin2 = [trin2 trin.^m];
            end
            atheta = (trin2'*trin2)^(-1)*(trin2)'*trout(:,3);
            
            %% Testing, validation
            %determine the testing set
            testin_org = Input(:,1+(K-1)*(n/k):K*(n/k))';
            testin_org = [testin_org testin_org(:,1).*testin_org(:,2)];
            x = Output(1,1+(K-1)*(n/k):K*(n/k))';
            y = Output(2,1+(K-1)*(n/k):K*(n/k))';
            theta = Output(3,1+(K-1)*(n/k):K*(n/k))';
            
            % error calculation
            testin1 = ones(n/k,1); 
            for l=1:i
                testin1 = [testin1 testin_org.^l];
            end
            err_pos = (k/n) * sqrt((x-testin1*ax)'*(x-testin1*ax)...
                      +(y-testin1*ay)'*(y-testin1*ay));
                  
            testin2 = ones(n/k,1); 
            for m=1:j
                testin2 = [testin2 testin_org.^m];
            end                 
            err_ort = (k/n) * sqrt((theta-testin2*atheta)'...
                      *(theta-testin2*atheta));                 
        end
        Errors(i,j,1) = Errors(i,j,1) + err_pos;
        Errors(i,j,2) = Errors(i,j,2) + err_ort;
    end