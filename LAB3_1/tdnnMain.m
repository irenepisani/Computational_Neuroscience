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
  
%% Main Script for Time Delay Neural Network (TDNN)

% Load NARMA10 dataset splitted in TR/VL/TS
[trX, trY, vlX, vlY, tsX, tsY] = narma10();

% Define num. of configuration of hyper-parameters values to try in Random
% Grid Search
numTrials = 20;

% Run Model selection with Randomized Grid Search to obtain the optimal
% configuration of hyper-parameters values and the VL and TR error obtained
% with the optimal configuration
[bestParams, errVL, errTR] = tdnnRandomSearch(trX, trY, vlX, vlY, numTrials);

% a development set (TR + VL) for final retraining
devX = [trX, vlX];
devY = [trY, vlY];

% Retrain the model on development set (TR + VL) with the optimal
% hyperparameter values and evaluate the final model performance on TS set. 
[predDEV, errDEV, predTS, errTS, structure, records] = tdnn(bestParams,devX, devY, tsX, tsY);
view(structure)

% save performances
performance.errTR = errTR;
performance.errVL = errVL;
performance.errDEV = errDEV;
performance.errTS = errTS;

%% Store results 

% Save model variable & the training information
save(fullfile('Results', 'TDNN-structure.mat'),'structure');
save(fullfile('Results', 'TDNN-records.mat'), 'records');

% Save optimal hyper-parameters configurations (not mandatory) 
save(fullfile('Results', 'TDNN-optimal-hyperparam.mat'), 'bestParams')

% save training, validation, development (tr + vl) and test Mean Squared Error
save(fullfile('Results', 'TDNN-mse.mat'), 'performance')

% Generate and save plots 
snarma10Plot("TDNN", records, predDEV, devY, predTS, tsY)
