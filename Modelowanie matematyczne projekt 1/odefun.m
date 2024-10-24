function [out] = odefun(t,y)
% Wejście:
% t - wektor kolejnych kroków
% y - wektor wartości funkcji
% Wyjście:
% out - wektor wartości pochodnych 
%
A=[-8/3,2/3; -2/3,-13/3];
b=[1;1];

out = A*y + b*exp(-t)*sin(t);
end % function