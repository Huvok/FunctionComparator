% SF2... Multimodal, optimal solution: different coordinates
% -100 <= x_i <= 100
% optimal value = 400;

function y = test_function_4(x)

current_rnd_state = rng;
rng(4);

n = length(x);

if n < 101
    x_o = randperm(n);
else
    x_o = randi(100,n,1);
end

x = imrotate(x(:) - x_o(:),68,'crop');

y = sum(x.^2 - 10 * cos(2 * pi * x) + 10) + 400;

rng(current_rnd_state);
end