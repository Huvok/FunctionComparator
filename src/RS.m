function output = RS(fitnessFun, popSize, nVars, lowerBound, upperBound,...
    maxEvals)

    start = clock;

    population = repmat(upperBound - lowerBound, popSize, 1) .* ...
        rand(popSize, nVars) + repmat(lowerBound, popSize, 1);
    fitness_pop = zeros(popSize, 1);

    evaluations = 0;
    for l = 1:popSize
        fitness_pop(l) = feval(fitnessFun, population(l,:));
        evaluations = evaluations + 1;
    end
    
    if maxEvals > evaluations
        stop = false;
    else
        stop = true;
    end

    bestIter = min(fitness_pop);
    meanIter = mean(fitness_pop);
    iterCnt = 0;
    best = min(fitness_pop);
    best_fitness_iter = 0;

    while ~stop
        for l = 1:popSize
            % Generar una solución aleatoria
            candidate = lowerBound + (upperBound - ...
                lowerBound) .* rand(1, nVars);
            candidate_fitness = feval(fitnessFun, candidate);

            % Si el candidato es mejor, actualizar
            if candidate_fitness < fitness_pop(l)
                population(l, :) = candidate;
                fitness_pop(l) = candidate_fitness;
            end
            
            if candidate_fitness < best
                best = candidate_fitness;
                best_fitness_iter = iterCnt + 1;
            end


            evaluations = evaluations + 1;
            if maxEvals == evaluations
                stop = true;
                break;
            end
        end

        bestIter = cat(1,bestIter,min(fitness_pop));
        meanIter = cat(1,meanIter,mean(fitness_pop));
        iterCnt = iterCnt + 1;
    end

    [~,idx] = min(fitness_pop);

    output = struct;
    output(1).Students = {'Samuel Pacheco','Hugo García','Carla Trejo'};
    output(1).IDs = {'A01039815','A00815354','A00813868'};
    output(1).best_sol = population(idx,:);
    output(1).best_fitness = fitness_pop(idx);
    output(1).best_iter = bestIter;
    output(1).mean_iter = meanIter;
    output(1).evaluations = evaluations;
    output(1).time = etime(clock,start);
    output(1).iter = iterCnt;
    output(1).best_fitness_iter = best_fitness_iter;

end