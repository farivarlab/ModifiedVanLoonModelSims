function [times,Var] = vanLoonSim(p)

% startingA(1) = (p.I(1) - p.gamma(1)*sigmoid(p.sigmoidParam,p.I(1)))/p.I(1) - 1;
% startingA(2) = (p.I(2) - p.gamma(2)*sigmoid(p.sigmoidParam,p.I(2)))/p.I(2) - 1;

%% Run the dynamic system
% options = odeset('NonNegative', 1:4,'RelTol',1e-5,'AbsTol',[1e-6 1e-6 1e-8 1e-8],'MaxStep',1);
options = odeset('NonNegative', 1:4,'RelTol',1e-5,'MaxStep',1);
% [times,Var] = ode45(@(t,Var)ode_dVar(Var,p.I,p.gamma,p.sigma,p.alpha,p.tau,p.sigmoidParam),[0 p.endTime],[p.I startingA],options);

noiseVec(3,:) = 0:1:p.endTime;
% noiseVec(1,:) = rand(1,size(noiseVec(3,:),2))*2-1;
% noiseVec(2,:) = rand(1,size(noiseVec(3,:),2))*2-1;
noiseVec(1,:) = randn(1,size(noiseVec(3,:),2));
noiseVec(2,:) = randn(1,size(noiseVec(3,:),2));
% noiseVec = [];

[times,Var] = ode45(@(t,Var)ode_dVar(t,Var,p.I,p.gamma,p.sigma,p.alpha,p.tau,p.sigmoidParam,noiseVec),[0 p.endTime],[p.startingI p.startingA],options);


