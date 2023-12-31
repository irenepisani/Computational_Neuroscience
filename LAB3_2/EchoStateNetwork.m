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

%% Class for implementing, training and evaluate ESN model

classdef EchoStateNetwork

    properties
       
        Nx; % Nx : (int) input dimension
        Nh; % Nh : (int) hidden dimension
        
        Wx; % Wx : (matrix) input layer weights
        Wh; % Wh : (matrix) hidden layer weights
        Wo; % Wo : (matrix) output layer weights

        b; % b : (matrix) bias vector
        
        omega;  % omega  : (float) input scaling
        rho;    % rho    : (float) spectral radius
        lambda; % lambda : (float) Tikhonov reg. coefficent

        transient;
        
    end

    methods
        %% Function to initialize ESN 
       
        % PARAMETERS: 
            % params : (struct) a configuration of hyperparameter values
            % inputDim : (int) input dimension
            % transient : (int) num of initial state you want to discard
        
        % DESCRIPTION:
        % Initial network weights and bias. 

        % OUTPUT: the initialized network

        function obj = EchoStateNetwork(params, inputDim, transient)
            
            % hyper-parameter values definition
            obj.omega = params.omega;
            obj.rho = params.rho;
            obj.lambda = params.lambda;
            
            % Network's layer dimensions 
            obj.Nx = inputDim;
            obj.Nh = params.Nh;
            
            % Weights initialization
            obj.Wx = (2 * rand (obj.Nh, obj.Nx)) - 1;
            obj.Wh = (2 * rand (obj.Nh, obj.Nh)) - 1;
            obj.b = (2 * rand (obj.Nh, 1)) - 1;
            
            % Satisfy Echo State Property (ESP)
            obj.Wx = obj.omega * obj.Wx;
            obj.b = obj.omega * obj.b;
            obj.Wh = obj.rho * (obj.Wh / max(abs(eig(obj.Wh))) );
            obj.Wo = nan;

            obj.transient = transient;

        end

        %% Function to initialize ESN 
       
        % PARAMETERS: 
            % X : input 
            % initSH : previous state  (nan for t = 0)
        
        % DESCRIPTION:
        % Compute reservoir state transition function. 

        % OUTPUT:
            % Sh : reservoir state

        function Sh = runReservoir (obj, X, initSh)
            
            lenX = length(X);

            % initialize empty collection of state 
            Sh = zeros(obj.Nh, lenX); 
            
            % iterate over timestep
            for t = 1 : lenX
               
                if (t == 1)

                    % null state as initial state
                    if isnan(initSh)
                        prevSh = zeros(obj.Nh, 1);
                    else
                        prevSh = initSh;
                    end
                else
                    prevSh = Sh(:, t - 1);
                end
                
                % compute state transition function:
                Sh(:, t) = tanh(obj.Wx * X(t) + obj.Wh * prevSh + obj.b);

            end
            
            % add bias column
            Sh = [Sh; ones(1, lenX)];
                    
        end

        %% Function for training linear readout
        
        % PARAMETERS: 
            % X : input 
            % Y : target
        
        % DESCRIPTION:
        % Train linear readout layer with ridge regression. 

        % OUTPUT: ESN with trained Wo

        function obj = trainReadout (obj, X, Y)
            
            % Collectall reservoir states  and target for each time step
            Sh = obj.runReservoir(X, nan);
            Sh = Sh(:, obj.transient:end);
            Y = Y(:, obj.transient:end);

            % train linear readout with ridge regression
            obj.Wo = Y * Sh' * inv(Sh * Sh' + obj.lambda * eye(obj.Nh +  1));
       
        end
        
        %% Function for make prediction with ESN
        
        % PARAMETERS: 
            % X : input 
            % InitState : could be nan for setting zero initial state 
        
        % DESCRIPTION:
        % Make predicition with ESN

        % OUTPUT: 
            % preds : ESN predicitions
            % Sh : ESN state

        function [preds, Sh] = predict (obj, X, initState)
            
            Sh = obj.runReservoir(X, initState);
            preds = obj.Wo * Sh;

            Sh = Sh(1:obj.Nh, end);
        end
        
        %% Function for evaluate ESN
        
        % PARAMETERS: 
            % X : input 
            % Y : target
            % InitState : could be nan for setting zero initial state 
        
        % DESCRIPTION:
        % Evaluate ESN performance with MSE metric

        % OUTPUT: 
            % err : MSE beween pedictions and target
            % preds : ESN's predictions

        function [err, preds, Sh] = evaluate(obj, X, Y, initState)

            [preds, Sh] = obj.predict(X, initState);
            
            if isnan(initState)
                preds = preds(:, obj.transient:end);
                Y = Y(:, obj.transient:end);
            end

            % predictions evaluation with MSE
            err = immse (Y, preds);
        end

    end
end