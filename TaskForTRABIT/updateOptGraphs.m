function updateOptGraphs(x, binSize, x_intensities, pdf, log_likelihood, lower_bound, w, g_means, g_variances, g_weights)
% Plots the graphs during the itterative process of EM algorithm. Inputs
% are updates values of likelihood, lower bound as well as the Gaussian
% mixture parameters.
        subplot(3,1,1)
        cla;
        bbar = bar( x, pdf);       
        bbar.FaceColor = [0.9 0.9 0.9];
        hold on

        for i=1:3
            g(i, :) = buildGaussian(x, g_means(i), g_variances(i), g_weights(i));
            plot(x, g(i,:) * binSize, '-');
        end
        
        gauss_mixture_model = sum(g, 1);
        plot(x, gauss_mixture_model * binSize,'ob');
        xlabel('Intensities');
        title('Gaussian mixture model')
        
        subplot(3,1,2)
        cla;
      
        for k=1:3
            plot(x_intensities, w(k,:), '.');
            hold on;
        end
        xlim([min(x) max(x)]);
        xlabel('Intensities');
        title('Weights')
        
        
        subplot(3,1,3)
        cla;
        plot(log_likelihood, 'ob')
        xlabel('Iterations');
%         hold on;
%         plot(lower_bound, '-r');
        title('Log likelihood')
        
        pause(0.1)
end

