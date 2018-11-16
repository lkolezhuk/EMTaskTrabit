function g = buildGaussian(x, m, v, w)
% Returns gaussian values in a set of desired points according to the given set of
% parameters.
    g = w * 1/sqrt( 2 * pi * v ) * exp( -( x - m ).^2 / (2*v) );
end

