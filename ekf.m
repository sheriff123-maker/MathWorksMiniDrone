
function [P] = ekf(Q,F_x, F_i ,P, dx_error);
% Extended Kalman filter
%
% -------------------------------------------------------------------------
%
% State space model is
% X_k+1 = f_k(X_k) + V_k+1   -->  state update
% Y_k = h_k(X_k) + W_k       -->  measurement
% 
% V_k+1 zero mean uncorrelated gaussian, cov(V_k) = Q_k
% W_k zero mean uncorrelated gaussian, cov(W_k) = R_k
% V_k & W_j are uncorrelated for every k,j
%
% -------------------------------------------------------------------------
%
% Inputs:
% f = f_k
% Q = Q_k+1
% h = Jacobian of h function wrt error state dx_error
% y = y_k
% R = R_k
% del_f = gradient of f_k
% del_h = gradient of h_k
% x_hat = current state prediction
% P_hat = current error covariance (predicted)
%
% -------------------------------------------------------------------------
%
% Outputs:
% x_next = next state prediction
% P_next = next error covariance (predicted)
% x_dgr = current state estimate
% P_dgr = current estimated error covariance
%
% -------------------------------------------------------------------------
%
if isa(f,'function_handle') & isa(H,'function_handle') & isa(del_f_x,'function_handle') & isa(del_h,'function_handle')
    y_hat = H(x_hat);
    y_tilde = y - y_hat;
    t = del_h(x_hat);
    tmp = P*t;
    M = inv(t'*tmp+R+eps);
    K = tmp*M;
    p = del_f_x(x_hat);
    x_dgr = x_hat + K* y_tilde;
    x_next = f(x_dgr);
    P_dgr = P - tmp*K';
    P_next = p* P_dgr* p' + Q;
else
    error('f, h, del_f, and del_h should be function handles')
    return
end
