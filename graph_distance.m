function D = graph_distance(t,l,p,A,Pts)
%%% i need to make many assumptions here, and I don't like that
%%% ????????
% this is not the distance between graphs, but the distance from a set of
% points Pts to a graph that was decomposed into a set of triangles, lines
% and points
% perhaps to calculate the real distance between graphs, you should
% calculate both distances graph1 to points of a graph2 and graph2 to points of a graph1 and average or sum them together 
D = 0;
for i = 1:size(Pts,1)
    Dt = inf;
    for j = 1:size(t,1)
        Dt = min([Dt distptotri(A(t(j,1),:),A(t(j,2),:),A(t(j,1),:),Pts(i,:))]) ;
    end
    
    Dl = inf;
    for j = 1:size(l,1)
        Dl = min([Dl distptotri(A(l(j,1),:),A(l(j,2),:),Pts(i,:))]) ;
    end
    
    Dp = inf;
    for j = 1:size(p,1)
        Dp = min([Dp norm(A(p(j,1),:)-Pts(i,:))]) ;
    end
    
    D = D + min([Dt Dl Dp]);
    
end

%%% option 1, increasing the number of Pts does not change the distance(?)
averagedistance = 1;
% this is not obvious, so I guess right now it makes sense to divide the
% overall end distance by the number of Pts. This would be fair if the
% points from Pts are evenly distributed. If a point represents a long
% limb, however, big distances will not matter so much since they are
% underrepresented. this might help when precision from hand movements and
% facial features or whatever else i focus on and decide to describe
% better, but it will be a problem when trying to detect leg positions...
if averagedistance
    D = D/size(Pts,1);
end

end