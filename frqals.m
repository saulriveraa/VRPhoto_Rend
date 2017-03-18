function H = frqals

[f1, f2] = freqspace([50 50]);

x = f1;
y = f1;

x(abs(f1) <= 0.5) = 1;
x(abs(f1) > 0.5) = 0;

y(abs(f2) <= 0.5) = 1;
y(abs(f2) > 0.5) = 0;

M = x'*y;

M2 = fspecial('gaussian', [50 50], 10);

M2 = M2./max(M2(:));
H = fwind2(M, M2);
