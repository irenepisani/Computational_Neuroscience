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

%% Define ESN's hyperparamter space to explore in model selction

% rnnRandomSearch()
    
    % PARAMETERS
        % No parameters required.
    
    % DESCRIPTION
        % Use this function to define range of hyperparameter value you
        % want to explore in model selection.
     
    % OUTPUT 
        % hyperParamss : (struct) a configuration of hyperparamters values
            % Nh : hidden dimension
            % rho : hyperparam for adjusting spectral radius
            % omega : input and bias scaling factor
            % lambda: ridge regression coefficient 

% -------------------------------------------------------------------------

function [hyperParams] = esnRandomConfig()

% Get a random configuration of hyperparameters

hyperParams = struct();

hyperParams.Nh = randi([50, 200]); % Nh    : (int)  in [5, 100]
hyperParams.rho = rand;           % rho   : (float) in [0, 1]
hyperParams.omega = rand;         % omega : (float) in [0, 1]
hyperParams.lambda = 0.0001 * rand;  % lambda: (float) in [0, 0.1]

end