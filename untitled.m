function D = distptotri(A,B,C,P)
a = B-A;
b = C-A;

N = cross(a,b)/norm(cross(a,b));

p0 = P +(dot(N,A)-dot(N,P))*N;
% D = norm(P-p0);
D0 = dot(N,A)-dot(N,P);

S = linsolve([A B C],p0);

if any(S>1)||any(S<0)
    % this means that the point is exterior to the triangle

    D12 = distptoline(A,B,P);
    D23 = distptoline(B,C,P);
    D13 = distptoline(A,C,P);
    D = min( D12, D23, D13);
else
    D = D0;
end

end


function D = distptoline(A,B,P)
%%% this is now transformed to distance to line segment!
% based on the response from orr from https://math.stackexchange.com/questions/708499/finding-distance-from-point-to-line-determined-by-vector
n1 = dot(P-A,B-A);
n2 = dot(P-B,B-A);

if n1<=0&&n2<=0
    % it is closer to A
    D = norm(P-A);
elseif n1>=0&&n2>=0
    % it is closer to B
    D = norm(P-B);
else
    projPA = dot(P-A,B-A)/(norm(B-A)).^2*(B-A);
    D = norm(P-A-projPA);
end
end
