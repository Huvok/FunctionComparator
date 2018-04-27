function output = DE(fitness, dimensions, lb, ub, popSize, crossoverProb, diffWeight, maxEvals)
    
    % Initialize the population %
    for i=1:dimensions
        population(:,i) = lb(1,i) + (ub(1,i) - lb(1, i)) * rand(popSize,1);
    end
    
    bestSol = zeros(dimensions);
    bestFitness = 9999999999;
    bestFitnessIter = 0;
    
    % Evaluate the fitness of each individual %
    for i=1:popSize
        populationFitness(i) = fitness(population(i,:));
        if (populationFitness(i) < bestFitness)
            bestSol = population(i,:);
            bestFitness = populationFitness(i);
            maxEvals = maxEvals - 1;
        end
    end
    
    mean_iter = mean(populationFitness);
    
    iterCnt = 1;
    while (maxEvals > 0)
        
        % For each individual of the population... %
        for i=1:popSize
            
            % Pick three individuals at random %
            first = 1 + round((popSize - 1) * rand());
            second = 1 + round((popSize - 1) * rand());
            while (second == first)
                second = 1 + round((popSize - 1) * rand());
            end
            
            third = 1 + round((popSize - 1) * rand());
            while (third == first || third == second)
                third = 1 + round((popSize - 1) * rand());
            end
            
            % Pick the dimension to optimize at random %
            R = 1 + round((popSize - 1) * rand());
            
            % Compute the new position, i.e. do mutation and potentially %
            %   a crossover %
            y = zeros(1,dimensions);
            for j=1:dimensions
                r = rand();
                if (r < crossoverProb || i == R)
                    y(j) = population(first,j) + diffWeight * (population(second,j) - population(third,j));
                else
                    y(j) = population(i, j);
                end
            end
            
            population(i, :) = max([min([ub;population(i, :)],[],1);...
                lb],[],1);
            
            % If this child is better, add it to the population %
            fitnessOld = populationFitness(i);
            fitnessNew = fitness(y);
            maxEvals = maxEvals - 1;
            if (fitnessNew < fitnessOld)
                population(i,:) = y;
                populationFitness(i) = fitnessNew;
                if (fitnessNew < bestFitness)
                    bestSol = y;
                    bestFitness = fitnessNew;
                    bestFitnessIter = iterCnt + 1;
                end
            end
        end
        
        mean_iter = cat(1, mean_iter, mean(populationFitness));
        iterCnt = iterCnt + 1;
    end
    
    % Prepare output structure %
    output = struct;
    output(1).Names = {'Samuel Pacheco','Hugo García','Carla Trejo'};
    output(1).IDs = {'A01039815','A00815354','A00813868'};
    output(1).best_sol = bestSol;
    output(1).best_fitness = bestFitness;
    output(1).best_fitness_iter = bestFitnessIter;
    output(1).mean_iter = mean_iter;
    output(1).iter = iterCnt;
end