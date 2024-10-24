function [x] = Euler(A,t,y,x_init,fun)
% Funkcja realizujaca jawna metode Eulera
% WEJSCIE:
% A      - wspolczynniki w rownaniu
% t      - wektor czasu
% x_init - wartosc poczatkowa
% fun    - uchwyt do funkcji
% WYJSCIE:
% x      - wektor obliczonych wartosci 
x = zeros(length(t),1);
x(1) = x_init;
for i=2:length(t)
    delta_t = t(i)-t(i-1);
    x(i) = x(i-1) + fun([x(i-1),y(i-1)],A)*delta_t;
end
end % function