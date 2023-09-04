%% UNIVERSITY OF PISA
% Computer Science Department
% M.Sc. Computer Science, Artificial Intelligence

%% AUTHOR: IRENE PISANI
% email: i.pisani1@studenti.unipi.it
% matricola: 560104
% date: September 23

%% COMPUTATIONAL NEUROSCIENCE 22/23 - LABORATORY 2.1 

% [ COMPLETED ] Assignment 1: Basic Hebbian Learning
% [ COMPLETED ] Assignment 2: Oja rule
% [ COMPLETED ] Assignment 3: Subtractive Normalization
% [ No ] Bonus Track Assignment 1 – BCM Rule
% [ No ] Bonus Track Assignment 2 – Covariance Rule
% [ No ] Bonus Track Assignment 3 – Dataset #2

%% Assignment 1-2-3: Basic Hebbian Learning, Oja rule, Subtractive Normalization

% For solving this assignment run the main script:
    % hebbianLearningMain()

%% Function for defining hyper-parameter values for each neuro-computational feature

% hebbianLearningPlot()
    % PARAMETER:
        % - dataset: (matrix) input data used for performing learning phase
        % - weight: (vector) final weight vector obtained after learning
        % - weightHistory: (matrix) history of each weight update during
        % learning phase
        % - rule: (string) the considered learning rule
    % DESCRIPTION: Given the final weight and weights evolution over time
    % obtained after learning with a certain rule, try to charaterize the
    % the weight by means of charts.
    % OUTPUT:
        % - P1: Generate an image displaying training data points, final weight
        % vector, and maximum eigen vector computed on the correlation
        % matrix of the dataset. 
        % - P2: Generate 3 images showing 
            % 1) the evolution over time of the value of the 1°component of
            % the weight vector
            % 2) the evolution over time of the value of the 2°component of
            % the weight vector
            % 3) the evolution over time of the value of norm of the weight
            % vector

function hebbianLearningPlot(dataset, weight, weightHistory, rule)

%%%%%% P1. Plot some figure regarding final weights

% compute correlation matrix of the data
Q = dataset * dataset';

% compute eigen pairs of the correlation matrix Q
[eigenVectors, eigenValues] = eig(Q);

% find max eigenValues
[~, maxValues] = max(diag(eigenValues));

% find max Eigen Vector associated with the max Eigen Values
maxEigenVector = eigenVectors(:, maxValues);

subplot(1,1,1)

% display training data points in bidimensional space
scatter(dataset(1, :), dataset(2, :))
hold on

% plot the final weight vector (normalized) 
weight = weight/norm(weight);
plotv(weight, '-b')
hold on

% plot the maximum eigen vector
plotv(maxEigenVector,'--r')

legend('Input data points', 'Final weight vector', 'Maximum Eigen Vector');
title("Data points, final weights and prinpical eigen vector");
hold off

sgtitle("Learning with "+rule+" rule")
saveas(gcf, 'Results/P1'+rule, 'jpg')

%%%%%% P2. Plot some figure regarding weights evolution

% plot values of the 1° component of the weight vectors over time
subplot(2,2,1)
plot(weightHistory(1, :));
xlabel("time (t)");
ylabel("Value of 1° component");
title("Evolution of weight's 1° component over time");

% plot 2° component of the weight vectors over time
subplot(2,2,2)
plot(weightHistory(2, :));
xlabel("time (t)");
ylabel("Value of 2° component");
title("Evolution of weight's 2° component over time");

% plot the norm of the weight vectors in time
subplot(2,2,3)
plot(vecnorm(weightHistory));
xlabel("time (t)");
ylabel("Norm value");
title("Evolution of weight's norm over time");

% set image title and save figure
sgtitle("Learning with "+rule+" rule")
saveas(gcf, 'Results/P2'+rule, 'jpg')

end