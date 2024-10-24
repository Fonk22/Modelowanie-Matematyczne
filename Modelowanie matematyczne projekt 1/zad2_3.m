function [t,y] = zad2_3(A,b,x,tspan,h,init_vals)
% Wejście:
%   A         - macierz współczynników
%   b         - macierz współczynników przy funkcji x
%   x         - uchwyt do funkcji
%   tspan     - przedział całkowania
%   h         - rozmiar kroku całkowania 
%   init_vals - macierz wartości początkowych
% Wyjście:
%   t - wektor czasu, w którym zostały obliczone wartości rozwiązania,
%   y - macierz z rozwiązaniem 
% 

% podział przedziału całkowania
t=tspan(1):h:tspan(end);

y=zeros(2,length(t));
B=3*eye(2) - 2*h*A;

% ustawienie wartości początkowych dla metody z podwójnym krokiem
y(:,1:2) = init_vals;

for i=3:length(t)
    y(:,i) = linsolve(B, (4*y(:,i-1)-y(:,i-2)+2*h*b*x(t(i))));
end

end