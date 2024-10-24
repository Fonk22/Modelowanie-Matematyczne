function [t,y] = zad2_4(A,b,x,tspan,h)
% Wejście:
%   A         - macierz współczynników
%   b         - macierz współczynników przy funkcji x
%   x         - uchwyt do funkcji
%   tspan     - przedział całkowania
%   h         - rozmiar kroku całkowania 
% Wyjście:
%   t - wektor czasu, w którym zostały obliczone wartości rozwiązania,
%   y - macierz z rozwiązaniem 
% 

% podział przedziału całkowania
t = tspan(1):h:tspan(end);
y = zeros(2,length(t));

I = eye(2); % macierz jednostkowa

% współczynniki z tabeli Butchera
a = [1/6, -1/6, 0; 1/6, 1/3, 0; 1/6, 5/6, 0];
c = [0; 1/2; 1];
w = [1/6, 2/3, 1/6];

% macierz wpółczynników przy f1, f2 i f3
L = [I-h*a(1,1), -h*a(1,1)*A, -h*a(1,3)*A;...
    -h*a(2,1)*A, I-h*a(2,2)*A, -h*a(2,3)*A;...
    -h*a(3,1)*A, -h*a(3,2)*A, I-h*a(3,3)*A];


for i=2:length(t)
    % macierz wyrazów wolnych
    p = [A*y(:,i-1) + b*x(t(i-1)+c(1)*h); ...
        A*y(:,i-1) + b*x(t(i-1)+c(2)*h); ...
        A*y(:,i-1) + b*x(t(i-1)+c(3)*h)];
    f = linsolve(L,p);
    s = zeros(2,1);
    for j=1:3
        s = s+w(j)*f(j*2-1:j*2);
    end
    y(:,i) = y(:,i-1) + h*s;
end

end