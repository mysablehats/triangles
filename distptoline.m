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
