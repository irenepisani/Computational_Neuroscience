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
    
%% Function to produce the required plots
% narma10()
    
    % PARAMETERS
        % predsTR  : model prediction on TR set
        % targetTR : TR set targets
        % predsTS  : model prediction on TS set
        % targetTS : TS set targets
    
    % DESCRIPTION
        % Generate and save the 3 plots required as assignment's result

    % OUTPUT 
        % 2) a plot of TR target signal vs TR output signal
        % 3) a plot of TS target signal vs TS output signal

% -------------------------------------------------------------------------

function narma10Plot (predsTR, targetTR, predsTS, targetTS)

%%%%% 1° plot : TR target signal vs TR output signal

plot2 = figure;
plot(predsTR)
hold on
plot(targetTR)
hold off,
title("ESN - Development set: output signal vs. target signal")
legend("Output", "Targets")
xlabel("Time steps")
ylabel("Time serie value")
saveas(plot2,  fullfile("Results", "ESN-TR-target-output"), 'jpg')

%%%%% 2° plot : TS target signal vs TS output signal
plot3 = figure;
plot(predsTS)
hold on
plot(targetTS)
hold off,
title("ESN - Test set: output signal vs. target signal")
legend("Output", "Targets")
xlabel("Time steps")
ylabel("Time serie value")
saveas(plot3, fullfile("Results", "ESN-TS-target-output"), 'jpg')

end

