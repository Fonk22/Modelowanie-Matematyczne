function [err] = J (args,t,x_dok,y_dok)
% funkcja dokladnosci dopasowania modelu
% WEJSCIE:
% args  - wspolczynniki w ukladzie rownan rozniczkowych i wartosci
%         poczatkowe
% t     - wektor czasu w jakich dokonano dokladnych pomiarow
% x_dok - wektor dokladnych pomiarow populacji ofiar
% y-dok - wektor dokladnych pomiarow populcaji drapieznikow
% WYJSCIE:
% err   - dokladnosc dopasowania modelu
odefun = @(t,y) [args(1,1:3)*[y(1);y(1)*y(2);y(1)*y(1)];...
    args(2,1:3)*[y(2);y(1)*y(2);y(2)*y(2)]];

[t_ode, y_ode] = ode45(odefun,[0,3],[args(1,end);args(2,end)]);

x_przyb = interp1(t_ode,y_ode(:,1),t);
y_przyb = interp1(t_ode,y_ode(:,2),t);

err = sum((x_przyb - x_dok).^2) + sum((y_przyb- y_dok).^2);

end % function