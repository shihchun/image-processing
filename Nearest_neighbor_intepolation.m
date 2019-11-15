clear; clc;
raw = imread('cameraman.tif');
raw=im2double(raw); % ���W�ơA�ܭ��n���M�ݤ��X�Ƕ��t���A�i�H�o����ѨӬ�
[M,N,layers] = size(raw); % �m��Ϥ����T�hRGB
Zk = 2; % �s���j�p �i�Y�p�Ω�j��⭿
Mx = M.*Zk; Nx = N.*Zk; % �s���j�p �i�Y�p�Ω�j��⭿
new = zeros(Mx,Nx,layers); % �إ߷s�x�}
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
