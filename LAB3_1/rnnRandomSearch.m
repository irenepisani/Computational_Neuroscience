%% UNIVERSITY OF PISA

% Computer Science Department
% M.Sc. Computer Science, Artificial Intelligence

%% AUTHOR: IRENE PISANI

% email: i.pisani1@studenti.unipi.it
% matricola: 560104
% date: August 23

%% COMPUTATIONAL NEUROSCIENCE 22/23 - LABORATORY 3.1

% [ COMPLETED ] Assignment 1: NARMA10 task
% [ No ] Bonus-track Assignment 1: Mackey-Glass 17 task
% [ No ] Bonus-Track Assignment 2: Sequential MNIST classification task
% [ No ] Bonus-Track Assignment 3: BackPropagation Through-Time algorithm from scratch
% [ No ] Bonus Track Assignment 4: benchmarking RNN models on the sequential MNIST task
% [ No ] Bonus-Track Assignment 5: Char RNN, or "The Unreasonable Effectiveness of Recurrent Neural Networks”

%%  ASSIGNMENT 1: NARMA10 task - TDNN and RNN

% This task consists in predicting the output of a 10-th order non-linear
% autoregressive moving average (NARMA) system using both  TDNN and RNN
% architectures.

% For solving this assignment with TDNN and RNN run the main scripts:
    % tdnnMain() 
    % rnnMain()

%% Function for TDNN model selection with random search over RNN hyperparamters space

% rnnRandomSearch()
    
    % PARAMETERS
        % trX : Training input features 
        % trY : Training targets
        % vlX : Validation input features
        % vlY : Validation targets
        % numTrials : (int) Num. of hyperparameter configuration to try
    
    % DESCRIPTION
        % Use this function to execute RNN model selection with Random
        % Search over hyper-parameter space. The best hyper-parameter
        % config allow to reach the lowest VL error.
     
    % OUTPUT 
        % optParams : (struct) Optimal configuration of hyper-parameters
        % found during model selectopn
        % optVL : (float) VL error achieved with optimal hyper-parameters
        % optTR : (floar) TR error achieved with optimal hyper-parameters

% -------------------------------------------------------------------------

function [optParams, optVL, optTR] = rnnRandomSearch(trX, trY, vlX, vlY, numTrials)

optParams = nan; % optimal configuration of hyperparameter values

optVL = Inf; % optimal error (MSE) achieved on VL set
optTR = Inf; % TR error (MSE) associated with optimal VL error

% iterate over max. number of configurations to try 
for i = 1: numTrials
   
    % get a single random configurations
    params = rnnRandomConfig();

    % train a RNN using TR set with that configuration and evaluate the
    % model on VL set
    [~, errTR,~, errVL, ~, ~] = rnn(params, trX, trY, vlX, vlY);
    
     % check if the VL error is the lowest so far
    if errVL < optVL
        
        % Update optimal achieved VL and TR error
        optVL = errVL;
        optTR = errTR;

        % Update optimal hyperparameters config.
        optParams = params;
    end

end


end