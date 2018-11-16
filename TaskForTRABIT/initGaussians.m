function [means, variances, weights] = initGaussians(min_int, max_int)
% Initializes 3 Gaussians for a given intensity gap. The gaussians are set
% to be on the k/3 of the intensity interval (k is 1..3) with variances
% equal to the half of each interval.
    interval = max_int - min_int;
    
    m1 = min_int + interval * 1/6;
    m2 = min_int + interval * 3/6;
    m3 = min_int + interval * 5/6;
    
    means = [m1, m2, m3];
    variances = [(interval/6)^2, (interval/6)^2, (interval/6)^2];
    weights = [1/3, 1/3, 1/3];
end

