addpath('mylib/');
addpath('tensor_toolbox-dev/');
%% DRTC on Stem Cell for Table 5

stemcell = load('stemcell_post_trans.mat');

X_true = stemcell.tensor;

rng(2025);

tensor_size = size(X_true);

Omega = rand(tensor_size) < 0.7; % adjust percentage observed here 0.5,0.6,0.7

% initialise b and replace observed entries
b = zeros(tensor_size);
b(Omega) = X_true(Omega);

% set hyperparameters for DRTC
lambda = 1;
c_lambda = 1.01;
gamma = 0.1;
max_iter = 20000;

% DRTC
X_rec = DR_TR2(b, lambda, c_lambda, gamma, Omega, max_iter);

RSE = norm(X_rec(:) - X_true(:)) / norm(X_true(:));

fprintf('Relative error: %.6f\n', RSE);

%% SiLRTCnr on Stem Cell for Table 5

T_missing = X_true;
T_missing(~Omega) = 0;

alpha = [1, 1, 1];
alpha = alpha / sum(alpha);
maxIter = 1500;
epsilon = 1e-10;

factor = 0.99;
X_stemcell_rec = SiLRTCnr(T_missing, Omega, alpha, factor, maxIter, epsilon);


% calculate the RSE
RSE = norm(X_true(:) - X_stemcell_rec(:))/norm(X_true(:));

fprintf('Relative error: %.6f\n', RSE);