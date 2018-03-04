function [t, l, p ] = btlp(C)
% passed unit tests. 
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

% t = sort(t,2);
% t = sortrows(t);
% i = 1;
% while(i<size(t,1))
%     if isequal(t(i,:),t(i+1,:))
%         t(i,:) = [];
%     else
%         i = i+1;
%     end
% end

t = removeduplicates_(t);

%% remove all triangle connections to find line connections
% all the borders are accounded for in the triangle distances; proceed

for i = 1:size(t,1)
    C(t(i,1), t(i,2)) = 0;
    C(t(i,2), t(i,3)) = 0;
    C(t(i,1), t(i,3)) = 0;
    %%% zeroing the other side of the matrix
    C(t(i,2), t(i,1)) = 0;
    C(t(i,3), t(i,2)) = 0;
    C(t(i,3), t(i,1)) = 0;

end

for i = 1:(size(C,1)-1)
    for j = (i+1):size(C,2)
        if C(i,j)
            % connected
            l = cat(1,l,[i j]);
        end
    end
end
l = removeduplicates_(l);

%% remove lines to look for isolated points
% actually unnecessary, remove if speed becomes a problem
for i = 1:size(l,1)
    C(l(i,1),l(i,2)) = 0;
    %%% zeroing the other side of the matrix
    C(l(i,2),l(i,1)) = 0;
end

%% I will not use the same approach as before to look for isolated points. too cumbersome
% i will just remove everything that has not been reference before
% the zeroing for lines became actually useless, but whatever. I will remove 
p = setdiff(1:length(C),unique([reshape(t,1,[]), reshape(l,1,[])]));

end
function t = removeduplicates_(t)
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
end
