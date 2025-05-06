addpath('tensor_toolbox-dev/');
addpath('Images/');

%% Produce Figure 6(a)

lowrank_img = double(imread('Gauss.jpg'));

rng(2025);

perturbed_image = lowrank_img + 100*randn(size(lowrank_img)); % we use sigma (sd) = 100

imshow(uint8(perturbed_image));

subplot(1, 8, 1);
imshow(uint8(lowrank_img));
title('Original Image');

subplot(1, 8, 2);
imshow(uint8(perturbed_image));
title('Perturbed Image');

core_dims = [30, 30, 3];
T_tucker = tucker_als(tensor(perturbed_image), core_dims);
G_slice = T_tucker.core;
U = T_tucker.u;

T_approx = double(ttensor(G_slice, U));

normperc_tucker = 100*(1 - norm(lowrank_img - T_approx, 'fro')/norm(lowrank_img, 'fro'));

subplot(1, 8, 3);
imshow(uint8(T_approx));
title('Tucker Approximation');
xlabel(['Norm %: ' num2str(normperc_tucker)]);

R_slice = perturbed_image(:, :, 1);
G_slice = perturbed_image(:, :, 2);
B_slice = perturbed_image(:, :, 3);

% SVD on each slice
[U_R, D_R, V_R] = svd(R_slice);
[U_G, D_G, V_G] = svd(G_slice);
[U_B, D_B, V_B] = svd(B_slice);

% rank k approximation
i = 1;

for k = [10,15,20,25,30]
    % reconstruct each low-rank approximation for each slice
    R_approx = U_R(:, 1:k)*D_R(1:k, 1:k)*V_R(:, 1:k)';
    G_approx = U_G(:, 1:k)*D_G(1:k, 1:k)*V_G(:, 1:k)';
    B_approx = U_B(:, 1:k)*D_B(1:k, 1:k)*V_B(:, 1:k)';
    
    % reconstruct the image
    img_approx = cat(3, R_approx, G_approx, B_approx);
    normperc = 100*(1 - norm(lowrank_img - img_approx, 'fro')/norm(lowrank_img, 'fro'));
    
    subplot(1, 8, 3+i);
    imshow(uint8(img_approx)), title(['SVD with k = ' num2str(k)]);
    xlabel(['Norm % = ' num2str(normperc)])
    i = i + 1;
end

%% Produce Figure 6(b)

lowrank_img = double(imread('classroom.png'));

rng(2025);

perturbed_image = lowrank_img + 100*randn(size(lowrank_img)); % coefficient of randn controls variance of noise

imshow(uint8(perturbed_image));

subplot(1, 8, 1);
imshow(uint8(lowrank_img));
title('Original Image');

subplot(1, 8, 2);
imshow(uint8(perturbed_image));
title('Perturbed Image');

core_dims = [25, 25, 3];
T_tucker = tucker_als(tensor(perturbed_image), core_dims);
G_slice = T_tucker.core;
U = T_tucker.u;

T_approx = double(ttensor(G_slice, U));

normperc_tucker = 100*(1 - norm(lowrank_img - T_approx, 'fro')/norm(lowrank_img, 'fro'));

subplot(1, 8, 3);
imshow(uint8(T_approx));
title('Tucker Approximation');
xlabel(['Norm %: ' num2str(normperc_tucker)]);

R_slice = perturbed_image(:, :, 1);
G_slice = perturbed_image(:, :, 2);
B_slice = perturbed_image(:, :, 3);

% SVD on each slice

[U_R, D_R, V_R] = svd(R_slice);
[U_G, D_G, V_G] = svd(G_slice);
[U_B, D_B, V_B] = svd(B_slice);

% rank k approximation

i = 1;

for k = [5,10,15,20,25]
    % reconstruct each low-rank approximation for each slice
    R_approx = U_R(:, 1:k)*D_R(1:k, 1:k)*V_R(:, 1:k)';
    G_approx = U_G(:, 1:k)*D_G(1:k, 1:k)*V_G(:, 1:k)';
    B_approx = U_B(:, 1:k)*D_B(1:k, 1:k)*V_B(:, 1:k)';
    
    % reconstruct the image
    img_approx = cat(3, R_approx, G_approx, B_approx);
    normperc = 100*(1 - norm(lowrank_img - img_approx, 'fro')/norm(lowrank_img, 'fro'));
    
    subplot(1, 8, 3+i);
    imshow(uint8(img_approx)), title(['SVD with k = ' num2str(k)]);
    xlabel(['Norm % = ' num2str(normperc)])
    i = i + 1;
