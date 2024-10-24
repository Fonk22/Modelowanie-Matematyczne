function [x] = Euler2(A,t,y,x_init)
% funkcja realizujaca niejawna metode eulera
% WEJSCIE:
% WEJSCIE:
% A      - wspolczynniki w rownaniu
% t      - wektor czasu
% x_init - wartosc poczatkowa
% WYJSCIE:
% x      - wektor obliczonych wartosci 
x = zeros(length(t),1);
x(1) = x_init;
for i = 2:length(t)
    del_t = t(i) - t(i-1);
    a = del_t*A(3);
    b = del_t*(A(1)+A(2)*y(i))-1;
    c = x(i-1);
    x(i) = (-b - sqrt(b*b - 4*a*c))/(2*a);
end
end % function