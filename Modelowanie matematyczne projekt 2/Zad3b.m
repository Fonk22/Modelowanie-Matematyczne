% Wspolczynniki wyznaczone w zadaniu 2b)
A = [7.0844   -0.0677   -0.0045; -8.3415    0.0591   -0.0011];
x1 = 367.9547;
y1 = 40.0113;

dane = readmatrix("dane22.csv");
t = dane(:,1);
x_dok = dane(:,2);
y_dok = dane(:,3);

fms_options = optimset("MaxFunEvals",8000,"MaxIter",8000);

% Uchwyt do funkci dopasowania modelu do danych
J_handle = @(args) J(args,t,x_dok,y_dok);

% Znalezienie najlepszych parametrow i wartosci poczatkowych
args_opt = fminsearch(J_handle,[A,[x1;y1]],fms_options);

% Rozwiazanie ukladu dla najlepszych wspolczynnikow
[t_eul, y_eul] = ...
    Euler_zad3(args_opt(:,1:3),[0,3],0.01,[args_opt(1,end);args_opt(2,end)]);

figure
plot(t, x_dok);
hold on
plot(t_eul,y_eul(1,:));
hold off
title("x wyznaczone z użyciem jawnej metody eulera ")
xlabel("t")
ylabel("populacja")
legend("x dokładne", "x przybliżone")
grid("on")

figure
plot(t, y_dok);
hold on
plot(t_eul,y_eul(2,:));
hold off
title("y wyznaczone z użyciem jawnej metody eulera ")
xlabel("t")
ylabel("populacja")
legend("y dokładne", "y przybliżone")
grid("on")

function [err] = J (args,t,x_dok,y_dok)
% funkcja dokladnosci dopasowania modelu
% WEJSCIE:
% args  - wspolczynniki w ukladzie rownan rozniczkowych
% t     - wektor czasu w jakich dokonano dokladnych pomiarow
% x_dok - wektor dokladnych pomiarow populacji ofiar
% y-dok - wektor dokladnych pomiarow populcaji drapieznikow
% WYJSCIE:
% err   - dokladnosc dopasowania modelu
[t_eul, y_eul] = ...
    Euler_zad3(args(:,1:3),[0,3],0.01,[args(1,end);args(2,end)]);

x_przyb = interp1(t_eul,y_eul(1,:),t);
y_przyb = interp1(t_eul,y_eul(2,:),t);

err = sum((x_przyb - x_dok).^2) + sum((y_przyb- y_dok).^2);

end % function