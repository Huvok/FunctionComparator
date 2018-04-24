% SF2... Unimodal, optimal solution: different coordinates
% -100 <= x_i <= 100
% optimal value = 300;

function y = test_function_3(x)

current_rnd_state = rng;
rng(3);

n = length(x);

if n < 101
    x_o = randperm(n);
else
    x_o = randi(100,n,1);
end

x = imrotate(x(:) - x_o(:),45,'crop');

y = x(1)^2 + 10e6 * sum(x(2:end).^2) + 300;

rng(current_rnd_state);
end