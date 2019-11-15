clear all; clc;
%% Read the image
Iraw = imread('cameraman.tif');
I = im2double(Iraw);

%% Settings
% inputs
[m n ~] = size(I);
k = 3;%k = 0.9; % times this cof to get the new image
% new size M is Heigh N is width
Mn = k.*m; Nn = k.*n; Y = zeros(Mn,Nn);

hs = (m/Mn);
ws = (n/Nn);

%% Execute
% The linear system : $f(x,y) = a_0 + a_1x + ....$
% A \times cof = f(x,y) % A is the cof of the fcn % cof is [a_0 a_1 ...]
% cof = A^(-1)* f
for i=1:Mn
    y = (hs * i) + (0.5 * (1 - 1/k));
    for j=1:Nn
        x = (ws * j) + (0.5 * (1 - 1/k));
    %// Any values out of acceptable range
        x(x < 1) = 1;
        x(x > m - 0.001) = m - 0.001;
        x1 = floor(x);
        x2 = x1 + 1;
        y(y < 1) = 1;
        y(y > n - 0.001) = n - 0.001;
        y1 = floor(y);
        y2 = y1 + 1;
    %// 4 Neighboring Pixels
        NP1 = I(y1,x1);
        NP2 = I(y1,x2);
        NP3 = I(y2,x1); 
        NP4 = I(y2,x2);
    %// 4 Pixels Weights
        PW1 = (y2-y)*(x2-x);
        PW2 = (y2-y)*(x-x1);
        PW3 = (x2-x)*(y-y1);
        PW4 = (y-y1)*(x-x1);
        Y(i,j) = PW1 * NP1 + PW2 * NP2 + PW3 * NP3 + PW4 * NP4;
    end
end
%% Plot
figure();imshow(I);title('The raw file');
figure();imshow(Y);title('The file we zoom');
figure();
subplot(121), imshow(I); title('The raw file');
subplot(122), imshow(Y); title('The file we zoom');