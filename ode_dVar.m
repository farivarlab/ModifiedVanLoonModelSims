% function dVardt = ode_dVar(Var,I,gamma,sigma,alpha,tau,sigmoidParam)
function dVardt = ode_dVar(t,Var,I,gamma,sigma,alpha,tau,sigmoidParam,noiseVec)

curNoise1 = interp1(noiseVec(3,:),noiseVec(1,:),t);
curNoise2 = interp1(noiseVec(3,:),noiseVec(2,:),t);

dVardt = zeros(4,1);
X(1) = Var(1);
X(2) = Var(2);
A(1) = Var(3);
A(2) = Var(4);

% dXdt(1) = I(1) - (1+A(1))*X(1) - gamma(1)*sigmoid(sigmoidParam,X(2)) + randn*sigma(1);
% dXdt(2) = I(2) - (1+A(2))*X(2) - gamma(2)*sigmoid(sigmoidParam,X(1)) + randn*sigma(2);
dXdt(1) = I(1) - (1+A(1))*X(1) - gamma(2)*sigmoid(sigmoidParam,X(2)) + curNoise1*sigma(1);
dXdt(2) = I(2) - (1+A(2))*X(2) - gamma(1)*sigmoid(sigmoidParam,X(1)) + curNoise2*sigma(2);
dAdt(1) = (-A(1) + alpha(1)*sigmoid(sigmoidParam,X(1)))/tau(1);
dAdt(2) = (-A(2) + alpha(2)*sigmoid(sigmoidParam,X(2)))/tau(2);

dVardt(1) = dXdt(1);
dVardt(2) = dXdt(2);
dVardt(3) = dAdt(1);
dVardt(4) = dAdt(2);
end



