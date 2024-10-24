% Czytanie z pliku
dane = readmatrix("dane22.csv");
t = dane(:,1);
x_dok = dane(:,2);
y_dok = dane(:,3);

% Przedziały
r_xSpan=[0,40];
r_xySpan = [-1,0];
r_xxSpan = [-0.1,1];
x_Span = [100,1000];

% Ilość podprzedziałów
n_r_x = 20;
n_r_xy = 10;
n_r_xx = 10;
n_x = 50;

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

figure;
plot(t,x_dok)
hold on;

% Funkcja błędu 
Fun_Jx = @(args)...
    sum((x_dok - AdamB(args(1:3),t,y_dok,args(end),@fun)).^2);

% Optymalne argumenty
args_opt = fminsearch(Fun_Jx,[Ax_best,x_init_best]);

Ax_best = args_opt(1:3);
x_init_best = args_opt(end);

plot(t,AdamB(Ax_best,t,y_dok,x_init_best,@fun))
hold off;
title("x wyznaczone metodą Adamsa-Bashfortha")
xlabel("t")
ylabel("populacja")
legend("x dokładne", "x przybliżone")
grid("on")

% b) ----------------------------
r_ySpan=[-40,0];
r_yxSpan = [0,1];
r_yySpan = [-0.1,0];
y_Span = [10,200];

n_r_y = 20;
n_r_yx = 10;
n_r_yy = 10;
n_y = 50;

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

figure
plot(t,y_dok)
hold on;
Fun_Jy = @(args)...
    sum((y_dok - AdamB(args(1:3),t,x_dok,args(end),@fun)).^2);

args_opt = fminsearch(Fun_Jy,[Ay_best,y_init_best]);

Ay_best = args_opt(1:3);
y_init_best = args_opt(end);

plot(t,AdamB(Ay_best,t,x_dok,y_init_best,@fun))
hold off;
title("y wyznaczone metodą Adamsa-Bashfortha")
xlabel("t")
ylabel("populacja")
legend("y dokładne", "y przybliżone")
grid("on")