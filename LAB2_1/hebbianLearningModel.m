%% UNIVERSITY OF PISA
% Computer Science Department
% M.Sc. Computer Science, Artificial Intelligence

%% AUTHOR: IRENE PISANI
% email: i.pisani1@studenti.unipi.it matricola: 560104
% date: August 23

%% COMPUTATIONAL NEUROSCIENCE 22/23 - LABORATORY 2.1

% [ COMPLETED ] Assignment 1: Basic Hebbian Learning
% [ COMPLETED ] Assignment 2: Oja rule
% [ COMPLETED ] Assignment 3: Subtractive Normalization
% [ No ] Bonus Track Assignment 1 – BCM Rule
% [ No ] Bonus Track Assignment 2 – Covariance Rule
% [ No ] Bonus Track Assignment 3 – Dataset #2

%% Assignment 1-2-3: Basic Hebbian Learning, Oja rule, Subtractive Normalization

% For solving this assignment run the main script:
    % LearningRuleMain()

%% Function for performing learning with different learning rule and a firing rate model 

% hebbianLearningModel()
    % PARAMETER:
        % - dataset: (matrix)input patterns for performing learing 
        % - param:
            % param.maxIteration: (int) maximum number of iterations
            % param.stopThreshold: (float) threshold value for stopping criteria
            % param.learningRate: (float) learning rate value
            % param.alphaOja: (float) alpha value (just for Oja rule) 
        % - rule: (string)  type of learning rule (e.g. basic Hebb, Oja, or
        % Subtractive Normalization learning rule).
    % DESCRIPTION: Feed the dataset to a linear firing rate model (u = w +
    % u) and adapt the weight using the specified learning rule. Iterate
    % over epoch and stop learning only if the norm  of the difference
    % between w_new and w_old is lower than a given threshold. 
    % OUTPUT:
        % - weight: (vector) final weight vector obtained after learning 
        % - weightHistory: (matrix) history of weight evolution
        % during learning


        function [weight, weightHistory] = hebbianLearningModel(dataset, param, rule)

% randomly initialize weights from a uniform distribution over [-1,1]
a = 1; b = -1; weight = (b - a).*rand(2,1) + a;

% initialize array and var useuful for storing weighth evolution
k = 1; weightHistory = NaN(2, param.maxIteration * length(dataset));

% initialize previous weights
weightPrev = nan;

% iterate over epochs
for i = 1 : param.maxIteration
    
    % Shuffle the input dataset
    datasetShuffled = randperm(length(dataset));
    
    % iterate over patterns of the dataset
    for j = datasetShuffled

        % present the pattern and compute the output --> firing rate model
        % v = w * u
        out  = weight'*dataset (:, j);

        if rule == "hebb" 
            % apply the Hebb learning rule   
            weight = weight + param.learningRate * (out * dataset(:,j));
        
        elseif rule == "oja"
            % apply the Oja learning rule 
            weight = weight + param.learningRate * (out * dataset(:, j) - param.alphaOja * out^2 * weight);
        
        else
            % apply the Subtractive Normalization learning rule 
            weight = weight + param.learningRate * (out * dataset(:, j) - (out * (ones(1,2)*dataset(:, j)) * ones(2,1))/2);
        end
        
        % update array of weight's evolution history
        weightHistory(:, k) = weight; 
        k = k+1;

    end
    
    % Stopping criteria 
    if i > 1 && norm(weight - weightPrev) <= param.stopThreshold
        break
    end
    
    % update previous weights
    weightPrev = weight;

end
end

