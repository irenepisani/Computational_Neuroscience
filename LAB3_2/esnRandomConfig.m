function [hyperParams] = esnRandomConfig()

% Get a random configuration of hyperparameters

hyperParams.Nh = randi([50, 200]); % Nh    : (int)  in [5, 100]
hyperParams.rho = rand;           % rho   : (float) in [0, 1]
hyperParams.omega = rand;         % omega : (float) in [0, 1]
hyperParams.lambda = 0.0001 * rand;  % lambda: (float) in [0, 0.1]

end