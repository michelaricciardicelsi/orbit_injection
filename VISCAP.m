function [ok ]= viscap(xearth,yearth,zearth,nrad,rearth,nstep); 
%%%----------------------------------------------------------------------------
hviscap=figure;
%%%
x1=xearth/rearth;
y1=yearth/rearth;
z1=zearth/rearth;
%-----------
npoints=length(xearth);
xearth=xearth(1:nstep:npoints);
yearth=yearth(1:nstep:npoints);
zearth=zearth(1:nstep:npoints);
%%%
sphere;
axis equal;
view([45 45]);
axis([-nrad  nrad  -nrad  nrad   -nrad  nrad]);
hold on 
%%% axis equal;
xe= xearth/rearth;
ye= yearth/rearth;
ze= zearth/rearth;
xlabel(' Y-Earth')
ylabel('-X-Earth')
zlabel(' Z-Earth')
title('ORBIT  TRAJECTORY  in  R-Earth')
plot3(y1(1),-x1(1),z1(1),'rs','MarkerSize',6,'MarkerFaceColor','r');
plot3(y1,-x1,z1,'ks','MarkerSize',2,'LineWidth',1);
comet3(ye,-xe,ze,0.0025);
hold off
ok=1;
%%%-----------------------------------------------
