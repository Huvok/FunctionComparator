% Discus Function... Unimodal, optimal solution: x_i = 0, i = {1,...,n}
% -100 <= x_i <= 100
% optimal value: 0

function y = test_function_6(x)

y = 10e6 * x(1)^2 +  sum(x(2:end).^2);

end