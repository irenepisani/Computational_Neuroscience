

classdef EchoStateNetwork

    properties
       
        Nx; % Nx : (int) input dimension
        Nh; % Nh : (int) hidden dimension
        
        Wx; % Wx : (matrix) input layer weights
        Wh; % Wh : (matrix) hidden layer weights
        bh; % bh : (matrix) hidden layer bias
        Wo; % Wo : (matrix) output layer weights
        
        omega;  % omega  : (float) input scaling
        rho;    % rho    : (float) spectral radius
        lambda; % lambda : (float) Tikhonov reg. coefficent

        transient;
        
    end

    methods
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
            obj.bh = (2 * rand (obj.Nh, 1)) - 1;
            
            % Satisfy Echo State Property (ESP)
            obj.Wx = obj.omega * obj.Wx;
            obj.bh = obj.omega * obj.bh;
            obj.Wh = obj.rho * (obj.Wh / max(abs(eig(obj.Wh))) );
            obj.Wo = nan;

            obj.transient = transient;


        end

        function Sh = runReservoir (obj, X, initSh)
            
            lenX = length(X);
            Sh = zeros(obj.Nh, lenX); 

            for t = 1 : lenX
               
                if (t == 1)
                    if isnan(initSh)
                        prevSh = zeros(obj.Nh, 1);
                    else
                    prevSh = initSh;
                    end
                else
                    prevSh = Sh(:, t - 1);
                end
                
                Sh(:, t) = tanh(obj.Wx * X(t) + obj.Wh * prevSh + obj.bh);

            end
            
            % add bias column
            Sh = [Sh; ones(1, lenX)];
                    
        end

        function obj = trainReadout (obj, X, Y)
          
            Sh = obj.runReservoir(X, nan);
            Sh = Sh(:, obj.transient:end);
            Y = Y(:, obj.transient:end);
            obj.Wo = Y * Sh' * inv(Sh * Sh' + obj.lambda * eye(obj.Nh +  1));
       
        end

        function [preds, Sh] = predict (obj, X, initState)
            
            Sh = obj.runReservoir(X, initState);
            preds = obj.Wo * Sh;

            Sh = Sh(1:obj.Nh, end);
        end

        function [err, Sh] = evaluate(obj, X, Y, initState)

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