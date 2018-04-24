% Rastrigin’s Function... Multimodal, optimal solution: x_i = 0, i = {1,...,n}
% -5 <= x_i <= 5
% optimal value: 0

function y = test_function_2(x)

y = sum(x.^2 - 10 * cos(2 * pi * x) + 10);

end