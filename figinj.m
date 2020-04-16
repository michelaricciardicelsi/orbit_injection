%%%                                                     figinj.m
%%%
%% PLOTS  results of the optimixation process
%%%---------------------------------------      
tod=180/pi;
maxn=n+1;
tp=torb0*t;
vp=vorb0*v;
gp=g;
rp=(rearth+alt0)*r;
maxalt=max(rp'-rearth);
%%%
vorbi=1.0./sqrt(rp/muearth);
mp=mas0*mas;
vp=vorb0*v;
gp=g;
lonp = lon;
latp =  lat;
rp=(rearth+alt0)*r;
maxalt=max(rp'-rearth);
%%%
vorbi=1.0./sqrt(rp/muearth);
mp=mas0*mas;
%%%
h1=figure;
subplot(221);
plot(tp,vp);
hold on;
plot(max(tp),vfinal,'ko','MarkerFaceColor','r')
ylabel('m/sec')
title('VELOCITY')
grid
maxvp=max(vp);
legend(['VCirc-E=',num2str(round(vfinal))]);
plot(0,vel0,'ko','MarkerFaceColor','g')
hold off;
subplot(222);
plot(tp,tod*gp);
ylabel('deg')
title('SLOPE')
hold on;
plot(max(tp),tod*gfinal,'ko','MarkerFaceColor','r');
grid;
vcirc=sqrt(muearth/(rp(maxn)));
legend(['VCirc-IN=',num2str(round(vcirc))]);
plot(0,tod*gam0,'ko','MarkerFaceColor','g')
hold off;
%%%
subplot(223);
plot(tp,0.001*rp);
xlabel('Time - sec')
ylabel('km')
title('RADIUS')
hold on;
plot(max(tp),0.001*(rearth+altf),'ro','MarkerFaceColor','r');
grid
legend(['H-fin=',num2str(round(rp(maxn)-rearth))],4);
plot(0,0.001*(rearth+alt0),'ko','MarkerFaceColor','g')
hold off;
%%%
subplot(224);
plot(tp(end),mp(end),'ok','MarkerFaceColor','g')
hold on;
plot(tp,mp);
wfuel= round((max(mp)-min(mp)));
legend(['Fuel = ',num2str(wfuel),' kg'])
xlabel('Time - sec')
ylabel('kg');
title('S/C MASS - kg')
grid
disp('Return to Continue')
pause
%%%
h2=figure;
plot(tp,tod*falpha,'bs-')
hold on;
% plot(tp,tod*falpha,'bs')
plot(tp(1),tod*falpha(1),'ks','MarkerSize',8,'MarkerFaceColor','g')
plot(tp(end),tod*falpha(end),'ks','MarkerSize',8,'MarkerFaceColor','y')
plot(tp(1),tod*max(falpha),'kd','MarkerSize',9,'MarkerFaceColor','m')
plot(tp(1),tod*min(falpha),'kh','MarkerSize',9,'MarkerFaceColor','r')
xlabel('Time - sec')
ylabel('deg')
title('CONTROL ANGLE - alpha-Time History')
grid
legend(['Computed'],['Initial Value = ',num2str(tod*falpha(1),3),' ?'],...
                                 ['Final Value = ',num2str(tod*falpha(end),3),' ?'],...
                                 ['Max. Value = ',num2str(tod*max(falpha),3),' ?'],...
                                 ['Min. Value = ',num2str(tod*min(falpha),3),' ?']);      
%%%
disp('Return to Continue')
pause
thetap=gp+falpha;  %%%%.............!!!
ap=lon;
h3=figure;
plot(tp,tod*thetap,'r-s');
hold on;
plot(tp,tod*falpha,'g-d');
plot(tp,tod*gp,'b-o');
plot(tp,tod*ap,'m-*')
xlabel('Time - sec')
ylabel('deg')
title('S/C ANGLES')
grid
legend('Elevation','Alpha','Slope','R-Angle');
disp('Return to Continue')
pause
%%%
h4=figure;
xspace=rearth*(lon);
hspace=rp-rearth;
plot(0.001*xspace,0.001*hspace,'r');
hold on;
plot(0.001*xspace,0.001*hspace,'bo');
xlabel('X-Ground TRACK - km')
ylabel('km')
title('C.G. TRAJECTORY - Altitude')
if orbform==1
    legend(['RISEN ORBIT'])
else
    legend(['LOWERED ORBIT'])
end
grid
%%% ANCILLARY COMPUTATION
atang=thrust*cos(falpha)./mp;
anorm=thrust*sin(falpha)./mp;
%%%
ifig2 = 1;
cp=tod*c;
chifinal = cp(end);
lonp = tod*lon;
lonfinal = lonp(end);
latp = tod*lat;
latfinal = latp(end);
disp('Return to Continue')
pause
%%%
h5=figure;
subplot(211);
plot(tp(1),tod*chi0,'ks','MarkerfaceColor','r')
hold on;
plot(max(tp),chifinal,'ko','MarkerfaceColor','g')
plot(tp,cp);
ylabel('deg')
title('HEADING')
grid
legend(['Initial Value= ',num2str(round(tod*chi0))],...
            ['Final  Value= ',num2str(round(chifinal))],3);
%%%
subplot(212);
plot(tp(1),tod*lat0,'ks','MarkerfaceColor','r')
hold on;
plot(max(tp),latfinal,'ko','MarkerfaceColor','g');
plot(tp,latp);
xlabel('Time - sec')
ylabel('deg')
title('LATITUDE')
hold on;
grid;
legend(['Initial Value= ',num2str(round(tod*lat0))],...
    ['Final Value= ',num2str(round(latfinal))]);
%%%-----------------------------------------------------------------------------
if chi0==0
    save orbcom3a.mat tp gp thetap rp vp thrust
end
%
if chi0==45*pi/180
    save orbcom3b.mat tp gp thetap rp vp thrust
end












