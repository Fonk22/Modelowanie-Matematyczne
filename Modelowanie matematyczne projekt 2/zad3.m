% Wspolczynniki i wartosci poczatkowe z zadania 1
A = [10.2943   -0.0630   -0.0228; -5.0148    0.0584   -0.0275];
x1 = 428.4096;
y1 = 47.3206;

dane = readmatrix("dane22.csv");
t = dane(:,1);
x_dok = dane(:,2);
y_dok = dane(:,3);

fms_options = optimset("MaxFunEvals",8000,"MaxIter",8000);

% Uchwyt do funkci dopasowania
J_handle = @(args) J(args,t,x_dok,y_dok);

% Znalezienie najlepszych wspolczynnikow i wartosci poczatkowych
args_opt = fminsearch(J_handle,[A,[x1;y1]],fms_options);

% Rozwiazanie ukladu dla najlepszych wspolczynnikow
odefun = @(t,y) [args_opt(1,1:3)*[y(1);y(1)*y(2);y(1)*y(1)];...
    args_opt(2,1:3)*[y(2);y(1)*y(2);y(2)*y(2)]];
[t_ode, y_ode] = ode45(odefun,[0,3],[args_opt(1,end);args_opt(2,end)]);

figure
plot(t, x_dok);
hold on
plot(t_ode,y_ode(:,1));
hold off
title("x wyznaczone z użyciem ode45 ")
xlabel("t")
ylabel("populacja")
legend("x dokładne", "x przybliżone")
grid("on")

figure
plot(t, y_dok);
hold on
plot(t_ode,y_ode(:,2));
hold off
title("y wyznaczone z użyciem ode45 ")
xlabel("t")
ylabel("populacja")
legend("y dokładne", "y przybliżone")
grid("on")
