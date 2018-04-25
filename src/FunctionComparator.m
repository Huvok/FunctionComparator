function FunctionComparator()
    % Especificar las funciones deseadas:
    %   1. Bent Cigar Function
    %   2. 
    arrFunctions = [1, 2, 3, 4, 5];
    
    % Especificar el n�mero de r�plicas por funci�n
    replicas = [5, 5, 5, 5, 5];
    
    % Especificar n�mero de dimensiones
    dimensions = [10, 10, 10, 10, 10];
    
    % Especificar los lower bounds por dimensi�n, por funci�n
    lower_bounds = [-100 -100 -100 -100 -100 -100 -100 -100 -100 -100;...
        -100 -100 -100 -100 -100 -100 -100 -100 -100 -100;...
        -100 -100 -100 -100 -100 -100 -100 -100 -100 -100;...
        -100 -100 -100 -100 -100 -100 -100 -100 -100 -100;...
        -100 -100 -100 -100 -100 -100 -100 -100 -100 -100;...
        -100 -100 -100 -100 -100 -100 -100 -100 -100 -100;...
        -100 -100 -100 -100 -100 -100 -100 -100 -100 -100;...
        -100 -100 -100 -100 -100 -100 -100 -100 -100 -100;...
        -100 -100 -100 -100 -100 -100 -100 -100 -100 -100;...
        -100 -100 -100 -100 -100 -100 -100 -100 -100 -100];
    
    % Especificar los upper bounds por dimensi�n, por funci�n
    upper_bounds = [100 100 100 100 100 100 100 100 100 100;...
        100 100 100 100 100 100 100 100 100 100;...
        100 100 100 100 100 100 100 100 100 100;...
        100 100 100 100 100 100 100 100 100 100;...
        100 100 100 100 100 100 100 100 100 100;...
        100 100 100 100 100 100 100 100 100 100;...
        100 100 100 100 100 100 100 100 100 100;...
        100 100 100 100 100 100 100 100 100 100;...
        100 100 100 100 100 100 100 100 100 100;...
        100 100 100 100 100 100 100 100 100 100];
    
    % Especificar n�mero de evaluaciones m�ximas por funci�n
    maxEvals = [1000, 10000, 10000, 10000, 10000];
    
    % ---------------------------------------------------------------------
    % ES
    
    % Mu para ES (Tama�o de poblaci�n)
    structES.mu = 10;
    
    % Lambda para ES (Hijos a producir)
    structES.lambda = 5;
    
    % Probabilidad de cruza
    structES.crossover = .5;
    
    % Probabilidad de mutaci�n
    structES.mutation = .5;
    
    for i=1:1
        for j=1:replicas(i)
           output = ES(@test_function_1, structES.mu, structES.lambda, ...
               dimensions(1), lower_bounds(1, :), upper_bounds(1, :), ...
               structES.crossover, structES.mutation, maxEvals(1));
           
           if (j == 1)
               meanReplicas = output.mean_iter;
           else
               meanReplicas = meanReplicas + output.mean_iter;
           end
        end
        
        meanReplicas = meanReplicas / replicas(i);
        sz = size(meanReplicas);
        plot(linspace(1, sz(1), sz(1)), meanReplicas');
        axis([0 sz(1) min(meanReplicas(:, 1)) mean(meanReplicas(:, 1))]);
    end
end