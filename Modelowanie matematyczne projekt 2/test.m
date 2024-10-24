A = [10.0063   -0.0989   -0.0023; -9.4740    0.0694   -0.0059];
[t_ode,y_ode] = Euler_zad3(A,[0,3],0.001,[375.5523,24.7469]);
plot(t_ode,y_ode(1,:))
hold on
%plot(t_ode,y_ode(:,2))
plot(t,x_dok)
hold off