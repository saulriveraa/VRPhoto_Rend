function [x, y, z] = shifting(xq, yq, zq, size_pic, fr)

widht_pix = 2999/36;

x = xq + ceil(size_pic(2)/2);
y = yq + ceil(size_pic(1)/2);
z = zq + widht_pix*fr;
