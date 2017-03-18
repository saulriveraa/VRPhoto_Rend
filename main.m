%Image based rendering from 360 photos

clc; clearvars; close all;

%Read images from dataset
front = imread('DSC_4105.jpg');
left = imread('DSC_4108.jpg');
right = imread('DSC_4106.jpg');
back = imread('DSC_4107.jpg');

%Creating odd columns for images
front = front(:, 1:end-1, :);
right = right(:, 1:end-1, :);
back = back(:, 1:end-1, :);
left = left(:, 1:end-1, :);

%Filter for aliasing
H = frqals;
front = imfilter(front, H); right = imfilter(right, H);
back = imfilter(back, H);   left = imfilter(left, H);

%Creating pano image
pano = im2double([front, right, back, left]);

figure(1)
imshow(pano)

o = 0;
h = length(-180:5:180);

for a = -180:5:180
    
        o = o + 1;
        %%% Creating the x and y meshgrid
        [x, y, ns] = env_creator(size(front));
        
        qv_f = zeros(ns(1), ns(2), 3); 
        qv_r = qv_f; qv_b = qv_r; qv_l = qv_b;
        
        %%% Global-Space Coordinates
        [x, y, z] = global_space(a, 36, x, y);

        %%% Back Projection
        [x_f, y_f, z_f] = back_proj(18, x, y, z, 1);
        [x_r, y_r, z_r] = back_proj(18, x, y, z, 2);
        [x_b, y_b, z_b] = back_proj(18, x, y, z, 3);
        [x_l, y_l, z_l] = back_proj(18, x, y, z, 4);
        
        %%% Reshifting coordinates
        [x_f, y_f, z_f] = shifting(x_f, y_f, z_f, size(front), 18);
        [x_r, y_r, z_r] = shifting(x_r, y_r, z_r, size(front), 18);
        [x_b, y_b, z_b] = shifting(x_b, y_b, z_b, size(front), 18);
        [x_l, y_l, z_l] = shifting(x_l, y_l, z_l, size(front), 18);
        
    for au_col = 1:3    %%% Obtaining the data for each color (RGB)
        
        [f, r, b, l] = up_color(pano(:, :, au_col));
        r = fliplr(r); b = fliplr(b);   %flipping images to avoid mirroring
        
        %%% Sampling
        s_f = interp2(f, reshape(x_f, ns), reshape(y_f, ns));
        s_r = interp2(r, reshape(z_r, ns), reshape(y_r, ns)); 
        s_b = interp2(b, reshape(x_b, ns), reshape(y_b, ns));
        s_l = interp2(l, reshape(z_l, ns), reshape(y_l, ns));
        
        qv_f(:, :, au_col) = s_f;
        qv_r(:, :, au_col) = s_r;
        qv_b(:, :, au_col) = s_b;
        qv_l(:, :, au_col) = s_l;

    end
    
    %%% Deleting the NaN data and reshaping to image size
    qv_f(isnan(qv_f)) = [];
    qv_r(isnan(qv_r)) = []; 
    qv_b(isnan(qv_b)) = []; 
    qv_l(isnan(qv_l)) = [];
    
    qv_f = reshape(qv_f, ns(1), [], 3); 
    qv_r = reshape(qv_r, ns(1), [], 3); 
    qv_b = reshape(qv_b, ns(1), [], 3); 
    qv_l = reshape(qv_l, ns(1), [], 3); 
    
    if a < 90
        pano3 = [qv_b qv_l qv_f qv_r]; 
    else
        pano3 = [qv_l qv_f qv_r qv_b]; 
    end
    
    if size(pano3, 2) ~= ns(2)
        pano3 = [pano3 NaN*ones(ns(1), ns(2) - size(pano3, 2), 3)]; %#ok
    end
    
    panon(:,:,:, o) = pano3; %#ok
    
    fprintf('Analizing data = %i/%i\n', o, h)
    
end

implay(panon, 10)   %%% Printing the video
