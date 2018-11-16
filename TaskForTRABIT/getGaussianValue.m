function val = getGaussianValue(x, m, v, w)
% Returns gaussian value in a desired point according to the given set of
% parameters.
    val = w * 1/sqrt( 2 * pi * v ) * exp( -( x - m )^2 /(2*v));   
end

