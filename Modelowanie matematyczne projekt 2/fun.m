function [out] = fun(y,A)
% funkjca reprezentująca pojedyńcze równanie w układzie równań
% różniczkowych
% WEJŚCIE:
% y - dwuelementowy wektor zawierający wartości pierwszej i drugiej
%     funkcji w równaniu
% A - Wektor współczynników w równaniu
% WYJŚCIE:
% out - obliczona wartość pochodnej 
out = A*[y(1);y(1)*y(2);y(1)*y(1)];
end % function

