clear; clc;
raw = imread('cameraman.tif');
raw=im2double(raw); % 正規化，很重要不然看不出灰階差異，可以這行註解來看
[M,N,layers] = size(raw); % 彩色圖片有三層RGB
Zk = 2; % 新的大小 可縮小或放大到兩倍
Mx = M.*Zk; Nx = N.*Zk; % 新的大小 可縮小或放大到兩倍
new = zeros(Mx,Nx,layers); % 建立新矩陣
for i = 1:Mx
    if Nx == 0
        break
    end
    for j = 1:Nx
        for layer = 1:layers
            x_ratio = round(i.* M ./ Mx);
            y_ratio = round(j.* N ./ Nx);
            new(i,j,layer) = raw(x_ratio, y_ratio,layer);
        end
    end
end

%% Plot
figure();imshow(raw);title('The raw file');
figure();imshow(new);title('The file we zoom');
figure();
subplot(121), imshow(raw); title('The raw file');
subplot(122), imshow(new); title('The file we zoom');

% test
%figure;new1 = edge(new,'canny');imshow(new1);
%th = 0.5; new2 = new >th; figure; imshow(new2);
