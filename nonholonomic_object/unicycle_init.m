%%%%%%%%%%%%%%%%%
omegad = 1;
Rd = 1;
k1 = 1;
k2 = 1;
kd = 1;

%%%%%%%%%%%
L = 0.3; Iz = 6.609; Rk = 7.5 * 10^-2; d = 1e-6;
Mk = 5; Mp = 97;
Mc = 2*Mk + Mp;
Izz = 1/12 * Mk * d^2 + 1/4 * Mk * Rk^2;
Ixx = 0.5 * Mk * Rk^2;
Ic = Iz + 2*Izz + 2*Mk*L^2;

out = sim("unicycle.slx");
