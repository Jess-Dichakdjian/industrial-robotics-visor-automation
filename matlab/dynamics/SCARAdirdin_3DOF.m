function S = SCARAdirdin_3DOF(Q,L)
% extended direct kinematics of a planar 3R SCARA

q1 = Q(1);
q2 = Q(2);
q3 = Q(3);

l1 = L(1);
l2 = L(2);
l3 = L(3);

g1 = L(4);
g2 = L(5);
g3 = L(6);

S = zeros(10,1);

% 1-2) posizione del TCP (end effector)
S(1) = l1*cos(q1) + l2*cos(q1+q2) + l3*cos(q1+q2+q3);  % x_p
S(2) = l1*sin(q1) + l2*sin(q1+q2) + l3*sin(q1+q2+q3);  % y_p

% 3-4) baricentro link 2 (come nel 2DOF, indipendente da l3)
S(3) = l1*cos(q1) + g2*cos(q1+q2);                     % x_g2
S(4) = l1*sin(q1) + g2*sin(q1+q2);                     % y_g2

% 5) orientazione dell'end effector
S(5) = q1 + q2 + q3;                                   % theta

% 6-7) baricentro link 1 (identico al 2DOF)
S(6) = g1*cos(q1);                                     % x_g1
S(7) = g1*sin(q1);                                     % y_g1

% 8) angolo del primo giunto (alpha)
S(8) = q1;                                             % alpha

% 9-10) baricentro link 3 (nuovo)
S(9)  = l1*cos(q1) + l2*cos(q1+q2) + g3*cos(q1+q2+q3); % x_g3
S(10) = l1*sin(q1) + l2*sin(q1+q2) + g3*sin(q1+q2+q3); % y_g3

end
