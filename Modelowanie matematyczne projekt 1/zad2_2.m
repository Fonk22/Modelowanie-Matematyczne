function [t,y] = zad2_2(tspan,h)
% Wejście:
%   tspan - przedział całkowania
%   h     - rozmiar kroku całkowania 
% Wyjście:
%   t - wektor czasu, w którym zostały obliczone wartości rozwiązania,
%   y - macierz z rozwiązaniem 
%   

% podział przedziału całkowania
t=tspan(1):h:tspan(end);

y=zeros(2,length(t));
for i=2:length(t)
    y(:,i) = y(:,i-1) + h*odefun(t(i-1)+h/2,y(:,i-1)+h/2*...
        odefun(t(i-1),y(:,i-1)));
end
end