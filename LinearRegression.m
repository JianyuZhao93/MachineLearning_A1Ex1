%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%
% Estimating velocity motion model through linear regression
% Linear regression
% 
% Input:    input data 'in', output data 'out', orders of the polynomial 
%           regression 'p1' and 'p2'
% Output:   learned parameters in a cell array 'paras'
%
% Author: Jianyu Zhao
% Last revised: 12.06.2016
%
%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function paras = LinearRegression (inorg,out,p1,p2)

% preprocessing
inorg = inorg'; 
in = [inorg inorg(:,1).*inorg(:,2)]; 
out = out';
p = [p1 p1 p2];

% create a cell array to save the learned values
paras = cell(1,3);

% calculate the size of parameter columns
sz = [3*p1+1 3*p1+1 3*p2+1];

% size of exemplar
n = size(in,1);

%% iteration of the parameters
for col=1:3
    fprintf('For the %d column of the parameter:\n', col)
    
    % initialization
    j = 0;
    alpha = 0.1;
    converged = 0;
    x = out(:,col);
    wj = zeros(sz(col),1);

    % add intercept variable and form the input for different pose coordinates
    in_p = ones(n,1); 
    for i=1:p(col)
        in_p = [in_p in.^i];
    end
    
    while ~converged
        % compute next iteration
        wj_pre = wj;
        wj = wj - 2*alpha*in_p'*(in_p*wj - x)*(1/n);
        j = j+1;
        fprintf('Iteration: %d, error: %f\n', j, norm(in_p*wj - x))

        % iteration boundary
        if norm(wj-wj_pre,'fro') < 1e-6
            converged = 1;
            fprintf('Final error: %f\n\n', norm(in_p*wj - x))
        elseif isnan(norm(in_p*wj-x))
            break
        end
    end
    
    paras{col} = wj; 
end
end