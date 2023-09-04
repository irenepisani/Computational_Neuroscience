%% UNIVERSITY OF PISA
% Computer Science Department
% M.Sc. Computer Science, Artificial Intelligence

%% AUTHOR: IRENE PISANI
% email: i.pisani1@studenti.unipi.it
% matricola: 560104
% date: September 23

%% COMPUTATIONAL NEUROSCIENCE 22/23 - LABORATORY 2.1

% [ COMPLETED ] Assignment 1: Basic Hebbian Learning
% [ COMPLETED ] Assignment 2: Oja rule
% [ COMPLETED ] Assignment 3: Subtractive Normalization
% [ No ] Bonus Track Assignment 1 – BCM Rule
% [ No ] Bonus Track Assignment 2 – Covariance Rule
% [ No ] Bonus Track Assignment 3 – Dataset #2

%% Assignment 1-2-3: Basic Hebbian Learning, Oja rule, Subtractive Normalization

% For solving these assignments run the main script:
    % hebbianLearningMain()
        % PARAMETERS: No input parameter are required. 
        % DESCRIPTION: Consider different learning rule, feed the dataset
        % to a firing rate model and adapt its weight using the given
        % learning rule using hebbianLearningModel(). After training show
        % information abbout the final weight and the evolution of the
        % weights during training.
        % OUTPUT: 
        % for each considered learning rule, return in output
            % - a matrix containing the weight evolution during training
            % - all the figures returned by hebbianLearningPlot()

% Other scripts or functions exploited in this assignments are:
    % hebbianLearningModel()
    % hebbianLearningPlot()

%% Main Script for solving assignment 1-2-3

% Load Dataset
dataset = readmatrix("lab2_1_data.csv");

% Define hyper-parameter values
% these values has been fixed a priori (no grid search)
params.maxIteration = 50;
params.stopThreshold = 0.00001;
params.learningRate = 0.001;
params.alphaOja = 0.001;

%%%%%%% (1) Learning with Hebb rule

% perform learning phase
[weight, weightHistory] = hebbianLearningModel(dataset, params, "hebb");

% save matrix of weight vector evolution after each update
save('Results/weightHistory_Hebb.mat', "weightHistory");

% generate the required figure
hebbianLearningPlot(dataset, weight, weightHistory, "hebb");

%%%%%%% (2) Learning with Oja rule

% perform learning phase
[weight, weightHistory] = hebbianLearningModel(dataset, params, "oja");

% save matrix of weight vector evolution after each update
save('Results/weightHistory_Oja.mat',"weightHistory");

% generate the required figure
hebbianLearningPlot(dataset, weight, weightHistory, "oja");

%%%%%%% (3) Learning with Subtractive Normalization rule 

% perform learning phase
[weight, weightHistory] = hebbianLearningModel(dataset, params, "sub");

% save matrix of weight vector evolution after each update
save('Results/weightHistory_SubNorm.mat',"weightHistory");

% generate the required figure
hebbianLearningPlot(dataset, weight, weightHistory, "sub");
