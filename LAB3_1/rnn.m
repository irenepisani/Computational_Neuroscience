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

%% Function for training and evaluate RNN model
% rnn()
    
    % PARAMETERS
        % params : (struct) a configuration of hyper-parameters values
        % trainX : TR set input features
        % trainY : TR set targets
        % evalX : Evaluation set (VL or TS) input features
        % evalY : Evaluation set (VL or TS) targets

    
    % DESCRIPTION
        % Iinitialize a RNN exploiting matlab timedelaynet library, train
        % the network wih the given TR set, and evaluate the network on the
        % given evaluation dataset (VL or TS). 
        

    % OUTPUT 
        % predTR : predictions on TR set
        % errTR  : MSE between TR targets and TR predictions
        % predEV : predictions on Evaluation (TS or VL) set 
        % errEV  :  MSE between TR targets and TR predictions
        % structure : network variables after training 
        % records   : training informations

% -------------------------------------------------------------------------

function [predTR, errTR, predEV, errEV, rnn, records] = rnn(params, trainX, trainY, evalX, evalY)

% RNN  initialization 
rnn = layrecnet(params.layerDelay, params.hiddenSize, params.trFunc);

rnn.trainFcn = params.trFunc;                  % Optimizer 
rnn.trainParam.lr = params.lr;                 % Learning rate
rnn.trainParam.mc = params.momentum;           % Momentum
rnn.trainParam.epochs = params.epochs;         % Num. of epochs
rnn.performParam.regularization = params.reg;  % Weight decay

rnn.divideFcn = "dividetrain"; % Use the provided data split for training 

% Prepare TR set for being fee to rnn model
[xsTR, xiTR, aiTR, tsTR, ~, ~] = preparets(rnn, num2cell(trainX), num2cell(trainY));

% Prepare evaluation set ( TS or VL)
[xsEV, xiEV, aiEV, tsEV, ~, ~] = preparets(rnn, num2cell(evalX), num2cell(evalY));

% Train RNN
[rnn, records] = train(rnn, xsTR, tsTR, xiTR, aiTR);

% make prediction and evaluate model on TR Set
predTR = rnn(xsTR, xiTR, aiTR);
errTR = immse(cell2mat(predTR), cell2mat(tsTR));

% make prediction on  unseen evaluation data (TS or VL) and evaluate model
% on these new evaluation data
predEV = rnn(xsEV, xiEV, aiEV);
errEV  = immse(cell2mat(predEV), cell2mat(tsEV));

end