function output = ES(fitnessFun,mu,lambda,nVars,lowerBound,upperBound,...
    probCross,probMut,maxEvals)

start = clock;

sigmaInit = 1;
sigmaMin = 1e-10;

tau = 1/sqrt(2*nVars);  

population = repmat(upperBound - lowerBound,mu,1) .* rand(mu,nVars) +...
    repmat(lowerBound,mu,1);
sigma_pop = sigmaInit * ones(mu,1);
fitness_pop = zeros(mu,1);

evaluations = 0;
for l = 1:mu
    fitness_pop(l) = feval(fitnessFun,population(l,:));
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
    for l = 1:lambda
        idx = randi(mu,1,3);
        if rand > probCross
            idx = idx(1);
        end
        prob_mut_vct = rand(1,nVars) < probMut;
        sigma_child = mean(sigma_pop(idx)) * exp(tau*randn);
        child = mean(population(idx,:)) + sigma_child  * (randn(1,nVars) .*...
            prob_mut_vct); 
        child = max([min([upperBound;child],[],1);lowerBound],[],1);
        fitness_child = feval(fitnessFun,child);

        if any(fitness_pop(idx) > fitness_child)
         [~,idx_tmp] = max(fitness_pop(idx));
         fitness_pop(idx(idx_tmp)) = fitness_child;
         population(idx(idx_tmp),:) = child;
         sigma_pop(idx(idx_tmp),:) = sigma_child;
        end

        evaluations = evaluations + 1;
        
        if fitness_child < best
            best = fitness_child;
            best_fitness_iter = iterCnt + 1;
        end

        if maxEvals == evaluations || min(sigma_pop) < sigmaMin
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