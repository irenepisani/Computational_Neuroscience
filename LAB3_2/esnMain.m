
%% Main script 

% load TR/VL/TS dataset 
[trX, trY, vlX, vlY, tsX, tsY] = narma10();

% Num. configurations to try in RGS 
numTrials = 20;

% Number of reservoir guesses
numGuesses= 5;

% Run Randomized Grid Search 
[vlMSE, trMSE, bestParam]  = esnRandomizedGridSearch( ...
    trX, trY, vlX, vlY, numTrials, numGuesses);
bestParam

devX = [trX, vlX];
devY = [trY, vlY];

devMSE = zeros(1, numGuesses);
tsMSE = zeros(1, numGuesses);

for j = 1: numGuesses
    
    % Initialize the ESN
    esn = EchoStateNetwork(bestParam, 1, 100);
    
    esn = esn.trainReadout(devX, devY);
    [devMSE(j), trainState] = esn.evaluate(devX, devY, nan);
    [tsMSE(j), ~] = esn.evaluate(tsX, tsY, trainState);
end

performance.trMSE = trMSE;
performance.vlMSE = vlMSE;
performance.devMSE = mean(devMSE);
performance.testMSE = mean(tsMSE);

performance