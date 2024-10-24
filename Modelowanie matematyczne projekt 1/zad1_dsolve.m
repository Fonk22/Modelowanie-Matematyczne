function [Sol] = zad1_dsolve(A)
% Wejście:
%   A - macierz współczynników
% Wyjście:
%   Sol - struktura z rozwiązaniem symbolicznym
% 
syms y1(t) y2(t)
x(t) = exp(-t)*sin(t);

% Równania
eqn1 = diff(y1,t) == A(1,1)*y1 + A(1,2)*y2 + x;
eqn2 = diff(y2,t) == A(2,1)*y1 + A(2,2)*y2 + x;

% Warunki początkowe
ic1 = y1(0) == 0;
ic2 = y2(0) == 0;

Sol = dsolve([eqn1,eqn2],[ic1,ic2]);
end