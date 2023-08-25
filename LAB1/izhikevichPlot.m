%% UNIVERSITY OF PISA
% Computer Science Department
% M.Sc. Computer Science, Artificial Intelligence

%% AUTHOR: IRENE PISANI
% email: i.pisani1@studenti.unipi.it
% matricola: 560104
% date: August 23

%% COMPUTATIONAL NEUROSCIENCE 22/23 - LABORATORY 1

% [ COMPLETED ] Assignment: Implementation of the Izhikevich model
% [ No ] Bonus Track Assignment: In-depth analysis of particular cases
% [ No ] Bonus Track Assignment: Liquid state machine

%% Assignment: Implementation of the Izhikevich model

% For solving this assignment run the main script:
    % izhikevichMain()
        % PARAMETERS: No input parameter are required. 
        % DESCRIPTION: Obtain the 20 neuro-computational features of 
        % biological neurons using the Izhikevich model. 
        % OUTPUT: Figure showing the membrane potential's time course and
        % phase portraits of each neuro-computational features.

% Other scripts or functions exploited in this assignments are:
    % izhikevichParams()
    % izhikevichModel()
    % izhikevichPlot()

%% Function for plotting neuro-computation feature's characteristics

% izhikevichPlot()
    % PARAMETER:
        % - params: hyperparameter values for a single neuro-computational
                    % features.
        % - vHistory: membrane potential values over time
        % - uHistory: recovery variable over time
    % DESCRIPTION: Consider a single neuro-computational features, given
    % its hyper-parameters values and values of membrane potential e
    % erecovery variable over time, plot salient carateristcih
    % for visualizing the particular neuron's behaviour (i.e. phase
    % portraits and memebrane potential time course).
    % OUTPUT: 2 figure for each neurocomputatioal features one representing
    % the membrane potential time course and one representing the phase
    % portraits. 

function izhikevichPlot(params, vHistory, uHistory)

% 1° sub-plot: membrane potential time course 
subplot(2,2,1) 
plot(params.tauSpan, vHistory);
xlabel("Time (t)")
ylabel("Membrane potential (u)")
title("Membrane potential time course")

% 2° sub-plot: phase portraits
subplot(2,2,2) 
plot(vHistory,uHistory);
xlabel("Membrane potential (u)")
ylabel("Recovery variable (v)")
title("Phase portrait")

% set image title and save figure
sgtitle(params.title(1))
saveas(gcf, 'images/'+params.title(2))

end