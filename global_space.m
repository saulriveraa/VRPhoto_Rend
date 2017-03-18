function [x, y, z] = global_space(alp, fv, xq, yq)

widht_pix = 2999/36;

zq = widht_pix*fv*ones(1, length(xq));

%%% Rotating the virtual camara

M = [xq; yq; zq];

M = roty(alp)*M;

x = M(1, :);
y = M(2, :);
z = M(3, :);