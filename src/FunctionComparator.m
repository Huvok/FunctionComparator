function FunctionComparator()
    % Especificar las funciones deseadas:
    %   1. Bent Cigar Function
    %   2. 
    arrFunctions = [1, 2, 3, 4, 5];
    
    % Especificar el n�mero de r�plicas por funci�n
    replicas = [5, 5, 5, 5, 5];
    
    % Especificar n�mero de dimensiones por funci�n
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
    maxEvals = [10000, 10000, 10000, 10000, 10000];
    
    % ---------------------------------------------------------------------
    % ES
    
    % Mu para ES (Tama�o de poblaci�n)
    structES.mu = 10;
    
    % Lambda para ES (Hijos a producir)
    structES.lambda = 10;
    
    % Probabilidad de cruza
    structES.crossover = .5;
    
    % Probabilidad de mutaci�n
    structES.mutation = .5;
    
    % ---------------------------------------------------------------------
    % DE
    
    % Tama�o de la poblaci�n
    structDE.popSize = 10;
    
    % Probabilidad de cruza
    structDE.crossover = .5;
    
    % Peso diferencial
    structDE.diffWeight = .5;
    
    % ---------------------------------------------------------------------
    % PSO
    
    % Tama�o de la poblaci�n
    structPSO.popSize = 10;
    
    % c1
    structPSO.c1 = 2;
    
    % c2
    structPSO.c2 = 2;
    
    % w
    structPSO.w = .7;

    for i=1:5
        
        % Function 1 ------------------------------------------------------
        if arrFunctions(i) == 1
            
            % F1 ES -------------------------------------------------------
            hold on;
            for j=1:replicas(i)
               output = ES(@test_function_1, structES.mu, ...
                   structES.lambda, dimensions(1), lower_bounds(1, :), ...
                   upper_bounds(1, :), structES.crossover, ...
                   structES.mutation, maxEvals(1));

               if (j == 1)
                   meanReplicas = output.mean_iter;
               else
                   meanReplicas = meanReplicas + output.mean_iter;
               end
            end

            meanReplicas = meanReplicas / replicas(i);
            sz = size(meanReplicas);
            plot(linspace(1, sz(1), sz(1)), meanReplicas', 'r');
            
            % F1 DE -------------------------------------------------------
            for j=1:replicas(i)
                output = DE(@test_function_1, dimensions(1), ...
                    lower_bounds(1, :), upper_bounds(1, :), ...
                    structDE.popSize, structDE.crossover, ...
                    structDE.diffWeight, maxEvals(1));

                if (j == 1)
                    meanReplicas = output.mean_iter;
                else
                    meanReplicas = meanReplicas + output.mean_iter;
                end
            end

            meanReplicas = meanReplicas / replicas(i);
            sz = size(meanReplicas);
            plot(linspace(1, sz(1), sz(1)), meanReplicas', 'b');
            
            % F1 PSO ------------------------------------------------------
            for j=1:replicas(i)
                output = PSO(@test_function_1, structPSO.popSize, ...
                    dimensions(1), lower_bounds(1, :), ...
                    upper_bounds(1, :), structPSO.c1, structPSO.c2, ...
                    structPSO.w, maxEvals(1));

                if (j == 1)
                    meanReplicas = output.mean_iter;
                else
                    meanReplicas = meanReplicas + output.mean_iter;
                end
            end

            meanReplicas = meanReplicas / replicas(i);
            sz = size(meanReplicas);
            plot(linspace(1, sz(1), sz(1)), meanReplicas', 'k');
            
            hold off;
            
        % Function 2 ------------------------------------------------------
        elseif arrFunctions(i) == 2
            
        end
    end
end