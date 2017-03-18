function [x, y, s] = env_creator(size_pic)

[x, y] = meshgrid(1:size_pic(2), 1:size_pic(1));

x = x - ceil(size_pic(2)/2);
y = y - ceil(size_pic(1)/2);

x(:, 1:2:size_pic(2)) = [];
y(:, 1:2:size_pic(2)) = [];

x(1:2:size_pic(1), :) = [];
y(1:2:size_pic(1), :) = [];

s = size(x);

x = x(:)';
y = y(:)';