end

%% Produce Figure 6(c)

lowrank_img = double(imread('peppers.png'));

rng(2025);

perturbed_image = lowrank_img + 100*randn(size(lowrank_img)); % coefficient of randn controls variance of noise

imshow(uint8(perturbed_image));

subplot(1, 8, 1);
imshow(uint8(lowrank_img));
title('Original Image');

subplot(1, 8, 2);
imshow(uint8(perturbed_image));
title('Perturbed Image');

core_dims = [15, 15, 3];
T_tucker = tucker_als(tensor(perturbed_image), core_dims);
G_slice = T_tucker.core;
U = T_tucker.u;

T_approx = double(ttensor(G_slice, U));

normperc_tucker = 100*(1 - norm(lowrank_img - T_approx, 'fro')/norm(lowrank_img, 'fro'));

subplot(1, 8, 3);
imshow(uint8(T_approx));
title('Tucker Approximation');
xlabel(['Norm %: ' num2str(normperc_tucker)]);

R_slice = perturbed_image(:, :, 1);
G_slice = perturbed_image(:, :, 2);
B_slice = perturbed_image(:, :, 3);

% SVD on each slice
[U_R, D_R, V_R] = svd(R_slice);
[U_G, D_G, V_G] = svd(G_slice);
[U_B, D_B, V_B] = svd(B_slice);

% rank k approximation
i = 1;

for k = [6,8,10,12,14]
    % reconstruct each low-rank approximation for each slice
    R_approx = U_R(:, 1:k)*D_R(1:k, 1:k)*V_R(:, 1:k)';
    G_approx = U_G(:, 1:k)*D_G(1:k, 1:k)*V_G(:, 1:k)';
    B_approx = U_B(:, 1:k)*D_B(1:k, 1:k)*V_B(:, 1:k)';
    
    % reconstruct the image
    img_approx = cat(3, R_approx, G_approx, B_approx);
    normperc = 100*(1 - norm(lowrank_img - img_approx, 'fro')/norm(lowrank_img, 'fro'));
    
    subplot(1, 8, 3+i);
    imshow(uint8(img_approx)), title(['SVD with k = ' num2str(k)]);
    xlabel(['Norm % = ' num2str(normperc)])
    i = i + 1;
end

%% Produce Figure 6(d)

lowrank_img = double(imread('baboon.png'));

rng(2025);

perturbed_image = lowrank_img + 100*randn(size(lowrank_img)); % coefficient of randn controls variance of noise

imshow(uint8(perturbed_image));

subplot(1, 8, 1);
imshow(uint8(lowrank_img));
title('Original Image');

subplot(1, 8, 2);
imshow(uint8(perturbed_image));
title('Perturbed Image');

core_dims = [15, 15, 3];
T_tucker = tucker_als(tensor(perturbed_image), core_dims);
G_slice = T_tucker.core;
U = T_tucker.u;

T_approx = double(ttensor(G_slice, U));

normperc_tucker = 100*(1 - norm(lowrank_img - T_approx, 'fro')/norm(lowrank_img, 'fro'));

subplot(1, 8, 3);
imshow(uint8(T_approx));
title('Tucker Approximation');
xlabel(['Norm %: ' num2str(normperc_tucker)]);

R_slice = perturbed_image(:, :, 1);
G_slice = perturbed_image(:, :, 2);
B_slice = perturbed_image(:, :, 3);

% SVD on each slice
[U_R, D_R, V_R] = svd(R_slice);
[U_G, D_G, V_G] = svd(G_slice);
[U_B, D_B, V_B] = svd(B_slice);

% rank k approximation
i = 1;

for k = [4,6,8,10,12]
    % reconstruct each low-rank approximation for each slice
    R_approx = U_R(:, 1:k)*D_R(1:k, 1:k)*V_R(:, 1:k)';
    G_approx = U_G(:, 1:k)*D_G(1:k, 1:k)*V_G(:, 1:k)';
    B_approx = U_B(:, 1:k)*D_B(1:k, 1:k)*V_B(:, 1:k)';
    
    % reconstruct the image
    img_approx = cat(3, R_approx, G_approx, B_approx);
    normperc = 100*(1 - norm(lowrank_img - img_approx, 'fro')/norm(lowrank_img, 'fro'));
    
    subplot(1, 8, 3+i);
    imshow(uint8(img_approx)), title(['SVD with k = ' num2str(k)]);
    xlabel(['Norm % = ' num2str(normperc)])
    i = i + 1;
end