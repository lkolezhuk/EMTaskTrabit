function [g_means, g_variances, g_weights] = updateGaussianParameters(x, w, g_means, g_variances, g_weights)
%    Calculates the Gaussian parameters according to the set of posterior
%    probabilities and the given intenstity image according to 4.35 formulas 
   for k=1:3
      g_means(k) = sum(w(k,:).* x)/ sum(w(k, :));
      g_variances(k) = sum(w(k,:) .* ((x - g_means(k)).^2)) / sum(w(k,:));
      g_weights(k) = sum(w(k,:))/length(x);
   end
end

