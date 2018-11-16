function val = getLowerBound(x, m, v, w, weights)
% Calculates the Lower Bound function for the log likelihood
        val = 0;
        for i = 1:length(x)              
            val = val + sum([...
                weights(1,i)*log(getGaussianValue(x(i), m(1), v(1), w(1))/weights(1,i)), ...
                weights(2,i)*log(getGaussianValue(x(i), m(2), v(2), w(2))/weights(2,i)), ...
                weights(3,i)*log(getGaussianValue(x(i), m(3), v(3), w(3))/weights(3,i))]);
        end        
end
