addpath('mylib/');
load("data.mat", "X"); % load the Monkey BMI dataset

%% DRTC on Monkey BMI for Table 5

X_true = X;
tensor_size = size(X_true);

rng(2025);

Omega = rand(tensor_size) < 0.6; % adjust percentage observed here 0.5,0.6,0.7

% set observed values in Omega
b = zeros(tensor_size);
b(Omega) = X_true(Omega);

% hyperparameters
lambda = 1;
c_lambda = 1.01;
gamma = 10;
max_iter = 20000;
tol = 1e-10;

% DRTC
X_rec = DR_TR2(b, lambda, c_lambda, gamma, Omega, max_iter);

RSE = norm(X_rec(:) - X_true(:)) / norm(X_true(:));

fprintf('Relative error: %.6f\n', RSE);
        
%% SiLRTCnr on Monkey BMI for Table 5

rng(2025);

T = double(X);
Omega = rand(size(T)) < 0.7; % adjust percentage observed here 0.5,0.6,0.7

% set observed and unobserved values
T_missing = T;
T_missing(~Omega) = 0;

% hyperparameters for SiLRTCnr
alpha = [1, 1, 1];
alpha = alpha / sum(alpha);
maxIter = 1000;
epsilon = 1e-10;

factor = 0.99;
X_recovered = SiLRTCnr(T_missing, Omega, alpha, factor, maxIter, epsilon);

% RSE
RSE = norm(T(:) - X_recovered(:)) / norm(T(:));

fprintf('RSE: %.6f\n', RSE);