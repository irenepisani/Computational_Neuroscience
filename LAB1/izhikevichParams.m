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

%% Function for defining hyper-parameter values for each neuro-computational feature

% izhikevichParams()
    % PARAMETER: no parameter are required.
    % DESCRIPTION: For each neuro-computational features, specify the value
    % of each parameters.
    % OUTPUT: A cell structure with parameter-value pairs for each features. 
    
function [params] = izhikevichParams()

% Specify parameter values for each one of the 20 neuro-computational
% features

params.A.title = ["(A) Tonic Spiking", "A_tonic_spiking"];
params.A.abcd = [0.02, 0.2, -65, 6];
params.A.coef = [5, 140, 1, 0];
params.A.varInit = [-70, params.A.abcd(2) * -70];
params.A.tauStep = 0.25;
params.A.tauSpan = 0: params.A.tauStep: 100;
params.A.t1 = params.A.tauSpan(end)/10;
params.A.inputHistory = zeros(1, length(params.A.tauSpan));
i=1;
for t = params.A.tauSpan
    if t > params.A.t1
        params.A.inputHistory(i) = 14;
    end
    i = i +1;
end

params.B.title = ["(B) Phasic Spiking", "B_phasic_spiking"];
params.B.abcd = [0.02, 0.25, -65, 6];
params.B.coef = [5, 140, 1, 0];
params.B.varInit = [-64, params.B.abcd(2) * -64];
params.B.tauStep = 0.25;
params.B.tauSpan = 0: params.B.tauStep: 200;
params.B.t1 = 20;
params.B.inputHistory = zeros(1, length(params.B.tauSpan));
i=1;
for t = params.B.tauSpan
    if t > params.B.t1
        params.B.inputHistory(i) = 0.5;
    end
    i = i +1;
end

params.C.title = ["(C) Tonic Bursting", "C_tonic_bursting"];
params.C.abcd = [0.02, 0.2, -50, 2];
params.C.coef = [5, 140, 1, 0];
params.C.varInit = [-70, params.C.abcd(2) * -70];
params.C.tauStep = 0.25;
params.C.tauSpan = 0: params.C.tauStep: 220;
params.C.t1 = 22;
params.C.inputHistory = zeros(1, length(params.C.tauSpan));
i=1;
for t = params.C.tauSpan
    if t > params.C.t1
        params.C.inputHistory(i) = 15;
    end
    i = i +1;
end

params.D.title = ["(D) Phasic Bursting", "D_phasic_bursting"];
params.D.abcd = [0.02, 0.25, -55, 0.05];
params.D.coef = [5, 140, 1, 0];
params.D.varInit = [-64, params.D.abcd(2) * -64];
params.D.tauStep = 0.2;
params.D.tauSpan = 0: params.D.tauStep: 200;
params.D.t1 = 20;
params.D.inputHistory = zeros(1, length(params.D.tauSpan));
i=1;
for t = params.D.tauSpan
    if t > params.D.t1
        params.D.inputHistory(i) = 0.6;
    end
    i = i +1;
end

params.E.title = ["(E) Mixed Mode", "E_mixed_mode"];
params.E.abcd = [0.02, 0.2, -55, 4];
params.E.coef = [5, 140, 1, 0];
params.E.varInit = [-70; params.E.abcd(2) * -70];
params.E.tauStep = 0.25;
params.E.tauSpan = 0: params.E.tauStep: 160;
params.E.t1 = params.E.tauSpan(end)/10;
params.E.inputHistory = zeros(1, length(params.E.tauSpan));
i=1;
for t = params.E.tauSpan
    if t > params.E.t1
        params.E.inputHistory(i) = 10;
    end
    i = i +1;
end

params.F.title = ["(F) Spike Frequency Adaptation", "F_spike_frequency_adaptation"];
params.F.abcd = [0.01, 0.2, -65, 8];
params.F.coef = [5, 140, 1, 0];
params.F.varInit = [-70, params.F.abcd(2) * -70];
params.F.tauStep = 0.25; 
params.F.tauSpan = 0: params.F.tauStep: 85;
params.F.t1 = params.F.tauSpan(end)/10;
params.F.inputHistory = zeros(1, length(params.F.tauSpan));
i=1;
for t = params.F.tauSpan
    if t > params.F.t1
        params.F.inputHistory(i) = 30;
    end
    i = i +1;
end

params.G.title = ["(G) Class 1 Exitable", "G_class1_exitable"];
params.G.abcd = [0.02, -0.1, -55, 6];
params.G.coef = [4.1, 108, 1, 0];
params.G.varInit = [-60, params.G.abcd(2) * -60];
params.G.tauStep = 0.25;
params.G.tauSpan = 0: params.G.tauStep: 300;
params.G.t1 = 30;
params.G.inputHistory = zeros(1, length(params.G.tauSpan));
i=1;
for t = params.G.tauSpan
    if t > params.G.t1
        params.G.inputHistory(i) = (0.075*(t-params.G.t1));
    end
    i = i +1;
