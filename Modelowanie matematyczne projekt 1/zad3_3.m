function [delta] = zad3_3(A,b,x,tspan,h,fun)
% Wejście:
%   A     - macierz współczynników
%   b     - macierz współczynników przy x
%   x     - uchwyt do funkcji
%   tspan - przedział całkowania
%   h     - krok całkowania
%   fun   - uchwyt do funkcji wzorcowej
% Wyjście:
%   delta - macierz z zagregowanymi błędami względnymi
%
delta=zeros(2,length(h));
for i=1:length(h)
    [t,y] = zad2_4(A,b,x,tspan,h(i));
    y_dok = fun(t);
    delta(:,i) = sum((y - y_dok).^2,2) ./ sum(y_dok.^2,2);
end

end