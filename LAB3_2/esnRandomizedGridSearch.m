
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
        [trainError, ~] = esn.evaluate(trainX, trainY, nan);
        [validError, ~] = esn.evaluate(valX, valY, trainState);
        
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

    % save in a file best params

end


