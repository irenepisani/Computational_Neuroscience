%% UNIVERSITY OF PISA

% Computer Science Department
% M.Sc. Computer Science, Artificial Intelligence

%% AUTHOR: IRENE PISANI

% email: i.pisani1@studenti.unipi.it
% matricola: 560104
% date: August 23

%% COMPUTATIONAL NEUROSCIENCE 22/23 - LABORATORY 3.2

% [ COMPLETED ] Assignment 1: NARMA10 task
% [ No ] Bonus-track Assignment 1: Mackey-Glass 17 task
% [ No ] Bonus-Track Assignment 2: Custom Python implementation
% [ No ] Bonus-Track Assignment 3: Sequential MNIST classification task


%%  ASSIGNMENT 1: NARMA10 task - TDNN and RNN

% This task consists in predicting the output of a 10-th order non-linear
% autoregressive moving average (NARMA) system using ESN

% For solving this assignment run the main scripts:
    % esnMain()

%% Function for execute model selection with random search over ESN hyperparameter space 

% rnnRandomSearch()
    
    % PARAMETERS
        % trainX : Training input features 
        % trainY : Training targets
        % valX : Validation input features
        % valY : Validation targets
        % numTrials : (int) Num. of hyperparameter configuration to try
        % numGuesses: (int) Num. of reservoir initialization to try 
    
    % DESCRIPTION
        % Use this function to execute ESNN model selection with Random
        % Search over hyper-parameter space. The best hyper-parameter
        % config allow to reach the lowest VL error.
     
    % OUTPUT 
        % optVL : (float) VL error achieved with optimal hyper-parameters
        % optTR : (floar) TR error achieved with optimal hyper-parameters
        % optParams : (struct) Optimal configuration of hyper-parameters
        % found during model selectopn

% -------------------------------------------------------------------------

function [optVL, optTR, optParams] = esnRandomizedGridSearch(trainX, trainY, valX, valY, numTrials, numGuesses)

optParams = nan; % optimal configuration of hyperparameter values

optVL = Inf; % optimal error (MSE) achieved on VL set
optTR = Inf; % TR error (MSE) associated with optimal VL error

% input dimension is equal to 1 : X is a timeserie
inputDim = size(trainX, 1);

transient = 100;

% iterate of different configuration of hyperparameters
for i = 1 : numTrials
    
    % get a single random configurations
    params = esnRandomConfig();
    
    % store TR and VL error for each reservoir guesses
    errTR = zeros(1, numGuesses);
    errVL = zeros(1, numGuesses);

    for j = 1: numGuesses

        % Initialize the ESN
        esn = EchoStateNetwork(params, inputDim, transient);
        
        esn = esn.trainReadout(trainX, trainY);
        [~, trainState] = esn.predict(trainX, nan);
        [trainError, ~, ~] = esn.evaluate(trainX, trainY, nan);
        [validError, ~, ~] = esn.evaluate(valX, valY, trainState);
        
        % update the list of MSE on TR and VL set achieved with different
        % reservoir initialization
        errTR(j) = trainError;
        errVL(j) = validError;
        
    end
    
    % Get mean error value among different reservoirs guesses
    errVL = mean(errVL);
    errTR = mean(errTR);
    
    % check if the VL error is the lowest so far
    if errVL < optVL
        
        % Update optimal achieved VL and TR error
        optVL = errVL;
        optTR = errTR;

        % Update optimal hyperparameters config.
        optParams = params;

    end

end


