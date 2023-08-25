function [trainData, trainTargets, validData, validTargets, testData, testTargets] = narma10()

% read Narma 10 Dataset in csv format as matrix

filename = "NARMA10.csv";
datasetNarma10 = readmatrix(filename);

data = datasetNarma10(1, :);
targets = datasetNarma10(2, :);

% Split dataset in TR/VL/TS

trainLength = 4000;
validLength = 5000;

trainData = data(1:trainLength);
trainTargets = targets(1:trainLength);

validData = data(trainLength+1:validLength);
validTargets = targets(trainLength+1:validLength);

testData = data(validLength+1:end);
testTargets = targets(validLength+1:end);

end

