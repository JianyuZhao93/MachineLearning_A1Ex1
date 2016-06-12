%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%
% Estimating velocity motion model through linear regression
% K-fold cross-validation
% 
% Main document
%
% Author: Jianyu Zhao
% Last revised: 11.06.2016
%
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

load('Data.mat');
par = LinearRegression(Input,Output,1,1);
