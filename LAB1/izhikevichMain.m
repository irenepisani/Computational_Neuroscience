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

%% Main Script 

% Get hyper-parameter values of each neuro-computational feature
params = izhikevichParams();

% Neuro-computational feature A
[vHist, uHist] = izhikevichModel(params.A);
izhikevichPlot(params.A, vHist, uHist)

% Neuro-computational feature B
[vHist, uHist] = izhikevichModel(params.B);
izhikevichPlot(params.B, vHist, uHist)

% Neuro-computational feature C
[vHist, uHist] = izhikevichModel(params.C);
izhikevichPlot(params.C, vHist, uHist)

% Neuro-computational feature D
[vHist, uHist] = izhikevichModel(params.D);
izhikevichPlot(params.D, vHist, uHist)

% Neuro-computational feature E
[vHist, uHist] = izhikevichModel(params.E);
izhikevichPlot(params.E, vHist, uHist)

% Neuro-computational feature F
[vHist, uHist] = izhikevichModel(params.F);
izhikevichPlot(params.F, vHist, uHist)

% Neuro-computational feature G
[vHist, uHist] = izhikevichModel(params.G);
izhikevichPlot(params.G, vHist, uHist)

% Neuro-computational feature H
[vHist, uHist] = izhikevichModel(params.H);
izhikevichPlot(params.H, vHist, uHist)

% Neuro-computational feature I
[vHist, uHist] = izhikevichModel(params.I);
izhikevichPlot(params.I, vHist, uHist)

% Neuro-computational feature J
[vHist, uHist] = izhikevichModel(params.J);
izhikevichPlot(params.J, vHist, uHist)

% Neuro-computational feature K
[vHist, uHist] = izhikevichModel(params.K);
izhikevichPlot(params.K, vHist, uHist)

% Neuro-computational feature L
[vHist, uHist] = izhikevichModel(params.L);
izhikevichPlot(params.L, vHist, uHist)

% Neuro-computational feature M
[vHist, uHist] = izhikevichModel(params.M);
izhikevichPlot(params.M, vHist, uHist)

% Neuro-computational feature N
[vHist, uHist] = izhikevichModel(params.N);
izhikevichPlot(params.N, vHist, uHist)

% Neuro-computational feature O
[vHist, uHist] = izhikevichModel(params.O);
izhikevichPlot(params.O, vHist, uHist)

% Neuro-computational feature P
[vHist, uHist] = izhikevichModel(params.P);
izhikevichPlot(params.P, vHist, uHist)

% Neuro-computational feature Q
[vHist, uHist] = izhikevichModel(params.Q);
izhikevichPlot(params.Q, vHist, uHist)

% Neuro-computational feature R
[vHist, uHist] = izhikevichModel(params.R);
izhikevichPlot(params.R, vHist, uHist)

% Neuro-computational feature S
[vHist, uHist] = izhikevichModel(params.S);
izhikevichPlot(params.S, vHist, uHist)

% Neuro-computational feature T
[vHist, uHist] = izhikevichModel(params.T);
izhikevichPlot(params.T, vHist, uHist)
