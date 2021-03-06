function res = FunctionComparator()
    res = struct;
    res(1).Names = {'Samuel Pacheco','Hugo Garc�a','Carla Trejo'};
    res(1).IDs = {'A01039815','A00815354','A00813868'};

    % Especificar las funciones deseadas:
    %   1. Bent Cigar Function
    %   2. Rastrigin�s Function
    %   3. SF2 @300
    %   4. SF2 @400
    %   5. SF2 @500
    %   6. Discus Function
    arrFunctions = [1, 2, 3, 4, 5];
    
    % Cada matriz contiene 6 elementos o 6 renglones, es uno por cada
    %   funci�n, sin respetar el orden elegido arriba es decir,
    %   si en el arreglo arrFunctions se eligi� primero la funci�n 2,
    %   el renglon/elemento a modificar en las siguientes matrices es el
    %   renglon 2, a pesar de que la funci�n 2 sea la primera en evaluarse.
    
    % Especificar el n�mero de r�plicas por funci�n
    replicas = [5, 5, 5, 5, 5, 5];
    
    % Especificar n�mero de dimensiones por funci�n
    dimensions = [5, 5, 5, 5, 5, 5];
    
    % Especificar los lower bounds por dimensi�n, por funci�n
    lower_bounds = [-100 -100 -100 -100 -100;...
        -100 -100 -100 -100 -100;...
        -100 -100 -100 -100 -100;...
        -100 -100 -100 -100 -100;...
        -100 -100 -100 -100 -100;...
        -100 -100 -100 -100 -100;...
        -100 -100 -100 -100 -100];
    
    % Especificar los upper bounds por dimensi�n, por funci�n
    upper_bounds = [100 100 100 100 100;...
        100 100 100 100 100;...
        100 100 100 100 100;...
        100 100 100 100 100;...
        100 100 100 100 100;...
        100 100 100 100 100;...
        100 100 100 100 100];
    
    % Especificar n�mero de evaluaciones m�ximas por funci�n
    maxEvals = [100, 100, 100, 100, 100, 100];
    
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
    
    % ---------------------------------------------------------------------
    % RS
    
    % Tama�o de la poblaci�n
    structRS.popSize = 10;
    
    for i=1:5
        % Function 1 ------------------------------------------------------
        if arrFunctions(i) == 1
            figure('units','normalized','outerposition',[0 0 1 1])
            ESResult = struct;
            ESResult(1).best_fitness = 99999999999999999999;
            DEResult = struct;
            DEResult(1).best_fitness = 99999999999999999999;
            PSOResult = struct;
            PSOResult(1).best_fitness = 99999999999999999999;
            RSResult = struct;
            RSResult(1).best_fitness = 99999999999999999999;
            
            % F1 ES -------------------------------------------------------
            for j=1:replicas(i)
               output = ES(@test_function_1, structES.mu, ...
                   structES.lambda, dimensions(1), lower_bounds(1, :), ...
                   upper_bounds(1, :), structES.crossover, ...
                   structES.mutation, maxEvals(1));

               if (j == 1)
                   meanReplicas = output.mean_iter;
                   ESResult(1).IterationsPerReplica = output.iter;
               else
                   meanReplicas = meanReplicas + output.mean_iter;
               end
               
               if output.best_fitness < ESResult.best_fitness
                   ESResult(1).best_fitness = output.best_fitness;
                   ESResult(1).best_sol = output.best_sol;
                   ESResult(1).best_fitness_iter = ...
                       output.best_fitness_iter;
               end
            end

            res(1).function1(1).ES = ESResult;
            meanReplicasES = meanReplicas / replicas(i);
            
            % F1 DE -------------------------------------------------------
            for j=1:replicas(i)
                output = DE(@test_function_1, dimensions(1), ...
                    lower_bounds(1, :), upper_bounds(1, :), ...
                    structDE.popSize, structDE.crossover, ...
                    structDE.diffWeight, maxEvals(1));

                if (j == 1)
                    meanReplicas = output.mean_iter;
                    DEResult(1).IterationsPerReplica = output.iter;
                else
                    meanReplicas = meanReplicas + output.mean_iter;
                end
                
                if output.best_fitness < DEResult.best_fitness
                    DEResult(1).best_fitness = output.best_fitness;
                    DEResult(1).best_sol = output.best_sol;
                    DEResult(1).best_fitness_iter = ...
                       output.best_fitness_iter;
                end
            end

            res(1).function1(1).DE = DEResult;
            meanReplicasDE = meanReplicas / replicas(i);      
            
            % F1 PSO ------------------------------------------------------
            for j=1:replicas(i)
                output = PSO(@test_function_1, structPSO.popSize, ...
                    dimensions(1), lower_bounds(1, :), ...
                    upper_bounds(1, :), structPSO.c1, structPSO.c2, ...
                    structPSO.w, maxEvals(1));

                if (j == 1)
                    meanReplicas = output.mean_iter;
                    PSOResult(1).IterationsPerReplica = output.iter;
                else
                    meanReplicas = meanReplicas + output.mean_iter;
                end
                
                if output.best_fitness < PSOResult.best_fitness
                    PSOResult(1).best_fitness = output.best_fitness;
                    PSOResult(1).best_sol = output.best_sol;
                    PSOResult(1).best_fitness_iter = ...
                       output.best_fitness_iter;
                end
            end

            res(1).function1(1).PSO = PSOResult;
            meanReplicasPSO = meanReplicas / replicas(i);
            
            % F1 RS -------------------------------------------------------
            for j=1:replicas(i)
                output = RS(@test_function_1, structRS.popSize, ...
                    dimensions(1), lower_bounds(1, :), ...
                    upper_bounds(1, :), maxEvals(1));
                
                if (j == 1)
                    meanReplicas = output.mean_iter;
                    RSResult(1).IterationsPerReplica = output.iter;
                else
                    meanReplicas = meanReplicas + output.mean_iter;
                end
                
                if output.best_fitness < RSResult.best_fitness
                    RSResult(1).best_fitness = output.best_fitness;
                    RSResult(1).best_sol = output.best_sol;
                    RSResult(1).best_fitness_iter = ...
                       output.best_fitness_iter;
                end
            end

            res(1).function1(1).RS = RSResult;
            meanReplicasRS = meanReplicas / replicas(i);
            
            loglog(1:length(meanReplicasES), meanReplicasES', 'r',...
                1:length(meanReplicasDE), meanReplicasDE', 'b',...
                1:length(meanReplicasPSO), meanReplicasPSO', 'k',...
                1:length(meanReplicasRS), meanReplicasRS', 'g')
            legend("ES", "DE", "PSO", "RS");
            title('Bent Cigar Function');
            
        % Function 2 ------------------------------------------------------
        elseif arrFunctions(i) == 2
            figure('units','normalized','outerposition',[0 0 1 1])
            ESResult = struct;
            ESResult(1).best_fitness = 99999999999999999999;
            DEResult = struct;
            DEResult(1).best_fitness = 99999999999999999999;
            PSOResult = struct;
            PSOResult(1).best_fitness = 99999999999999999999;
            RSResult = struct;
            RSResult(1).best_fitness = 99999999999999999999;
            
            % F2 ES -------------------------------------------------------
            for j=1:replicas(i)
               output = ES(@test_function_2, structES.mu, ...
                   structES.lambda, dimensions(2), lower_bounds(2, :), ...
                   upper_bounds(2, :), structES.crossover, ...
                   structES.mutation, maxEvals(2));

               if (j == 1)
                   meanReplicas = output.mean_iter;
                   ESResult(1).IterationsPerReplica = output.iter;
               else
                   meanReplicas = meanReplicas + output.mean_iter;
               end
               
               if output.best_fitness < ESResult.best_fitness
                   ESResult(1).best_fitness = output.best_fitness;
                   ESResult(1).best_sol = output.best_sol;
                   ESResult(1).best_fitness_iter = ...
                       output.best_fitness_iter;
               end
            end
               
            res(1).function2(1).ES = ESResult;
            meanReplicasES = meanReplicas / replicas(i);
            
            % F2 DE -------------------------------------------------------
            for j=1:replicas(i)
                output = DE(@test_function_2, dimensions(2), ...
                    lower_bounds(2, :), upper_bounds(2, :), ...
                    structDE.popSize, structDE.crossover, ...
                    structDE.diffWeight, maxEvals(2));

                if (j == 1)
                    meanReplicas = output.mean_iter;
                    DEResult(1).IterationsPerReplica = output.iter;
                else
                    meanReplicas = meanReplicas + output.mean_iter;
                end
                
                if output.best_fitness < DEResult.best_fitness
                    DEResult(1).best_fitness = output.best_fitness;
                    DEResult(1).best_sol = output.best_sol;
                    DEResult(1).best_fitness_iter = ...
                       output.best_fitness_iter;
                end
            end

            res(1).function2(1).DE = DEResult;
            meanReplicasDE = meanReplicas / replicas(i);
            
            % F2 PSO ------------------------------------------------------
            for j=1:replicas(i)
                output = PSO(@test_function_2, structPSO.popSize, ...
                    dimensions(2), lower_bounds(2, :), ...
                    upper_bounds(2, :), structPSO.c1, structPSO.c2, ...
                    structPSO.w, maxEvals(2));

                if (j == 1)
                    meanReplicas = output.mean_iter;
                    PSOResult(1).IterationsPerReplica = output.iter;
                else
                    meanReplicas = meanReplicas + output.mean_iter;
                end
                
                if output.best_fitness < PSOResult.best_fitness
                    PSOResult(1).best_fitness = output.best_fitness;
                    PSOResult(1).best_sol = output.best_sol;
                    PSOResult(1).best_fitness_iter = ...
                       output.best_fitness_iter;
                end
            end

            res(1).function2(1).PSO = PSOResult;
            meanReplicasPSO = meanReplicas / replicas(i);
            
            % F2 RS -------------------------------------------------------
            for j=1:replicas(i)
                output = RS(@test_function_2, structRS.popSize, ...
                    dimensions(2), lower_bounds(2, :), ...
                    upper_bounds(2, :), maxEvals(2));
                
                if (j == 1)
                    meanReplicas = output.mean_iter;
                    RSResult(1).IterationsPerReplica = output.iter;
                else
                    meanReplicas = meanReplicas + output.mean_iter;
                end
                
                if output.best_fitness < RSResult.best_fitness
                    RSResult(1).best_fitness = output.best_fitness;
                    RSResult(1).best_sol = output.best_sol;
                    RSResult(1).best_fitness_iter = ...
                       output.best_fitness_iter;
                end
            end

            res(1).function2(1).RS = RSResult;
            meanReplicasRS = meanReplicas / replicas(i);
            
            loglog(1:length(meanReplicasES), meanReplicasES', 'r',...
                1:length(meanReplicasDE), meanReplicasDE', 'b',...
                1:length(meanReplicasPSO), meanReplicasPSO', 'k',...
                1:length(meanReplicasRS), meanReplicasRS', 'g')
            legend("ES", "DE", "PSO", "RS");
            title('Rastrigin�s Function');
            
        elseif arrFunctions(i) == 3
            figure('units','normalized','outerposition',[0 0 1 1])
            ESResult = struct;
            ESResult(1).best_fitness = 99999999999999999999;
            DEResult = struct;
            DEResult(1).best_fitness = 99999999999999999999;
            PSOResult = struct;
            PSOResult(1).best_fitness = 99999999999999999999;
            RSResult = struct;
            RSResult(1).best_fitness = 99999999999999999999;
            
            % F3 ES -------------------------------------------------------
            for j=1:replicas(i)
               output = ES(@test_function_3, structES.mu, ...
                   structES.lambda, dimensions(3), lower_bounds(3, :), ...
                   upper_bounds(3, :), structES.crossover, ...
                   structES.mutation, maxEvals(3));

               if (j == 1)
                   meanReplicas = output.mean_iter;
                   ESResult(1).IterationsPerReplica = output.iter;
               else
                   meanReplicas = meanReplicas + output.mean_iter;
               end
               
               if output.best_fitness < ESResult.best_fitness
                   ESResult(1).best_fitness = output.best_fitness;
                   ESResult(1).best_sol = output.best_sol;
                   ESResult(1).best_fitness_iter = ...
                       output.best_fitness_iter;
               end
            end

            res(1).function3(1).ES = ESResult;
            meanReplicasES = meanReplicas / replicas(i);
            
            % F3 DE -------------------------------------------------------
            for j=1:replicas(i)
                output = DE(@test_function_3, dimensions(3), ...
                    lower_bounds(3, :), upper_bounds(3, :), ...
                    structDE.popSize, structDE.crossover, ...
                    structDE.diffWeight, maxEvals(3));

                if (j == 1)
                    meanReplicas = output.mean_iter;
                    DEResult(1).IterationsPerReplica = output.iter;
                else
                    meanReplicas = meanReplicas + output.mean_iter;
                end
                
                if output.best_fitness < DEResult.best_fitness
                    DEResult(1).best_fitness = output.best_fitness;
                    DEResult(1).best_sol = output.best_sol;
                    DEResult(1).best_fitness_iter = ...
                       output.best_fitness_iter;
                end
            end

            res(1).function3(1).DE = DEResult;
            meanReplicasDE = meanReplicas / replicas(i);
            
            % F3 PSO ------------------------------------------------------
            for j=1:replicas(i)
                output = PSO(@test_function_3, structPSO.popSize, ...
                    dimensions(3), lower_bounds(3, :), ...
                    upper_bounds(3, :), structPSO.c1, structPSO.c2, ...
                    structPSO.w, maxEvals(3));

                if (j == 1)
                    meanReplicas = output.mean_iter;
                    PSOResult(1).IterationsPerReplica = output.iter;
                else
                    meanReplicas = meanReplicas + output.mean_iter;
                end
                
                if output.best_fitness < PSOResult.best_fitness
                    PSOResult(1).best_fitness = output.best_fitness;
                    PSOResult(1).best_sol = output.best_sol;
                    PSOResult(1).best_fitness_iter = ...
                       output.best_fitness_iter;
                end
            end

            res(1).function3(1).PSO = PSOResult;
            meanReplicasPSO = meanReplicas / replicas(i);
            
            % F3 RS -------------------------------------------------------
            for j=1:replicas(i)
                output = RS(@test_function_3, structRS.popSize, ...
                    dimensions(3), lower_bounds(3, :), ...
                    upper_bounds(3, :), maxEvals(3));
                
                if (j == 1)
                    meanReplicas = output.mean_iter;
                    RSResult(1).IterationsPerReplica = output.iter;
                else
                    meanReplicas = meanReplicas + output.mean_iter;
                end
                
                if output.best_fitness < RSResult.best_fitness
                    RSResult(1).best_fitness = output.best_fitness;
                    RSResult(1).best_sol = output.best_sol;
                    RSResult(1).best_fitness_iter = ...
                       output.best_fitness_iter;
                end
            end

            res(1).function3(1).RS = RSResult;
            meanReplicasRS = meanReplicas / replicas(i);
            
             loglog(1:length(meanReplicasES), meanReplicasES', 'r',...
                1:length(meanReplicasDE), meanReplicasDE', 'b',...
                1:length(meanReplicasPSO), meanReplicasPSO', 'k',...
                1:length(meanReplicasRS), meanReplicasRS', 'g')
            legend("ES", "DE", "PSO", "RS");
            title('SF2 @300');
            
        elseif arrFunctions(i) == 4
            figure('units','normalized','outerposition',[0 0 1 1])
            ESResult = struct;
            ESResult(1).best_fitness = 99999999999999999999;
            DEResult = struct;
            DEResult(1).best_fitness = 99999999999999999999;
            PSOResult = struct;
            PSOResult(1).best_fitness = 99999999999999999999;
            RSResult = struct;
            RSResult(1).best_fitness = 99999999999999999999;
            
            % F4 ES -------------------------------------------------------
            for j=1:replicas(i)
               output = ES(@test_function_4, structES.mu, ...
                   structES.lambda, dimensions(4), lower_bounds(4, :), ...
                   upper_bounds(4, :), structES.crossover, ...
                   structES.mutation, maxEvals(4));

               if (j == 1)
                   meanReplicas = output.mean_iter;
                   ESResult(1).IterationsPerReplica = output.iter;
               else
                   meanReplicas = meanReplicas + output.mean_iter;
               end
               
               if output.best_fitness < ESResult.best_fitness
                   ESResult(1).best_fitness = output.best_fitness;
                   ESResult(1).best_sol = output.best_sol;
                   ESResult(1).best_fitness_iter = ...
                       output.best_fitness_iter;
               end
            end

            res(1).function4(1).ES = ESResult;
            meanReplicasES = meanReplicas / replicas(i);
            
            % F4 DE -------------------------------------------------------
            for j=1:replicas(i)
                output = DE(@test_function_4, dimensions(4), ...
                    lower_bounds(4, :), upper_bounds(4, :), ...
                    structDE.popSize, structDE.crossover, ...
                    structDE.diffWeight, maxEvals(4));

                if (j == 1)
                    meanReplicas = output.mean_iter;
                    DEResult(1).IterationsPerReplica = output.iter;
                else
                    meanReplicas = meanReplicas + output.mean_iter;
                end
                
                if output.best_fitness < DEResult.best_fitness
                    DEResult(1).best_fitness = output.best_fitness;
                    DEResult(1).best_sol = output.best_sol;
                    DEResult(1).best_fitness_iter = ...
                       output.best_fitness_iter;
                end
            end

            res(1).function4(1).DE = DEResult;
            meanReplicasDE = meanReplicas / replicas(i);
            
            % F4 PSO ------------------------------------------------------
            for j=1:replicas(i)
                output = PSO(@test_function_4, structPSO.popSize, ...
                    dimensions(4), lower_bounds(4, :), ...
                    upper_bounds(4, :), structPSO.c1, structPSO.c2, ...
                    structPSO.w, maxEvals(4));

                if (j == 1)
                    meanReplicas = output.mean_iter;
                    PSOResult(1).IterationsPerReplica = output.iter;
                else
                    meanReplicas = meanReplicas + output.mean_iter;
                end
                
                if output.best_fitness < PSOResult.best_fitness
                    PSOResult(1).best_fitness = output.best_fitness;
                    PSOResult(1).best_sol = output.best_sol;
                    PSOResult(1).best_fitness_iter = ...
                       output.best_fitness_iter;
                end
            end

            res(1).function4(1).PSO = PSOResult;
            meanReplicasPSO = meanReplicas / replicas(i);
            
            % F4 RS -------------------------------------------------------
            for j=1:replicas(i)
                output = RS(@test_function_4, structRS.popSize, ...
                    dimensions(4), lower_bounds(4, :), ...
                    upper_bounds(4, :), maxEvals(4));
                
                if (j == 1)
                    meanReplicas = output.mean_iter;
                    RSResult(1).IterationsPerReplica = output.iter;
                else
                    meanReplicas = meanReplicas + output.mean_iter;
                end
                
                if output.best_fitness < RSResult.best_fitness
                    RSResult(1).best_fitness = output.best_fitness;
                    RSResult(1).best_sol = output.best_sol;
                    RSResult(1).best_fitness_iter = ...
                       output.best_fitness_iter;
                end
            end

            res(1).function4(1).RS = RSResult;
            meanReplicasRS = meanReplicas / replicas(i);
            
            loglog(1:length(meanReplicasES), meanReplicasES', 'r',...
                1:length(meanReplicasDE), meanReplicasDE', 'b',...
                1:length(meanReplicasPSO), meanReplicasPSO', 'k',...
                1:length(meanReplicasRS), meanReplicasRS', 'g')
            legend("ES", "DE", "PSO", "RS");
            title('SF2 @400');
            
        elseif arrFunctions(i) == 5
            figure('units','normalized','outerposition',[0 0 1 1])
            ESResult = struct;
            ESResult(1).best_fitness = 99999999999999999999;
            DEResult = struct;
            DEResult(1).best_fitness = 99999999999999999999;
            PSOResult = struct;
            PSOResult(1).best_fitness = 99999999999999999999;
            RSResult = struct;
            RSResult(1).best_fitness = 99999999999999999999;
            
            % F5 ES -------------------------------------------------------
            for j=1:replicas(i)
               output = ES(@test_function_5, structES.mu, ...
                   structES.lambda, dimensions(5), lower_bounds(5, :), ...
                   upper_bounds(5, :), structES.crossover, ...
                   structES.mutation, maxEvals(5));

               if (j == 1)
                   meanReplicas = output.mean_iter;
                   ESResult(1).IterationsPerReplica = output.iter;
               else
                   meanReplicas = meanReplicas + output.mean_iter;
               end
               
               if output.best_fitness < ESResult.best_fitness
                   ESResult(1).best_fitness = output.best_fitness;
                   ESResult(1).best_sol = output.best_sol;
                   ESResult(1).best_fitness_iter = ...
                       output.best_fitness_iter;
               end
            end

            res(1).function5(1).ES = ESResult;
            meanReplicasES = meanReplicas / replicas(i);
            
            % F5 DE -------------------------------------------------------
            for j=1:replicas(i)
                output = DE(@test_function_5, dimensions(5), ...
                    lower_bounds(5, :), upper_bounds(5, :), ...
                    structDE.popSize, structDE.crossover, ...
                    structDE.diffWeight, maxEvals(5));

                if (j == 1)
                    meanReplicas = output.mean_iter;
                    DEResult(1).IterationsPerReplica = output.iter;
                else
                    meanReplicas = meanReplicas + output.mean_iter;
                end
                
                if output.best_fitness < DEResult.best_fitness
                    DEResult(1).best_fitness = output.best_fitness;
                    DEResult(1).best_sol = output.best_sol;
                    DEResult(1).best_fitness_iter = ...
                       output.best_fitness_iter;
                end
            end

            res(1).function5(1).DE = DEResult;
            meanReplicasDE = meanReplicas / replicas(i);
            
            % F5 PSO ------------------------------------------------------
            for j=1:replicas(i)
                output = PSO(@test_function_5, structPSO.popSize, ...
                    dimensions(5), lower_bounds(5, :), ...
                    upper_bounds(5, :), structPSO.c1, structPSO.c2, ...
                    structPSO.w, maxEvals(5));

                if (j == 1)
                    meanReplicas = output.mean_iter;
                    PSOResult(1).IterationsPerReplica = output.iter;
                else
                    meanReplicas = meanReplicas + output.mean_iter;
                end
                
                if output.best_fitness < PSOResult.best_fitness
                    PSOResult(1).best_fitness = output.best_fitness;
                    PSOResult(1).best_sol = output.best_sol;
                    PSOResult(1).best_fitness_iter = ...
                       output.best_fitness_iter;
                end
            end

            res(1).function5(1).PSO = PSOResult;
            meanReplicasPSO = meanReplicas / replicas(i);
            
            % F5 RS -------------------------------------------------------
            for j=1:replicas(i)
                output = RS(@test_function_5, structRS.popSize, ...
                    dimensions(5), lower_bounds(5, :), ...
                    upper_bounds(5, :), maxEvals(5));
                
                if (j == 1)
                    meanReplicas = output.mean_iter;
                    RSResult(1).IterationsPerReplica = output.iter;
                else
                    meanReplicas = meanReplicas + output.mean_iter;
                end
                
                if output.best_fitness < RSResult.best_fitness
                    RSResult(1).best_fitness = output.best_fitness;
                    RSResult(1).best_sol = output.best_sol;
                    RSResult(1).best_fitness_iter = ...
                       output.best_fitness_iter;
                end
            end

            res(1).function5(1).RS = RSResult;
            meanReplicasRS = meanReplicas / replicas(i);
            
            loglog(1:length(meanReplicasES), meanReplicasES', 'r',...
                1:length(meanReplicasDE), meanReplicasDE', 'b',...
                1:length(meanReplicasPSO), meanReplicasPSO', 'k',...
                1:length(meanReplicasRS), meanReplicasRS', 'g')
            legend("ES", "DE", "PSO", "RS");
            title('SF2 @500');
            
        elseif arrFunctions(i) == 6
            figure('units','normalized','outerposition',[0 0 1 1])
            ESResult = struct;
            ESResult(1).best_fitness = 99999999999999999999;
            DEResult = struct;
            DEResult(1).best_fitness = 99999999999999999999;
            PSOResult = struct;
            PSOResult(1).best_fitness = 99999999999999999999;
            RSResult = struct;
            RSResult(1).best_fitness = 99999999999999999999;
            
            % F6 ES -------------------------------------------------------
            for j=1:replicas(i)
               output = ES(@test_function_6, structES.mu, ...
                   structES.lambda, dimensions(6), lower_bounds(6, :), ...
                   upper_bounds(6, :), structES.crossover, ...
                   structES.mutation, maxEvals(6));

               if (j == 1)
                   meanReplicas = output.mean_iter;
                   ESResult(1).IterationsPerReplica = output.iter;
               else
                   meanReplicas = meanReplicas + output.mean_iter;
               end
               
               if output.best_fitness < ESResult.best_fitness
                   ESResult(1).best_fitness = output.best_fitness;
                   ESResult(1).best_sol = output.best_sol;
                   ESResult(1).best_fitness_iter = ...
                       output.best_fitness_iter;
               end
            end

            res(1).function6(1).ES = ESResult;
            meanReplicasES = meanReplicas / replicas(i);
            
            % F6 DE -------------------------------------------------------
            for j=1:replicas(i)
                output = DE(@test_function_6, dimensions(6), ...
                    lower_bounds(6, :), upper_bounds(6, :), ...
                    structDE.popSize, structDE.crossover, ...
                    structDE.diffWeight, maxEvals(6));

                if (j == 1)
                    meanReplicas = output.mean_iter;
                    DEResult(1).IterationsPerReplica = output.iter;
                else
                    meanReplicas = meanReplicas + output.mean_iter;
                end
                
                if output.best_fitness < DEResult.best_fitness
                    DEResult(1).best_fitness = output.best_fitness;
                    DEResult(1).best_sol = output.best_sol;
                    DEResult(1).best_fitness_iter = ...
                       output.best_fitness_iter;
                end
            end

            res(1).function6(1).DE = DEResult;
            meanReplicasDE = meanReplicas / replicas(i);
            
            % F6 PSO ------------------------------------------------------
            for j=1:replicas(i)
                output = PSO(@test_function_6, structPSO.popSize, ...
                    dimensions(6), lower_bounds(6, :), ...
                    upper_bounds(6, :), structPSO.c1, structPSO.c2, ...
                    structPSO.w, maxEvals(6));

                if (j == 1)
                    meanReplicas = output.mean_iter;
                    PSOResult(1).IterationsPerReplica = output.iter;
                else
                    meanReplicas = meanReplicas + output.mean_iter;
                end
                
                if output.best_fitness < PSOResult.best_fitness
                    PSOResult(1).best_fitness = output.best_fitness;
                    PSOResult(1).best_sol = output.best_sol;
                    PSOResult(1).best_fitness_iter = ...
                       output.best_fitness_iter;
                end
            end

            res(1).function6(1).PSO = PSOResult;
            meanReplicasPSO = meanReplicas / replicas(i);
            
            % F6 RS -------------------------------------------------------
            for j=1:replicas(i)
                output = RS(@test_function_6, structRS.popSize, ...
                    dimensions(6), lower_bounds(6, :), ...
                    upper_bounds(6, :), maxEvals(6));
                
                if (j == 1)
                    meanReplicas = output.mean_iter;
                    RSResult(1).IterationsPerReplica = output.iter;
                else
                    meanReplicas = meanReplicas + output.mean_iter;
                end
                
                if output.best_fitness < RSResult.best_fitness
                    RSResult(1).best_fitness = output.best_fitness;
                    RSResult(1).best_sol = output.best_sol;
                    RSResult(1).best_fitness_iter = ...
                       output.best_fitness_iter;
                end
            end

            res(1).function6(1).RS = RSResult;
            meanReplicasRS = meanReplicas / replicas(i);
            
            loglog(1:length(meanReplicasES), meanReplicasES', 'r',...
                1:length(meanReplicasDE), meanReplicasDE', 'b',...
                1:length(meanReplicasPSO), meanReplicasPSO', 'k',...
                1:length(meanReplicasRS), meanReplicasRS', 'g')
            legend("ES", "DE", "PSO", "RS");
            title('Discus Function');
            
        end
    end
    
end