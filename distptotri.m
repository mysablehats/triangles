function D = distptotri(A,B,C,P)
%distance from point P to triangle ABC:
% based on the response from Jordi from https://math.stackexchange.com/questions/588871/minimum-distance-between-point-and-face

a = B-A;
b = C-A;

N = cross(a,b)/norm(cross(a,b));

p0 = P +(dot(N,A)-dot(N,P))*N;
D0 = norm(P-p0);

S = linsolve([A B C],p0);

if any(S>1)||any(S<0)
    % this means that the point is exterior to the triangle

    D12 = distptoline(A,B,P);
    D23 = distptoline(B,C,P);
    D13 = distptoline(A,C,P);
    D = min( [D12, D23, D13]);
else
    D = D0;
end

end