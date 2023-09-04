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

%% Function to produce the required plots
% narma10()
    
    % PARAMETERS
        % model : (str) model name es. "tdnn"
        % modelRecords : training records information returned after
        % training a NN with matlab nntraintool
        % predsTR  : model prediction on TR set
        % targetTR : TR set targets
        % predsTS  : model prediction on TS set
        % targetTS : TS set targets
    
    % DESCRIPTION
        % Generate and save the 3 plots required as assignment's result

    % OUTPUT 
        % 1) a plot of training Learning curve
        % 2) a plot of TR target signal vs TR output signal
        % 3) a plot of TS target signal vs TS output signal

% -------------------------------------------------------------------------

function narma10Plot (model, modelRecords, predsTR, targetTR, predsTS, targetTS)

%%%%% 1° plot : Training Learning curve

plot1 = figure;
plot(modelRecords.perf)
title(model+" learning curve on development set (TR + VL)")
xlabel("Epochs")
ylabel("MSE")
saveas(plot1, fullfile("Results", model+"-TR-learning-curve"), 'jpg')

%%%%% 2° plot : TR target signal vs TR output signal

plot2 = figure;
plot(cell2mat(predsTR))
hold on
plot(targetTR)
hold off,
title(model + " Development set: output signal vs. target signal")
legend("Output", "Targets")
xlabel("Time steps")
ylabel("Time serie value")
saveas(plot2,  fullfile("Results", model+"-TR-target-output"), 'jpg')

%%%%% 3° plot : TS target signal vs TS output signal
plot3 = figure;
plot(cell2mat(predsTS))
hold on
plot(targetTS)
hold off,
title(model + " Test set: output signal vs. target signal")
legend("Output", "Targets")
xlabel("Time steps")
ylabel("Time serie value")
saveas(plot3, fullfile("Results", model+"-TS-target-output"), 'jpg')

end

