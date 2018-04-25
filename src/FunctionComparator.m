function FunctionComparator()
    % Especificar las funciones deseadas:
    %   1. Bent Cigar Function
    %   2. 
    arrFunctions = [1, 2, 3, 4, 5];
    
    % Especificar el número de réplicas por función
    replicas = [5, 5, 5, 5, 5];
    
    % Especificar número de dimensiones por función
    dimensions = [10, 10, 10, 10, 10];
    
    % Especificar los lower bounds por dimensión, por función
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
    
    % Especificar los upper bounds por dimensión, por función
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
    
    % Especificar número de evaluaciones máximas por función
    maxEvals = [1000, 1000, 100, 1000, 1000];
    
    % ---------------------------------------------------------------------
    % ES
    
    % Mu para ES (Tamaño de población)
    structES.mu = 10;
    
    % Lambda para ES (Hijos a producir)
    structES.lambda = 10;
    
    % Probabilidad de cruza
    structES.crossover = .5;
    
    % Probabilidad de mutación
    structES.mutation = .5;
    
    % ---------------------------------------------------------------------
    % DE
    
    % Tamaño de la población
    structDE.popSize = 10;
    
    % Probabilidad de cruza
    structDE.crossover = .5;
    
    % Peso diferencial
    structDE.diffWeight = .5;
    
    % ---------------------------------------------------------------------
    % PSO
    
    % Tamaño de la población
    structPSO.popSize = 10;
    
    % c1
    structPSO.c1 = 2;
    
    % c2
    structPSO.c2 = 2;
    
    % w
    structPSO.w = .7;
    
    % ---------------------------------------------------------------------
    % RS
    
    % Tamaño de la población
    structRS.popSize = 10;
    
    for i=1:5 
        % Function 1 ------------------------------------------------------
        if arrFunctions(i) == 1
            figure('units','normalized','outerposition',[0 0 1 1])
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
            
            % F1 RS -------------------------------------------------------
            for j=1:replicas(i)
                output = RS(@test_function_1, structRS.popSize, ...
                    dimensions(1), lower_bounds(1, :), ...
                    upper_bounds(1, :), maxEvals(1));
                
                if (j == 1)
                    meanReplicas = output.mean_iter;
                else
                    meanReplicas = meanReplicas + output.mean_iter;
                end
            end

            meanReplicas = meanReplicas / replicas(i);
            sz = size(meanReplicas);
            plot(linspace(1, sz(1), sz(1)), meanReplicas', 'g');
            
            legend("ES", "DE", "PSO", "RS");
            hold off;
            
        % Function 2 ------------------------------------------------------
        elseif arrFunctions(i) == 2
            figure('units','normalized','outerposition',[0 0 1 1])
            % F2 ES -------------------------------------------------------
            hold on;
            for j=1:replicas(i)
               output = ES(@test_function_2, structES.mu, ...
                   structES.lambda, dimensions(2), lower_bounds(2, :), ...
                   upper_bounds(2, :), structES.crossover, ...
                   structES.mutation, maxEvals(2));

               if (j == 1)
                   meanReplicas = output.mean_iter;
               else
                   meanReplicas = meanReplicas + output.mean_iter;
               end
            end

            meanReplicas = meanReplicas / replicas(i);
            sz = size(meanReplicas);
            plot(linspace(1, sz(1), sz(1)), meanReplicas', 'r');
            
            % F2 DE -------------------------------------------------------
            for j=1:replicas(i)
                output = DE(@test_function_2, dimensions(2), ...
                    lower_bounds(2, :), upper_bounds(2, :), ...
                    structDE.popSize, structDE.crossover, ...
                    structDE.diffWeight, maxEvals(2));

                if (j == 1)
                    meanReplicas = output.mean_iter;
                else
                    meanReplicas = meanReplicas + output.mean_iter;
                end
            end

            meanReplicas = meanReplicas / replicas(i);
            sz = size(meanReplicas);
            plot(linspace(1, sz(1), sz(1)), meanReplicas', 'b');
            
            % F2 PSO ------------------------------------------------------
            for j=1:replicas(i)
                output = PSO(@test_function_2, structPSO.popSize, ...
                    dimensions(2), lower_bounds(2, :), ...
                    upper_bounds(2, :), structPSO.c1, structPSO.c2, ...
                    structPSO.w, maxEvals(2));

                if (j == 1)
                    meanReplicas = output.mean_iter;
                else
                    meanReplicas = meanReplicas + output.mean_iter;
                end
            end

            meanReplicas = meanReplicas / replicas(i);
            sz = size(meanReplicas);
            plot(linspace(1, sz(1), sz(1)), meanReplicas', 'k');
            
            % F2 RS -------------------------------------------------------
            for j=1:replicas(i)
                output = RS(@test_function_2, structRS.popSize, ...
                    dimensions(2), lower_bounds(2, :), ...
                    upper_bounds(2, :), maxEvals(2));
                
                if (j == 1)
                    meanReplicas = output.mean_iter;
                else
                    meanReplicas = meanReplicas + output.mean_iter;
                end
            end

            meanReplicas = meanReplicas / replicas(i);
            sz = size(meanReplicas);
            plot(linspace(1, sz(1), sz(1)), meanReplicas', 'g');
            
            legend("ES", "DE", "PSO", "RS");
            hold off;
            
        elseif arrFunctions(i) == 3
            figure('units','normalized','outerposition',[0 0 1 1])
            % F3 ES -------------------------------------------------------
            hold on;
            for j=1:replicas(i)
               output = ES(@test_function_3, structES.mu, ...
                   structES.lambda, dimensions(3), lower_bounds(3, :), ...
                   upper_bounds(3, :), structES.crossover, ...
                   structES.mutation, maxEvals(3));

               if (j == 1)
                   meanReplicas = output.mean_iter;
               else
                   meanReplicas = meanReplicas + output.mean_iter;
               end
            end

            meanReplicas = meanReplicas / replicas(i);
            sz = size(meanReplicas);
            plot(linspace(1, sz(1), sz(1)), meanReplicas', 'r');
            
            % F3 DE -------------------------------------------------------
            for j=1:replicas(i)
                output = DE(@test_function_3, dimensions(3), ...
                    lower_bounds(3, :), upper_bounds(3, :), ...
                    structDE.popSize, structDE.crossover, ...
                    structDE.diffWeight, maxEvals(3));

                if (j == 1)
                    meanReplicas = output.mean_iter;
                else
                    meanReplicas = meanReplicas + output.mean_iter;
                end
            end

            meanReplicas = meanReplicas / replicas(i);
            sz = size(meanReplicas);
            plot(linspace(1, sz(1), sz(1)), meanReplicas', 'b');
            
            % F3 PSO ------------------------------------------------------
            for j=1:replicas(i)
                output = PSO(@test_function_3, structPSO.popSize, ...
                    dimensions(3), lower_bounds(3, :), ...
                    upper_bounds(3, :), structPSO.c1, structPSO.c2, ...
                    structPSO.w, maxEvals(3));

                if (j == 1)
                    meanReplicas = output.mean_iter;
                else
                    meanReplicas = meanReplicas + output.mean_iter;
                end
            end

            meanReplicas = meanReplicas / replicas(i);
            sz = size(meanReplicas);
            plot(linspace(1, sz(1), sz(1)), meanReplicas', 'k');
            
            % F3 RS -------------------------------------------------------
            for j=1:replicas(i)
                output = RS(@test_function_3, structRS.popSize, ...
                    dimensions(3), lower_bounds(3, :), ...
                    upper_bounds(3, :), maxEvals(3));
                
                if (j == 1)
                    meanReplicas = output.mean_iter;
                else
                    meanReplicas = meanReplicas + output.mean_iter;
                end
            end

            meanReplicas = meanReplicas / replicas(i);
            sz = size(meanReplicas);
            plot(linspace(1, sz(1), sz(1)), meanReplicas', 'g');
            
            legend("ES", "DE", "PSO", "RS");
            hold off;
        elseif arrFunctions(i) == 4
            figure('units','normalized','outerposition',[0 0 1 1])
            % F4 ES -------------------------------------------------------
            hold on;
            for j=1:replicas(i)
               output = ES(@test_function_4, structES.mu, ...
                   structES.lambda, dimensions(4), lower_bounds(4, :), ...
                   upper_bounds(4, :), structES.crossover, ...
                   structES.mutation, maxEvals(4));

               if (j == 1)
                   meanReplicas = output.mean_iter;
               else
                   meanReplicas = meanReplicas + output.mean_iter;
               end
            end

            meanReplicas = meanReplicas / replicas(i);
            sz = size(meanReplicas);
            plot(linspace(1, sz(1), sz(1)), meanReplicas', 'r');
            
            % F4 DE -------------------------------------------------------
            for j=1:replicas(i)
                output = DE(@test_function_4, dimensions(4), ...
                    lower_bounds(4, :), upper_bounds(4, :), ...
                    structDE.popSize, structDE.crossover, ...
                    structDE.diffWeight, maxEvals(4));

                if (j == 1)
                    meanReplicas = output.mean_iter;
                else
                    meanReplicas = meanReplicas + output.mean_iter;
                end
            end

            meanReplicas = meanReplicas / replicas(i);
            sz = size(meanReplicas);
            plot(linspace(1, sz(1), sz(1)), meanReplicas', 'b');
            
            % F4 PSO ------------------------------------------------------
            for j=1:replicas(i)
                output = PSO(@test_function_4, structPSO.popSize, ...
                    dimensions(4), lower_bounds(4, :), ...
                    upper_bounds(4, :), structPSO.c1, structPSO.c2, ...
                    structPSO.w, maxEvals(4));

                if (j == 1)
                    meanReplicas = output.mean_iter;
                else
                    meanReplicas = meanReplicas + output.mean_iter;
                end
            end

            meanReplicas = meanReplicas / replicas(i);
            sz = size(meanReplicas);
            plot(linspace(1, sz(1), sz(1)), meanReplicas', 'k');
            
            % F2 RS -------------------------------------------------------
            for j=1:replicas(i)
                output = RS(@test_function_4, structRS.popSize, ...
                    dimensions(4), lower_bounds(4, :), ...
                    upper_bounds(4, :), maxEvals(4));
                
                if (j == 1)
                    meanReplicas = output.mean_iter;
                else
                    meanReplicas = meanReplicas + output.mean_iter;
                end
            end

            meanReplicas = meanReplicas / replicas(i);
            sz = size(meanReplicas);
            plot(linspace(1, sz(1), sz(1)), meanReplicas', 'g');
            
            legend("ES", "DE", "PSO", "RS");
            hold off;
            
        elseif arrFunctions(i) == 5
            figure('units','normalized','outerposition',[0 0 1 1])
            % F5 ES -------------------------------------------------------
            hold on;
            for j=1:replicas(i)
               output = ES(@test_function_5, structES.mu, ...
                   structES.lambda, dimensions(5), lower_bounds(5, :), ...
                   upper_bounds(5, :), structES.crossover, ...
                   structES.mutation, maxEvals(5));

               if (j == 1)
                   meanReplicas = output.mean_iter;
               else
                   meanReplicas = meanReplicas + output.mean_iter;
               end
            end

            meanReplicas = meanReplicas / replicas(i);
            sz = size(meanReplicas);
            plot(linspace(1, sz(1), sz(1)), meanReplicas', 'r');
            
            % F5 DE -------------------------------------------------------
            for j=1:replicas(i)
                output = DE(@test_function_5, dimensions(5), ...
                    lower_bounds(5, :), upper_bounds(5, :), ...
                    structDE.popSize, structDE.crossover, ...
                    structDE.diffWeight, maxEvals(5));

                if (j == 1)
                    meanReplicas = output.mean_iter;
                else
                    meanReplicas = meanReplicas + output.mean_iter;
                end
            end

            meanReplicas = meanReplicas / replicas(i);
            sz = size(meanReplicas);
            plot(linspace(1, sz(1), sz(1)), meanReplicas', 'b');
            
            % F5 PSO ------------------------------------------------------
            for j=1:replicas(i)
                output = PSO(@test_function_5, structPSO.popSize, ...
                    dimensions(5), lower_bounds(5, :), ...
                    upper_bounds(5, :), structPSO.c1, structPSO.c2, ...
                    structPSO.w, maxEvals(5));

                if (j == 1)
                    meanReplicas = output.mean_iter;
                else
                    meanReplicas = meanReplicas + output.mean_iter;
                end
            end

            meanReplicas = meanReplicas / replicas(i);
            sz = size(meanReplicas);
            plot(linspace(1, sz(1), sz(1)), meanReplicas', 'k');
            
            % F5 RS -------------------------------------------------------
            for j=1:replicas(i)
                output = RS(@test_function_5, structRS.popSize, ...
                    dimensions(5), lower_bounds(5, :), ...
                    upper_bounds(5, :), maxEvals(5));
                
                if (j == 1)
                    meanReplicas = output.mean_iter;
                else
                    meanReplicas = meanReplicas + output.mean_iter;
                end
            end

            meanReplicas = meanReplicas / replicas(i);
            sz = size(meanReplicas);
            plot(linspace(1, sz(1), sz(1)), meanReplicas', 'g');
            
            legend("ES", "DE", "PSO", "RS");
            hold off;
        end
    end
end