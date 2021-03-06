%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%
% Estimating velocity motion model through linear regression
% K-fold cross-validation
% 
% Input:    k: the number of folds for cross-validation
% Output:   the cell array 'par'
%
% Author: Jianyu Zhao
% Last revised: 12.06.2016
%
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function par = Exercise1(k)

load('Data.mat');

n = size(Input,2);
PosErr = zeros(1,6);
OrtErr = zeros(1,6);

% loop for k-fold validation
for K=1:k
    % determine the training set
    trin = Input; trout = Output;
    trin(:,1+(K-1)*(n/k):K*(n/k)) = [];% discard the testing part
    trout(:,1+(K-1)*(n/k):K*(n/k)) = [];
    trin = trin';
    trout = trout';
    trin = [trin trin(:,1).*trin(:,2)];% initialization step
    
    %determine the testing set
    testin_org = Input(:,1+(K-1)*(n/k):K*(n/k))';
    testin_org = [testin_org testin_org(:,1).*testin_org(:,2)];
    x = Output(1,1+(K-1)*(n/k):K*(n/k))';
    y = Output(2,1+(K-1)*(n/k):K*(n/k))';
    theta = Output(3,1+(K-1)*(n/k):K*(n/k))';

    for p1=1:6
        % training: parameter extraction
        trin1 = ones(n-n/k,1);
        for i=1:p1
            trin1 = [trin1 trin.^i];
        end
        ax = (trin1'*trin1)^(-1)*(trin1)'*trout(:,1);
        ay = (trin1'*trin1)^(-1)*(trin1)'*trout(:,2);
        
        % testing: error calculation
        testin1 = ones(n/k,1); 
        for i=1:p1
            testin1 = [testin1 testin_org.^i];
        end
        err_pos = (k/n) * sqrt((x-testin1*ax)'*(x-testin1*ax)...
                  +(y-testin1*ay)'*(y-testin1*ay)); 
        % summation of errors
        fprintf('p1: %d, error: %f\n', p1, err_pos)
        PosErr(p1) = PosErr(p1) + err_pos;
    end
    
    for p2=1:6
        % training: parrameter extraction
        trin2 = ones(n-n/k,1);
        for j=1:p2
            trin2 = [trin2 trin.^j];
        end
        atheta = (trin2'*trin2)^(-1)*(trin2)'*trout(:,3);    
 
        % testing: error calculation
        testin2 = ones(n/k,1); 
        for j=1:p2
            testin2 = [testin2 testin_org.^j];
        end                 
        err_ort = (k/n) * sqrt((theta-testin2*atheta)'...
                  *(theta-testin2*atheta));  
              
        % summation of errors
        fprintf('p2: %d, error: %f\n', p2, err_ort)
        OrtErr(p2) = OrtErr(p2) + err_ort;
    end
end
    
% find the smallest error and its corresponding complexity
[mPosErr,fp1] = min(PosErr)
[mOrtErr,fp2] = min(OrtErr)

% reestimation
par = cell(1,3);

p1 = fp1;
p2 = fp2;
trin = Input'; trout = Output';
trin = [trin trin(:,1).*trin(:,2)];% initialization step

trin1 = ones(n,1);
for i=1:p1
    trin1 = [trin1 trin.^i];
end
par{1} = (trin1'*trin1)^(-1)*(trin1)'*trout(:,1);
par{2} = (trin1'*trin1)^(-1)*(trin1)'*trout(:,2);

trin2 = ones(n,1);
for j=1:p2
    trin2 = [trin2 trin.^j];
end
par{3} = (trin2'*trin2)^(-1)*(trin2)'*trout(:,3);    

end