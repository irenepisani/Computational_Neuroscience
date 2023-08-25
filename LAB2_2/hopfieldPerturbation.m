%% UNIVERSITY OF PISA
% Computer Science Department
% M.Sc. Computer Science, Artificial Intelligence

%% AUTHOR: IRENE PISANI
% email: i.pisani1@studenti.unipi.it
% matricola: 560104
% date: August 23

%% COMPUTATIONAL NEUROSCIENCE 22/23 - LABORATORY 2.2

% [ COMPLETED ] Assignment 1: Small Image Dataset
% [ No ] Bonus Track Assignment # 1 – Synthetic data
% [ No ] Bonus Track Assignment # 2 – How much can you remember?

%% Assignment 1: Small Image Dataset

% For solving these assignments run the main script:
    % hopfieldMain()
        % PARAMETERS: No input parameter are required. 
        % DESCRIPTION: Load original data and perform the storage phase of
        % the hopfield network with them. Then perform the retrieval phase
        % of the hopfield network with the distorted version of the
        % original vectors. Expploits hopfieldNetwork() and hopfieldPrturbation()
        % OUTPUT: the figure generated by hopfieldPlot()

% Other scripts or functions exploited in this assignments are:
    % hopfieldPerturbation()
    % hopfieldNetwork()
    % hopfieldPlot()

%% Function for applying distorsion/perturbartion on vectors

% hopfieldPerturbation()
    % PARAMETER: 
        % d: (float) value corresponding to the percentage of the input
        % vector to which apply distorsion
        % inputVector: (vector) input vector to which apply distorsion
    % DESCRIPTION: Given an input vector, the function
    % hopfieldPerturbation() returns a distorted version of the vector. The
    % type of distrosion used is flipping i.e. change in sign. 
    % Distorsion is applied to d*100 percetnage of the element of the
    % input vector, according to d parameter. 
    % hopfieldPerturbation() returns a
    % OUTPUT: 
        % inputVector: (vector) input vector modified with distorsion.


function [inputVector] = hopfieldPerturbation (inputVector, d)


% Num. component of input vector
nComponents = length(inputVector);

% Check if d scalar value is in the allowed range [0.05, 1]
assert((d < 1 || d >= 0.05), "distorsion parameter value out of range")

% Num. element to which apply distorsion
nDistorsion = round(nComponents*d);

% Shuffle indexes of input vector 
idxDistorsion = randperm(nComponents);

% Get first random index of element to which apply distorsion
idxDistorsion = idxDistorsion(1: nDistorsion);

% Apply flipping distorsion to selected components
% Distorsion type = Flipping i.e. changing sign
inputVector(idxDistorsion) = -inputVector(idxDistorsion);


