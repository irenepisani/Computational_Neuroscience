%% UNIVERSITY OF PISA
% Computer Science Department
% M.Sc. Computer Science, Artificial Intelligence

%% AUTHOR: IRENE PISANI
% email: i.pisani1@studenti.unipi.it
% matricola: 560104
% date: September 23

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

%% Function for implementing Izhikevich Model

% izhikevichModel()
    % PARAMETER:
        % - params: hyperparameter values for a single neuro-computational
        % features.
    % DESCRIPTION: Implementation of Izhikevich model throughtout the using
    % of its fundamental equations. The whole system is simuluted
    % exploiting the Leap Frog method for solving system of differential
    % equations. 
    % OUTPUT: History of membrane potential values (v)  over time and history of
    % recovery variable (u) over time. 


function [vHistory, uHistory] = izhikevichModel(params)

% Initialize a zero-sequence for storing values of v and u over time 
vHistory = zeros(1, length(params.inputHistory));
uHistory = zeros(1, length(params.inputHistory));

% Initial values of u and v 
v = params.varInit(1);
u = params.varInit(2);

% Get parameter values
a = params.abcd(1);
b = params.abcd(2);
c = params.abcd(3);
d = params.abcd(4);

% Get coefficient values
coef = params.coef;

% Iterate over length of the current applied in input to the neuron
for t = 1:length(params.inputHistory)

    % get input strenght/value at timestep t 
    i = params.inputHistory(t);

    % Izhikevich differential equation solved with Leap-Frog method 
    dvdt = (0.04 * v^2 + coef(1) * v + coef(2) - u + i);
    v = v + params.tauStep * dvdt;
    dudt = a * (b * v - coef(3) * u + coef(4));
    u = u + params.tauStep * dudt;
    
    % reset condition and store values of u and v at timestep t
    if v > 30
        vHistory(t) = 30;
        v = c;
        u = u + d;
    else
        vHistory(t) = v;
    end
    uHistory(t) = u;
end

end
