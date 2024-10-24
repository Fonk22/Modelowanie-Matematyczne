HudsonBay = readmatrix("HudsonBay.csv");
t = HudsonBay(:,1);
x_dok = HudsonBay(:,2);
y_dok = HudsonBay(:,3);
t = t-t(1);
t = 3*t/t(end);

r_xSpan=[0,40];
r_xySpan = [-1,0];
r_xxSpan = [-0.1,1];
x_Span = [10,100];

% Ilość podprzedziałów
n_r_x = 15;
n_r_xy = 10;
n_r_xx = 10;
n_x = 30;

Ax_best=zeros(1,3); % Najlepsze współczynniki w pierwszym równaniu
x_init_best = 0; % Najlepsza wartość początkowa x
Jx_min = Inf; 

for r_x = linspace(r_xSpan(1),r_xSpan(end),n_r_x)
for r_xy = linspace(r_xySpan(1),r_xySpan(end),n_r_xy)
for r_xx = linspace(r_xxSpan(1),r_xxSpan(end),n_r_xx)
for x = linspace(x_Span(1),x_Span(end),n_x)

    A = [r_x,r_xy,r_xx]; % współczynniki w równaniu

    x_przyb = AdamB(A,t,y_dok,x,@fun);
    Jx = sum((x_dok - x_przyb).^2); % Błąd

    if (Jx<Jx_min)
        Ax_best = A;
        x_init_best = x;
        Jx_min = Jx;
    end 

end
end
end
end

% Funkcja błędu 
Fun_Jx = @(args)...
    sum((x_dok - AdamB(args(1:3),t,y_dok,args(end),@fun)).^2);

% Optymalne argumenty
args_opt = fminsearch(Fun_Jx,[Ax_best,x_init_best]);

Ax_best = args_opt(1:3);
x_init_best = args_opt(end);

% b) ----------------------------
r_ySpan=[-40,0];
r_yxSpan = [0,1];
r_yySpan = [-0.1,0];
y_Span = [10,50];

n_r_y = 15;
n_r_yx = 10;
n_r_yy = 10;
n_y = 30;

Ay_best=zeros(1,3);
y_init_best = 0;
Jy_min = Inf;

for r_y = linspace(r_ySpan(1),r_ySpan(end),n_r_y)
for r_yx = linspace(r_yxSpan(1),r_yxSpan(end),n_r_yx)
for r_yy = linspace(r_yySpan(1),r_yySpan(end),n_r_yy)
for y = linspace(y_Span(1),y_Span(end),n_y)

    A = [r_y,r_yx,r_yy]; % Współczynniki w równaniu

    y_przyb = AdamB(A,t,x_dok,y,@fun);
    Jy = sum((y_dok - y_przyb).^2); % Błąd

    if (Jy<Jy_min)
        Ay_best = A;
        y_init_best = y;
        Jy_min = Jy;
    end 
end
end
end
end

Fun_Jy = @(args)...
    sum((y_dok - AdamB(args(1:3),t,x_dok,args(end),@fun)).^2);

args_opt = fminsearch(Fun_Jy,[Ay_best,y_init_best]);

Ay_best = args_opt(1:3);
y_init_best = args_opt(end);

A = [Ax_best,x_init_best; Ay_best,y_init_best];

fms_options = optimset("MaxFunEvals",16000,"MaxIter",16000);

J_handle = @(args) J(args,t,x_dok,y_dok);

args_opt = fminsearch(J_handle,A,fms_options);

odefun = @(t,y) [args_opt(1,1:3)*[y(1);y(1)*y(2);y(1)*y(1)];...
    args_opt(2,1:3)*[y(2);y(1)*y(2);y(2)*y(2)]];
[t_ode, y_ode] = ode45(odefun,[0,3],[args_opt(1,end);args_opt(2,end)]);

figure;
plot(t,x_dok);
hold on
plot(t_ode,y_ode(:,1))
hold off
grid on
title("Proba dopasowania x jawna metoda Adamsa-Bashfortha")
legend("x dokladne", "x przyblizone")
xlabel("t")
ylabel("populacja")

figure;
plot(t,y_dok)
hold on
plot(t_ode,y_ode(:,2))
grid on
title("Proba dopasowania y jawna metoda Adamsa-Bashfortha")
legend("y dokladne", "y przyblizone")
xlabel("t")
ylabel("populacja")
