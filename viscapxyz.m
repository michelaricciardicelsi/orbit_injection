function [ok ]= viscapxyz(xearth,yearth,zearth,nrad,rearth,nstep); 
%%%----------------------------------------------------------------------------
% hviscap=figure;
%%%
x1=xearth/rearth;
y1=yearth/rearth;
z1=zearth/rearth;
%-----------
npoints=length(xearth);
%%%
h66=figure;
sphere;
axis equal;
view([45 45]);
axis([-nrad  nrad  -nrad  nrad   -nrad  nrad]);
hold on 
xlabel(' X-Earth')
ylabel(' Y-Earth')
zlabel(' Z-Earth')
title('ORBIT  TRAJECTORY  in  R-Earth')
% plot3(xe,ye,ze,'rs','MarkerSize',6,'MarkerFaceColor','r');
plot3(x1(1),y1(1),z1(1),'rs','MarkerSize',6,'MarkerFaceColor','r');
hold on
x2 = x1(1:nstep:end);
y2 = y1(1:nstep:end);
z2 = z1(1:nstep:end);
%%%
plot3(x2,y2,z2,'ko','MarkerSize',4,'LineWidth',1,'MarkerFaceColor','r');
comet3(x1,y1,z1);
% hold off
ok=1;
%%% -------------------------------------------------------
