function [t_vec, Q, Qp, Qpp] = segment_trapezoid_3dof(q_start, dq, T_min, T_A, T_D, V_hat, motor, dt)

% dt = passo di campionamento
t_vec = 0:dt:T_min;
n  = length(t_vec);

Q   = zeros(3,n);
Qp  = zeros(3,n);
Qpp = zeros(3,n);

A = motor.A;
D = motor.D;

for i = 1:n
    t = t_vec(i);

    for j = 1:3
        sgn = sign(dq(j));
        Ta  = T_A(j);
        Td  = T_D(j);
        Vh  = V_hat(j);

        dq_abs = abs(dq(j));

        if dq_abs < 1e-12
            Q(j,i) = q_start(j);
            Qp(j,i) = 0;
            Qpp(j,i) = 0;
            continue
        end

        % fase 1: accelerazione
        if t < Ta
            s_rel = 0.5*A*t^2;
            v = A*t;
            a = A;

        % fase 2: velocità costante
        elseif t < (T_min - Td)
            s_rel = 0.5*A*Ta^2 + Vh*(t - Ta);
            v = Vh;
            a = 0;

        % fase 3: decelerazione
        else
            t_dec = t - (T_min - Td);
            s_rel = dq_abs - (0.5*D*(Td - t_dec)^2);
            v = Vh - D*t_dec;
            a = -D;
        end

        Q(j,i)   = q_start(j) + sgn*s_rel;
        Qp(j,i)  = sgn*v;
        Qpp(j,i) = sgn*a;
    end
end

end
