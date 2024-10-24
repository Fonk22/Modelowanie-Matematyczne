% Wspolczynniki z zadania 3 a)
A = [11.5414557952839, -0.113284961890873,-0.00173440186216480;...
    -8.03168152879862, 0.0606278266074272,-0.00574306691813943];

syms x y
eq1 = A(1,:)*[x; x*y; x*x] == 0;
eq2 = A(2,:)*[y; x*y; y*y] == 0;

sol = solve([eq1,eq2],x,y);
x_init = round(double(sol.x(2,1)));
y_init = round(double(sol.y(2,1)));

[t_eul, y_eul] = Euler_zad3(A,[0,3],0.001,[x_init, y_init]);

figure()
plot(t_eul,round(y_eul,0,"decimals",TieBreaker="tozero"))
title("Rownowaga układu")
legend("populacja ofiar", "populacja drapieżników");
grid("on")
xlabel("t")
ylabel("populacja")
