clear all; close all; clc;
I = imread('skeleton_org(2).tif');
%I = imread('cameraman.tif');
Id = im2double(I); % 正規化

s1 = fft2(I);

[m, n] = size(I);

Gx=[-1 -2 -1;0 0 0;1 2 1]; 
Gy=[-1 0 1;-2 0 2;-1 0 1];
Gx_I=filter2(Gx,I);
Gy_I=filter2(Gy,I);

% (d) sobel 點模糊化
sob_i=abs(Gx_I)+abs(Gy_I); 

% (b) laplacian 抓邊緣
w=fspecial( 'laplacian');
lap_i=filter2(w,I);

w2=[-1 -1 -1;-1 8 -1;-1 -1 -1];
lap_i2=filter2(w2,I);

% (c): (a)+ (b) Iencla 原來加上laplacian疊加
A = double(lap_i);
B = double(I);
imsize = size(A);
C = zeros(imsize);
for j = 1 : imsize(1)
    for k = 1 : imsize(2)
        if sum(A(j, k, :)) == 0
            C(j, k, :) = B(j, k, :);
        else
            C(j, k, :) = A(j, k, :);
        end
    end
end
Iencla = C;

% or use imadd(double(A),double(B),uint8)  % or uint16

% sobel 當作遮罩 filter() + powerlaw
Iff=im2double( filter2(sob_i,I) ) .^(2.5);

% (e) smoothing
w1=1/16*[1     2     1; 2     4     2; 1     2     1];
Smoothing_In=filter2(w1,I);

% (f) enhance with laplacian \times smoothing (a)
If = Iencla .* Smoothing_In;

% (g): (a) + (f)
A = double(I);
B = double(If);
imsize = size(A);
C = zeros(imsize);
for j = 1 : imsize(1)
    for k = 1 : imsize(2)
        if sum(A(j, k, :)) == 0
            C(j, k, :) = B(j, k, :);
        else
            C(j, k, :) = A(j, k, :);
        end
    end
end
Ig = C;

% (h) powerlaw (g)
Ih = im2double(Ig) .^ (1.5);

%% Plot
figure(); 
subplot(221);imshow(I);title('(a) Raw Image');
subplot(222);imshow(uint8(lap_i));title('(b) Laplacian Image');
subplot(223);imshow(uint8(Iencla));title('(c) a + b 疊加 enhance with laplacian');
subplot(224);imshow(uint8(sob_i));title('(d) Sobel Image');
figure();
subplot(221);imshow(uint8(Smoothing_In));title('(e) smoothing (a)');
subplot(222);imshow(uint8(If));title('(f) c.*e');
subplot(223);imshow(uint8(Ig));title('(g): (a) + (f)');
subplot(224);imshow(uint8(Ih));title('(h) powerlaw (g)');

clear all; clc;