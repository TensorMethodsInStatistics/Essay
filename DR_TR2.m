function X_out = DR_TR2(b, lambda, c_lambda, gamma, Omega, max_iter)

tensor_size = size(b);
N = ndims(b);

X = cell(1, N+1);

for i = 1:N+1
   X{i} = zeros(tensor_size);
end

k = 0;
gamma_prime = (N + 1) * gamma;

while k < max_iter

   t_k = 2/(k^(1/2) + 2); % set the series

   X_hat = mean(cat(ndims(X{1})+1, X{:}), ndims(X{1})+1);

   for i = 2:N+1
       Xi_unfold = Unfold(X{i}, tensor_size, i-1);
       X_hat_unfold = Unfold(X_hat, tensor_size, i-1);
       shrinked = Pro2TraceNorm(2 * X_hat_unfold - Xi_unfold, gamma_prime);
       Xi_new = Fold(shrinked, tensor_size, i-1);
       X{i} = X{i} + t_k * (Xi_new - X_hat);
   end


   Z_temp = 2 * X_hat - X{1};
   prox_result = prox_f0(Z_temp, gamma_prime, b, Omega, lambda); % proximal map of f_0
   X{1} = X{1} + t_k * (prox_result - X_hat);

   if mod(k,20) == 0
       fprintf('Iteration %d: ||X_hat|| = %.4f\n', k, norm(X_hat(:))); % every 20 iterations we print the norm of X_hat
   end

   k = k + 1;
   lambda = lambda * c_lambda;
   
end

X_out = mean(cat(ndims(X{1})+1, X{:}), ndims(X{1})+1);
end