end

params.H.title = ["(H) Class 2 Exitable", "H_class2_exitable"];
params.H.abcd = [0.2, 0.26, -65, 0];
params.H.coef = [5, 140, 1, 0];
params.H.varInit = [-64, params.H.abcd(2) * -64];
params.H.tauStep = 0.25;
params.H.tauSpan = 0: params.H.tauStep: 300;
params.H.t1 = 30;
params.H.inputHistory = zeros(1, length(params.H.tauSpan));
i=1;
for t = params.H.tauSpan
    if t > params.H.t1
        params.H.inputHistory(i) = -0.5+(0.015*(t-params.H.t1));
    else
        params.H.inputHistory(i) = -0.5;
    end
    i = i +1;
end

params.I.title = ["(I) Spike Latency", "I_spike_latency"];
params.I.abcd = [0.02, 0.2, -65, 6];
params.I.coef = [5, 140, 1, 0];
params.I.varInit = [-70, params.I.abcd(2) * -70];
params.I.tauStep = 0.2;
params.I.tauSpan = 0: params.I.tauStep: 100;
params.I.t1 = params.I.tauSpan(end)/10;
params.I.inputHistory = zeros(1, length(params.I.tauSpan));
i=1;
for t = params.I.tauSpan
    if (t > params.I.t1 && t < params.I.t1+3)
        params.I.inputHistory(i) = 7.04;
    end
    i = i +1;
end

params.J.title = ["(J) Subthreshold oscillation ","J_subthreshold_oscillation"];
params.J.abcd = [0.05, 0.26, -60, 0];
params.J.coef = [5, 140, 1, 0];
params.J.varInit = [-62, params.J.abcd(2) * -62];
params.J.tauStep = 0.25;
params.J.tauSpan = 0: params.I.tauStep: 200;
params.J.t1 = params.J.tauSpan(end)/10;
params.J.inputHistory = zeros(1, length(params.J.tauSpan));
i=1;
for t = params.J.tauSpan
    if (t > params.J.t1 && t < params.J.t1+5)
        params.J.inputHistory(i) = 2;
    end
    i = i +1;
end

params.K.title = ["(K) Reasonator", "K_reasonator"];
params.K.abcd = [0.1, 0.26, -60, -1];
params.K.coef = [5, 140, 1, 0];
params.K.varInit = [-62, params.K.abcd(2) * (-62)];
params.K.tauStep = 0.25;
params.K.tauSpan = 0: params.K.tauStep: 400;
params.K.t1 = params.K.tauSpan(end)/10;
params.K.t2 = params.K.t1 + 20;
params.K.t3 = 0.7*params.K.tauSpan(end);
params.K.t4 = params.K.t3 +40;
params.K.inputHistory = zeros(1, length(params.K.tauSpan));
i=1;
for t = params.K.tauSpan
    if ((t>params.K.t1) && (t < params.K.t1+4)) ||...
            ((t>params.K.t2) && (t < params.K.t2+4)) ||...
            ((t>params.K.t3) && (t < params.K.t3+4)) ||...
            ((t>params.K.t4) && (t < params.K.t4+4)) 
        params.K.inputHistory(i) = 0.65;
    end
    i = i +1;
end

params.L.title = ["(L) Integrator", "L_integrator"];
params.L.abcd = [0.02, -0.1, -55, 6];
params.L.coef = [4.1, 108, 1, 0];
params.L.varInit = [-60, params.L.abcd(2) * (-60)];
params.L.tauStep = 0.25;
params.L.tauSpan = 0: params.L.tauStep: 100;
params.L.t1 = params.L.tauSpan(end)/11;
params.L.t2 = params.L.t1 + 5;
params.L.t3 = 0.7*params.L.tauSpan(end);
params.L.t4 = params.L.t3 + 10;
params.L.inputHistory = zeros(1, length(params.L.tauSpan));
i=1;
for t = params.L.tauSpan
    if ((t>params.L.t1) && (t < params.L.t1+2)) ||...
            ((t>params.L.t2) && (t < params.L.t2+2)) ||...
            ((t>params.L.t3) && (t < params.L.t3+2)) ||...
            ((t>params.L.t4) && (t < params.L.t4+2)) 
        params.L.inputHistory(i) = 9;
    end
    i = i +1;
end

params.M.title = ["(M) Rebound Spike", "M_rebound_spike"];
params.M.abcd = [0.03, 0.25, -60, 4];
params.M.coef = [5, 140, 1, 0];
params.M.varInit = [-64, params.M.abcd(2) * (-64)];
params.M.tauStep = 0.2;
params.M.tauSpan = 0: params.M.tauStep: 200;
params.M.t1 = 20;
params.M.inputHistory = zeros(1, length(params.M.tauSpan));
i=1;
for t = params.M.tauSpan
    if ((t> params.M.t1) && (t < params.M.t1+5)) 
        params.M.inputHistory(i) = -15;
    end
    i = i +1;
end

