clc;
close all;
clear;

load correctedData;
input_size = [size(correctedData, 1), size(correctedData, 2)];

% Mask the input data to remove background
mask = correctedData > 0;
intensities = correctedData(find(mask));

max_int = max(intensities);
min_int = min(intensities);

mean = sum(intensities) / length(intensities);
variance = sum(( intensities - mean).^ 2 )/ length(intensities);

% Compute the histogram and its properties
[ histogram binCenters ] = hist( intensities, 64 );
pdf = histogram / sum( histogram );
binSize = binCenters(2) - binCenters(1);

% Initialize 3 Gaussian model, build and visualize them
[g_means, g_variances, g_weights] = initGaussians(min_int, max_int);

% Compute the initial w_i_k weights
x_intensities = intensities';
w = updateProbWeights(x_intensities, g_means, g_variances, g_weights);


% Optimize the parameters to achieve maximum log likelihood 
iterations = 100;  % number of iterations for the EM optimization
figure; % initializes the figure used by updateOptGraphs()
for iter=1:iterations
   [g_means, g_variances, g_weights] = updateGaussianParameters(x_intensities, w, g_means, g_variances, g_weights);
   w = updateProbWeights(x_intensities, g_means, g_variances, g_weights);
   log_likelihood(iter) = getLogLikelihood(x_intensities, g_means, g_variances, g_weights);
   lower_bound(iter) = getLowerBound(x_intensities, g_means, g_variances, g_weights, w);
   
   % Display the optimization progress on the graph
   updateOptGraphs(binCenters, binSize, x_intensities, pdf, log_likelihood, lower_bound, w, g_means, g_variances, g_weights);   
end

%% 2nd Gaussian mean variance

% Generate m2 space of 100 points from m1 to m3
m2_space = linspace(round(g_means(1)), round(g_means(3)), 100);

% Calculate weights for the lower bound (as the task requires)
w_alt = updateProbWeights(x_intensities, [g_means(1) g_means(1) g_means(3)], g_variances, g_weights);

% For each m2 in m2_space find the likelihood and lower bound functions
for i=1:length(m2_space)  
    log_likelihood_m2(i) = getLogLikelihood(x_intensities, [g_means(1), m2_space(i), g_means(3)], g_variances, g_weights);
    lower_bound(i) = getLowerBound(x_intensities, [g_means(1), m2_space(i), g_means(3)], g_variances, g_weights, w_alt);
end

% Plot likelihood and lower bound depending on the m2
% the m2 is set to be m1 for alternative posterior prob. weights w_alt(as
% the task requires) 
figure;
plot(m2_space, log_likelihood_m2, 'ob')
hold on;
plot(m2_space, lower_bound, '-r')
hold on;

% Find the value of m2 that maximizes the lower bound function for all
% other parameters staying fixed to initial values (m2 - the only variable)
% Calculate maximizing means by function 4.35
[g_means_MAX, ~, ~] = updateGaussianParameters(x_intensities, w_alt, g_means, g_variances, g_weights);

% Calculate the lower bound corresponding to the g_means_MAX(2) that
% maximizes the function
lower_bound_MAX = getLowerBound(x_intensities,  [g_means(1) g_means_MAX(2) g_means(3)], g_variances, g_weights, w_alt);

% Plot this point on the recent graph
plot(g_means_MAX(2), lower_bound_MAX, 'XR');   
title('Log likelihood for varying m2')

% The lower bound never exceeds the log likelihood itself as it was defined
% this way. We can see that the m2 that maximizes the log likelihood is the
% same as we would obtain during the iterative EM algorithm.

% The value that maximizes the lower bounding function for the log
% likelihood lies on the peak of the red curve on the graph, which makes
% sense because for this we found only the optimal m2. If we would calculate the
% entire parameter vector instead, the maximum point would be outside of
% this curve. 

% If we let all the values of the parameter vector to be changed and we do
% enough iterations, we would converge to the same solution as in the
% initial algorithm.





