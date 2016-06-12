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


for i=1:6
    for j=1:6
        par = LinearRegression(Input,Output,i,j);
    end
end

end