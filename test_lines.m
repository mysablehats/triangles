
A = [ -1; 0.3; 0];
B = [ .9; -0.2; 0];

%draw my lines in 2d:

figure
hold on
plot([A(1) B(1)],[A(2) B(2)])
axis([-2 2 -2 2 ])

aa = linspace(-2, 2);
bb = linspace(-2, 2);
[X,Y] = meshgrid(aa,bb);

for i = 1:100
    for j = 1:100        
        P = [aa(i); bb(j); 0];
        D(j,i) = distptoline(A,B,P);
    end
end
contour(X,Y,D)

%%unittesting distptoline
% A = [0 0 0];
% B = [0 1 0];
% P = [1 1 0];
% R = 1;
% r = distptoline(A,B,P);
% if ~isequal(R,r)
%     error('failed unit test!')
% end
%
% A = [-1 0 0];
% B = [1 0 0];
% P = [1 1 0];
% R = 1;
% r = distptoline(A,B,P);
% if ~isequal(R,r)
%     error('failed unit test!')
% end
%
% A = [0 3 10];
% B = [3 0 10];
% P = [1 1 10];
% R = 3*sqrt(2)/2-sqrt(2);
% r = distptoline(A,B,P);
% if ~isequal(R,r)
%     error('failed unit test!')
% end
%%% the last test failed but with a 1.1102e-16 difference!
