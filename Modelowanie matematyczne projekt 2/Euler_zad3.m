function [t,y] = Euler_zad3(A,tspan,h,y_init)
% funkcja realizujaca jawna metode eulera dla calego ukladu rownan
% rozniczkowych
% WEJSCIE:
% A      - Macierz wspolczynnikow w ukladzie rownanan
% tspan  - przedzial czasu 
% h      - krok calkowy
% y_init - wektory wartosci poczatkowych x i y
% WYJSCIE:
% t      - wektor czasu
% y      - rozwiazanie ukladu rownan rozniczkowych
odefun = @(y) [A(1,1:3)*[y(1);y(1)*y(2);y(1)*y(1)];...
    A(2,1:3)*[y(2);y(1)*y(2);y(2)*y(2)]];
t = tspan(1):h:tspan(end);
y=zeros(2,length(t));
y(:,1) = y_init;
for i = 2:length(t)
    y(:,i) = y(:,i-1) + odefun(y(:,i-1))*h;
end
end % function