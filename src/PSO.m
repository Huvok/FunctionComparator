function output = PSO(fitnessFun, popSize, nVars, lowerBound,upperBound,...
    c1, c2, w, maxEvals)

start = clock;

positions = repmat(upperBound - lowerBound, popSize, 1) .* rand(popSize, nVars) +...
    repmat(lowerBound, popSize, 1);
population = positions;
velocities = zeros(popSize, nVars);
fitness_pop = zeros(popSize, 1);

evaluations = 0;
idx = 0;
champ = 99999999999999999;
for l = 1:popSize
    fitness_pop(l) = feval(fitnessFun, population(l,:));
    evaluations = evaluations + 1;
    if fitness_pop(l) < champ
       champ = fitness_pop(l);
       idx = l;
    end
end

Gb = population(idx, :);

if maxEvals > evaluations
    stop = false;
else
    stop = true;
end

bestIter = min(fitness_pop);
meanIter = mean(fitness_pop);

while ~stop
    for l = 1:popSize
        r1 = rand();
        r2 = rand();
        
        % Actualizar velocidad de partícula l
        velocities(l, :) = w * velocities(l, :) + c1 * r1 * ...
            (population(l, :) - positions(l, :)) + c2 * r2 * ...
            (Gb - positions(l, :));
        
        % Actualizar posición de partícula l y evaluar
        positions(l, :) = positions(l, :) + velocities(l, :);
        candidate_fitness = feval(fitnessFun, positions(l, :));
        
        % Si el fitness es mejor, reemplazar
        if candidate_fitness < fitness_pop(l)
            population(l, :) = positions(l, :);
            fitness_pop(l) = candidate_fitness;
            
            if candidate_fitness < champ
               champ = candidate_fitness;
               Gb = positions(l, :);
            end
        end
        
        evaluations = evaluations + 1;
        if maxEvals == evaluations
            stop = true;
            break;
        end
    end
    
    bestIter = cat(1,bestIter,min(fitness_pop));
    meanIter = cat(1,meanIter,mean(fitness_pop));
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

end