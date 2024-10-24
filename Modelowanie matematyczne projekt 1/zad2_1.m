function [t_ode,sol_ode] = zad2_1(tspan)
% Wejście:
%   tspan - przedział całkowania
% Wyjście:
%   t_ode - wektor czasu, w którym zostały obliczone wartości rozwiązania,
%   sold_ode - macierz, gdzie każda kolumna odpowiada jednemu z
%   elementów rozwiązania równania różniczkowego.
[t_ode,sol_ode] = ode45(@odefun,tspan,[0,0]);
end