% Ackley's Function... Multimodal, optimal solution: x_i = 0, i = {1,...,n}
% -5 <= x_i <= 5
% optimal value: 0

function y = test_function_7(x)

D = length(x);

y = -20 * exp(-0.2 * sqrt((D^-1) * sum(x.^2)) - exp(-0.2 * sqrt((D^-1) * cos(2 * pi * x)))) + 20 ;

end