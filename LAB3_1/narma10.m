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

%% Function to load and split NARMA10 dataset
% narma10()
    
    % PARAMETERS
        % No parameters are required
    
    % DESCRIPTION
        % Load the narma 10 dataset from the corresponding csv file and
        % split the dataset in TR, VL and TS set:
            % TR: 4000 samples
            % VL: 1000 samples
            %TS: all the remaining sample

    % OUTPUT 
        % trainData : TR input features
        % trainTargets : TR targets
        % validData : VL input features
        % validTargets : VL targets
        % testData : TS input features
        % testTargets : TS targets

% -------------------------------------------------------------------------

function [trainData, trainTargets, validData, validTargets, testData, testTargets] = narma10()

% Load Narma10 dataset in csv format as matrix
datasetNarma10 = readmatrix(fullfile("Dataset", "NARMA10.csv"));

% Get feature and target
data = datasetNarma10(1, :);
targets = datasetNarma10(2, :);

% TR set: 4000 samples
trainLength = 4000;
trainData = data(1:trainLength);
trainTargets = targets(1:trainLength);

% VL set: 1000 samples
validLength = 5000;
validData = data(trainLength+1:validLength);
validTargets = targets(trainLength+1:validLength);

% TS set: remaining samples
testData = data(validLength+1:end);
testTargets = targets(validLength+1:end);

end

