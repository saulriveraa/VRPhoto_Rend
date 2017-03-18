function [f, r, b, l] = up_color(pano)

siz = size(pano, 2)/4;

f = pano(:,1:siz);
r = pano(:, (siz+1):2*siz);
b = pano(:, (2*siz + 1):3*siz);
l = pano(:, (3*siz + 1):4*siz);
