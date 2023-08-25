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

%% Function to generate a random configuration of RNN's hyper-paramter values

% rnnRandomConfig()
    
    % PARAMETERS
        % No parameters are required
    
    % DESCRIPTION
        % Generate a random configuration for each considered hyper-params:
            % lr  : (float) learning rate in [0,1]
            % reg : (float) Tikhonov regularization coefficent in [0, 0.1]
            % momentum : (float) momentum coefficent in [0,1]
            % epochs : (int) max number of epochs is fixed to 1000
            % inputDelay : (int) max increasing 0 or positive delays in [0, 20]
            % hiddenSize : [0, 30] num of hidden layers with dimension in [0, 20]
            % trFunc : (str) optimizer
                % traingd : gradient descent
                % traingdm : gradient descent with momentum
                % traingdx : gradient descent with momentum and adaptive lr
                % trainrp : rprop
                % trainlm : Levenberg-Marquardt optimization

    % OUTPUT 
        % hyperParams : (struct) every hyperparameter is associated with a
        % random values sampled for a given range. 

% -------------------------------------------------------------------------
function [hyperParams] = rnnRandomConfig()

trFunc = ["traingd", "traingdm", "traingdx", "trainrp", "trainlm"];
hyperParams = struct();

hyperParams.lr = rand;
hyperParams.reg = rand;
hyperParams.momentum = rand;
hyperParams.epochs = 1000;
hyperParams.layerDelay = randi(20);
hyperParams.hiddenSize = randi(20, [1, randi(10)]);
hyperParams.trFunc  = trFunc(randi(length(trFunc)));

end