clear; clc;
raw = imread('cameraman.tif');
raw=im2double(raw); % 正規化，很重要不然看不出灰階差異，可以這行註解來看
%I=rgb2gray(raw);
[M,N,layers]=size(raw); % 彩色圖片有三層RGB
Zk = 2; % 新的大小
Mx = M.*Zk; Nx = N.*Zk; % 新的大小 可縮小或放大到兩倍
new=zeros(Mx,Nx,layers);

% 挖 2 by 2
for i=1:M
    for j=1:N
        for layer=1:layers
            new(i*Zk,j*Zk,layer)=raw(i,j,layer);
        end
    end
end

% AB x軸
for i=1:M
    for j=1:N
        for layer=1:layers
            if(i==1)
                new(i*Zk-1,j*Zk,layer)=new(i*Zk,j*Zk,layer);
            else
                new(i*Zk-1,j*Zk,layer)=0.5*(new(i*Zk-2,j*Zk,layer)+new(i*Zk,j*Zk,layer));
            end
        end
    end
end

% CD y軸
for i=1:M
    for j=1:N
        for layer=1:layers
            if(j==1)
                new(i*Zk,j*Zk-1,layer)=new(i*Zk,j*Zk,layer);
                new(i*2-1,j*Zk-1,layer)=new(i*2-1,j*Zk,layer);
            else
            new(i*Zk,j*Zk-1,layer)=0.5*(new(i*Zk,j*Zk,layer)+new(i*Zk,j*Zk-2,layer));
            new(i*Zk-1,j*Zk-1,layer)=0.5*(new(i*Zk-1,j*Zk,layer)+new(i*Zk-1,j*Zk-2,layer));
            end
        end
    end
end
%% Plot
figure();imshow(raw);title('The raw file');
figure();imshow(new);title('The file we zoom');
figure();
subplot(121), imshow(raw); title('The raw file');
subplot(122), imshow(new); title('The file we zoom');
