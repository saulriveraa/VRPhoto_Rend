function [xx, yy, zz] = back_proj(fr, x, y, z, val)

widht_pix = 3000/36;

switch val
    case 1
        
        zz = widht_pix*fr*ones(1, length(x));
        xx = widht_pix*fr*x./z;
        yy = widht_pix*fr*y./z;
        
        %%% Reverse projection
        xx(z < 0) = NaN;
        zz(z < 0) = NaN;
        yy(z < 0) = NaN;
        
    case 2
        
        xx = widht_pix*fr*ones(1, length(x));
        zz = widht_pix*fr*z./x;
        yy = widht_pix*fr*y./x;
        
        %%% Reverse projection
        xx(x < 0) = NaN;
        zz(x < 0) = NaN;
        yy(x < 0) = NaN;

    case 3
        
        zz = -widht_pix*fr*ones(1, length(x));
        xx = -widht_pix*fr*x./z;
        yy = -widht_pix*fr*y./z;
        
        %%% Reverse projection
        xx(z > 0) = NaN;
        zz(z > 0) = NaN;
        yy(z > 0) = NaN;
     
    case 4
        
        xx = -widht_pix*fr*ones(1, length(x));
        zz = -widht_pix*fr*z./x;
        yy = -widht_pix*fr*y./x;
        
        %%% Reverse projection
        xx(x > 0) = NaN;
        zz(x > 0) = NaN;
        yy(x > 0) = NaN;
        
end
