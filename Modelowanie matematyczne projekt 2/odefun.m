function [out] = odefun(t,y)

A = [10.0063   -0.0989   -0.0023; -9.4740    0.0694   -0.0059];

out=[A(1,1)*y(1)+A(1,2)*y(1)*y(2)+A(1,3)*y(1)*y(1);...
    A(2,1)*y(2)+A(2,2)*y(1)*y(2)+A(2,3)*y(2)*y(2)];
end