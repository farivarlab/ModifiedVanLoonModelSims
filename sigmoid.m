function [Xout] = sigmoid(params,Xin)

% Compute the Naka-Rushton function on passed vector of Xins.
% Several different forms may be computed depending on length of
% passed params vector.

sigma = params(1);
n = params(2);
maxVal = params(3);
if Xin<0
    Xout = 0;
else
%     Xout = maxVal.*(Xin.^n./(Xin.^n + sigma.^n));
    Xout = Xin.^n;
end
end