addpath('tensor_toolbox-dev/');
addpath('mylib/');
addpath('Images/');
%% calculating the (S,RSE) for Figure 11

rng(2025);

T = tensor(double(imread('baboon.png'))); % adjust file name for other images

min_size = mink(size(T), 2);

prod = min_size(1)*min_size(2); % maximum rank of T

% Calculating S:

min_rank = 1;
max_rank = prod;
R90 = 1; % initialise

while min_rank <= max_rank
    rank = floor((min_rank + max_rank)/2);
    rng(2025);

    cp_decomp = cp_als(T, rank, 'printitn', 0);
    cp_approx = full(cp_decomp);

    normexp = 1 - (norm(T - cp_approx)/norm(T));

    if normexp > 0.9
        R90 = rank;
        max_rank = rank - 1;
    else
        min_rank = rank + 1;
    end
end

% Calculating RSE:

rng(2025);

T = double(T);

img_size = size(T);

Omega3 = rand(img_size) < 0.5; % keep this at 0.5

b = zeros(img_size);
b(Omega3) = T(Omega3);

lambda = 1;
c_lambda = 1.01;
gamma = 100;
max_iter = 2000;

% DRTC
T_recovered = DR_TR2(b, lambda, c_lambda, gamma, Omega3, max_iter);

RSE50 = norm(T_recovered(:) - T(:))/norm(T(:));

fprintf('(S,RSE) = (%.4f, %.4f)\n', R90/prod, RSE50) % prints coordinates for Figure 11

