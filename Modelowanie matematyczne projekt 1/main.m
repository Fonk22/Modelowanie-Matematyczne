A=[-8/3,2/3; -2/3,-13/3];
b=[1;1];
x = @(y) exp(-y)*sin(y);

tspan=[0,8];
h = 0.001;

% Zad1
% dsolve ------------------------
Sol = zad1_dsolve(A);
figure("Name","Zad1")

fplot(Sol.y1,tspan)
hold on
fplot(Sol.y2,tspan)
hold off
grid on
grid minor
title("dsolve solution")
legend(["y1","y2"]);
xlabel("t","FontWeight","bold");
ylabel("y(t)","FontWeight","bold");
axis([0,8,-0.006,0.12]);


% Zad2
% a) -------------------------
[t_ode,sol_ode] = zad2_1(tspan);
figure("Name","Zad2")
plot(t_ode,sol_ode(:,1))
hold on
plot(t_ode,sol_ode(:,2))
hold off
grid on
grid minor
title("ode45 solution")
legend(["y1","y2"]);
xlabel("t","FontWeight","bold");
ylabel("y(t)","FontWeight","bold");
axis([0,8,-0.006,0.12]);


% b) ----------------------------
[t1,y1] = zad2_2(tspan,h);
figure;
plot(t1,y1);
grid on
grid minor
title("Modified Euler method")
legend(["y1","y2"]);
xlabel("t","FontWeight","bold");
ylabel("y(t)","FontWeight","bold");
axis([0,8,-0.006,0.12]);

% c) ----------------------------
[t2,y2] = zad2_3(A,b,x,tspan,h,y1(:,1:2));
figure;
plot(t2,y2)
grid on
grid minor
title("Two-step method solution")
legend(["y1","y2"]);
xlabel("t","FontWeight","bold");
ylabel("y(t)","FontWeight","bold");
axis([0,8,-0.006,0.12]);

% d) ----------------------------
[t3,y3] = zad2_4(A,b,x,tspan,h);
figure;
plot(t3,y3)
grid on
grid minor
title("Runge-Kutta method solution")
legend(["y1","y2"]);
xlabel("t","FontWeight","bold");
ylabel("y(t)","FontWeight","bold");
axis([0,8,-0.006,0.12]);

% Zad3


hmin = 0.01;
hmax = 1;
h = linspace(hmin,hmax,1000);
f = matlabFunction([Sol.y1;Sol.y2]);

% metoda1 ------------------------
delta1 = zad3_1(tspan,h,f);

figure("Name","Zad3");
loglog(h,delta1)
title("modified Euler method relative error")
legend(["d1","d2"]);
xlabel("h","FontWeight","bold");
ylabel("d(h)","FontWeight","bold");


%metoda2 -------------------------
delta2 = zad3_2(A,b,x,tspan,h,y1(:,1:2),f);
figure
loglog(h,delta2)
title("Two-step method relative error")
legend(["d1","d2"]);
xlabel("h","FontWeight","bold");
ylabel("d(h)","FontWeight","bold");

%metoda3 -------------------------
delta3 = zad3_3(A,b,x,tspan,h,f);

figure;
loglog(h,delta3)
title("Runge-Kutta method relative error")
legend(["d1","d2"]);
xlabel("h","FontWeight","bold");
ylabel("d(h)","FontWeight","bold");
