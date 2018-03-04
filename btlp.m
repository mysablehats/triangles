function [t, l, p ] = btlp(C)
t = [];
l = [];
p = [];
%% go through C find all triangles
for i = 1:size(C,1)
    for j = (i+1):size(C,2)
        if C(i,j)
            %% they are connected
            A = C(i,:);
            B = C(j,:);
            A(i) = 0;
            B(j) = 0;
            common = and(A,B);
            for k = 1:length(common)
                if common(k)
                    % this is a triangle, so add to triangle list
                    t = cat(1,t,[i j k ]);
                end
            end
        end
    end
end
%% remove duplicate triangles
% tested seems to work
% t = [[1 2 3]; [2 3 1]; [3 6 8]; [2 3 4]; [1 3 2]] %% test t

t = sort(t,2);
t = sortrows(t);
i = 1;
while(i<size(t,1))
    if isequal(t(i,:),t(i+1,:))
        t(i,:) = [];
    else
        i = i+1;
    end
end
%% remove all triangle connections to find line connections

