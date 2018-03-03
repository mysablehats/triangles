%distance from point P to triangle ABC:
% based on the response from Jordi from https://math.stackexchange.com/questions/588871/minimum-distance-between-point-and-face

A = [ 0; 0; 1];
B = [ 0; 1; 0];
C = [ 1; 0; 0];

P = [1; 1; 1 ];

D = distptotri(A,B,C,P);
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


function D = distptoline(A,B,P)
% based on the response from orr from https://math.stackexchange.com/questions/708499/finding-distance-from-point-to-line-determined-by-vector
projPA = dot(P-A,B-A)/(norm(B-A)).^2*(B-A);
D = norm(P-A-projPA);
end

function D = distptotri(A,B,C,P)
a = B-A;
b = C-A;

N = cross(a,b)/norm(cross(a,b));

% no need to calculate p0 actually...
% p0 = P +(dot(N,A)-dot(N,P))*N;
% D = norm(P-p0);
D = dot(N,A)-dot(N,P);

S = linsolve([A B C],p0);

if any(S>1)||any(S<0)
    % this means that the point is exterior to the triangle
    %must do tons of checks
    %A if the only positive is alpha
    D = [];
    %% since there is a problem with obtuse triangles I 
    if S(1)>0&&(S(2)<0&&S(3)<0)
        D = norm(P-A);
    end
    %B if the only positive is beta
    if S(2)>0&&(S(1)<0&&S(3)<0)
        D = norm(P-B);
    end
    %C if the only positive is gamma
    if S(3)>0&&(S(1)<0&&S(1)<0)
        D = norm(P-C);
    end
    %now check line segments distances
    
else
    % don nothing D is already the distance
end

end