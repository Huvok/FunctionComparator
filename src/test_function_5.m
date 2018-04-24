% SF2... Multimodal, optimal solution: x_i = 0, i = {1,...,n}
% -100 <= x_i <= 100
% optimal value: 500

function y = test_function_5(x)

current_rnd_state = rng;
rng(5);

n = length(x);

if n < 101
    x_o = randperm(n);
else
    x_o = randi(100,n,1);
end

x = imrotate(x(:) - x_o(:),80,'crop');

y = sum(100 * (x(2:end) - x(1:end-1).^2).^2 + (1 - x(1:end-1)).^2) + 500;

rng(current_rnd_state);

end