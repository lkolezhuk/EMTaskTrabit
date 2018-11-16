function val = getLogLikelihood(x, m, v, w)
% Calculates the log likelihood function for given parameters
        val = 0;
        for i = 1:length(x)              
            val = val + log(sum([getGaussianValue(x(i), m(1), v(1), w(1)), ...
                             getGaussianValue(x(i), m(2), v(2), w(2)), ...
                             getGaussianValue(x(i), m(3), v(3), w(3))]));
        end        
end
