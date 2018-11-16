function w = updateProbWeights(x, g_means, g_variances, g_weights)
% Updates posterior probabilities for a set of Gaussian parameters and a
% given intensity image
    w = zeros(3, length(x));
    for k=1:3
       for i=1:length(x)
          w(k, i) = getGaussianValue(x(i), g_means(k), g_variances(k), g_weights(k))/ ...
              (getGaussianValue(x(i), g_means(1), g_variances(1), g_weights(1))+...
               getGaussianValue(x(i), g_means(2), g_variances(2), g_weights(2))+...
               getGaussianValue(x(i), g_means(3), g_variances(3), g_weights(3)));
       end
    %    plot(x, w(k, :));
    %    hold on;
    end

end

