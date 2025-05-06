function Y = prox_f0(Z, tau, b, Omega, lambda)
    alpha = lambda * tau;
    weight_obs = 1 / (alpha + 1);
    weight_b   = alpha / (alpha + 1);

    Y = Z;

    Y(Omega) = weight_b * b(Omega) + weight_obs * Z(Omega);
end