params.N.title = ["(N) Rebound Burst", "N_rebound_burst"];
params.N.abcd = [0.03, 0.25, -52, 0];
params.N.coef = [5, 140, 1, 0];
params.N.varInit = [-64, params.N.abcd(2) * (-64)];
params.N.tauStep = 0.2;
params.N.tauSpan = 0: params.N.tauStep: 200;
params.N.t1 = 20;
params.N.inputHistory = zeros(1, length(params.N.tauSpan));
i=1;
for t = params.N.tauSpan
    if ((t> params.N.t1) && (t < params.N.t1+5)) 
        params.N.inputHistory(i) = -15;
    end
    i = i +1;
end

params.O.title = ["(O) Threshold variability ", "O_Threshold variability "];
params.O.abcd = [0.03, 0.25, -60, 4];
params.O.coef = [5, 140, 1, 0];
params.O.varInit =[-64, params.O.abcd(2) * (-64)];
params.O.tauStep = 0.25;
params.O.tauSpan = 0: params.O.tauStep: 100;
params.O.inputHistory = zeros(1, length(params.O.tauSpan));
i=1;
for t = params.O.tauSpan
    if ((t>10) && (t < 15)) || ((t>80) && (t < 85)) 
        params.O.inputHistory(i) = 1;
    elseif (t>70) && (t < 75)
        params.O.inputHistory(i) = -6;
    end
    i = i +1;
end

params.P.title = ["(P) Bistability", "P_bistability"];
params.P.abcd = [0.1, 0.26, -60, 0];
params.P.coef = [5, 140, 1, 0];
params.P.varInit = [-61, params.P.abcd(2) * (-61)];
params.P.tauStep = 0.25;
params.P.tauSpan = 0: params.P.tauStep: 300;
params.P.t1 = params.P.tauSpan(end)/8;
params.P.t2 = 216;
params.P.inputHistory = zeros(1, length(params.P.tauSpan));
i=1;
for t = params.P.tauSpan
    if ((t>params.P.t1) && (t < params.P.t1+5)) || ((t>params.P.t2) && (t < params.P.t2+5)) 
        params.P.inputHistory(i) = 1.24;
    else
        params.P.inputHistory(i) = 0.24;
    end
    i = i +1;
end

params.Q.title = ["(Q) Depolarizing After Potential", "Q_depolarizing_after_potential"];
params.Q.abcd = [1, 0.2, -60, -21];
params.Q.coef = [5, 140, 1, 0];
params.Q.varInit = [-70, params.Q.abcd(2) * (-70)];
params.Q.tauStep = 0.1;
params.Q.tauSpan = 0: params.Q.tauStep: 50;
params.Q.t1 = 10;
params.Q.inputHistory = zeros(1, length(params.Q.tauSpan));
i=1;
for t = params.Q.tauSpan
    if abs(t-params.Q.t1)<1 
        params.Q.inputHistory(i) = 20;
    end
    i = i +1;
end

params.R.title = ["(R) Accomodation", "R_accomodation"];
params.R.abcd = [0.02, 1, -55, 4];
params.R.coef = [5, 140, 0, 65];
params.R.varInit = [-65, -16];
params.R.tauStep = 0.5;
params.R.tauSpan = 0:params.R.tauStep:400;
params.R.inputHistory = zeros(1, length(params.R.tauSpan));
i=1;
for t = params.R.tauSpan
    if (t < 200)
        params.R.inputHistory(i) = t/25;
    elseif t < 300
        params.R.inputHistory(i) = 0;
    elseif t < 312.5
        params.R.inputHistory(i) = (t-300)/12.5*4;
    else
        params.R.inputHistory(i) = 0;
    end
    i = i +1;
end

params.S.title = ["(S)  Inhibition Induced Spiking", "S_inhibition_induced_spiking"];
params.S.abcd = [-0.02, -1, -60, 8];
params.S.coef = [5, 140, 1, 0];
params.S.varInit = [-63.8, params.S.abcd(2) * (-63.8)];
params.S.tauStep = 0.5;
params.S.tauSpan = 0: params.S.tauStep :350; 
params.S.inputHistory = zeros(1, length(params.S.tauSpan));
i=1;
for t = params.S.tauSpan
    if (t < 50) || (t>250)
        params.S.inputHistory(i)=80;
    else
        params.S.inputHistory(i)=75;
    end
    i = i +1;
end

params.T.title = ["(T) Inhibition Induced Bursting", "T_inhibition_induced_bursting"];
params.T.abcd = [-0.026, -1, -45, -2];
params.T.coef = [5, 140, 1, 0];
params.T.varInit = [-63.8, params.T.abcd(2) * (-63.8)];
params.T.tauStep = 0.5;
params.T.tauSpan = 0: params.T.tauStep :350; 
params.T.inputHistory = zeros(1, length(params.T.tauSpan));
i=1;
for t = params.T.tauSpan
    if (t < 50) || (t>250)
        params.T.inputHistory(i)=80;
    else
        params.T.inputHistory(i)=75;
    end
    i = i +1;
end

end