addpath('tensor_toolbox-dev/');
addpath('mylib/');
%% DRTC [for Table 4]

rng(2025);
% generate a dim1 x dim2 x dim3 low rank tensor
dim1 = 50; dim2 = 50; dim3 = 50;
rank_n = 10; % adjust R here <----- R = 10,15,20

% generating factor matrices
A = randn(dim1, rank_n);
B = randn(dim2, rank_n);
C = randn(dim3, rank_n);

% construct low rank tensor using tensor toolbox
lambda = ones(rank_n,1);
T_low = ktensor(lambda, {A, B, C});

% Convert to full tensor if needed
T_low = double(full(T_low));

Omega = rand(size(T_low)) < 0.20; % adjust percentage observed here <----- 0.2,0.3,0.4

% set observed values in Omega
b = zeros(size(T_low));
b(Omega) = T_low(Omega);

% hyperparams
lambda = 1;
c_lambda = 1.01;
gamma = 100;
max_iter = 1000;

% DRTC
X_rec = DR_TR2(b, lambda, c_lambda, gamma, Omega, max_iter);

RSE = norm(X_rec(:) - T_low(:))/norm(T_low(:));

fprintf('RSE: %.3f\n', RSE);

%% for SiLRTC

T_missing = T_low;
T_missing(~Omega) = 0;

% SiLRTCnr
alpha = [1, 1, 1];
alpha = alpha / sum(alpha);
maxIter = 5000;
epsilon = 1e-11;

factor = 0.99;
X_syn_rec = SiLRTCnr(T_missing, Omega, alpha, factor, maxIter, epsilon);

% calculate the RSE
RSE = norm(T_low(:) - X_syn_rec(:))/norm(T_low(:));

fprintf('RSE: %.3f\n', RSE);