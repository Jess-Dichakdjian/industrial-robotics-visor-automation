function [] = plot_trapezoidal(V_hat, T_A, T_D, T_min, motor)

%% Plot
% Speed plot
t_vec = linspace(0, T_min, 1000);
v_vec = zeros(3, length(t_vec));

for i = 1:3
    v_vec(i, :) = ...
        (t_vec < T_A(i)) .* (t_vec * motor.A) + ...
        ((t_vec >= T_A(i)) & (t_vec < (T_min - T_D(i)))) .* V_hat(i) + ...
        (t_vec >= (T_min - T_D(i))) .* (V_hat(i) - (t_vec - (T_min - T_D(i))) * motor.D);
end

figure()
plot(t_vec, v_vec(1,:));
xlabel('Time [s]');
ylabel('Speed [rad/s]');
title('Trapezoidal speed profile');

end