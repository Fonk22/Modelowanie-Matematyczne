function [x] = AdamB(A,t,y,x_init,fun)
% Funkcja realizujaca metode Adama-Bashfortha
% WEJSCIE:
% A      - wspolczynniki w rownaniu
% t      - wektor czasu
% x_init - wartosc poczatkowa
% fun    - uchwyt do funkcji
% WYJSCIE:
% x      - wektor obliczonych wartosci 
x = zeros(length(t),1);
x(1) = x_init;
x(2) = x(1) + fun([x(1),y(1)],A)*(t(2)-t(1));
for i=3:length(t)
    delta_t = t(i)-t(i-1);
    x(i) = x(i-1) + (3/2*fun([x(i-1),y(i-1)],A) ...
        -1/2 * fun([x(i-2),y(i-2)],A))*delta_t;
end
end % function