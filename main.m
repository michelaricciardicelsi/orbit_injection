%%%                                                              
%%%  MINIMUM TIME PROBLEM
%%% SATELLITE  INJECTION INTO A CIRCULAR ORBIT
%%%                             
%%% .............................................................................
clear all
clc;
format compact;
warning('off','MATLAB:dispatcher:InexactMatch');
POSFIG;
global tau vexita vinj ginj rinj omegae torb0 torbinj;
global rfin gfin vfin
global orbform;
disp('  ')
disp('... START main.m - ORBIT INJECTION ...')
%
orbform = 1;                   % ORBIT TO UPPER !!!
                                       % Used in equa3d.m
icap = 1;                          % Used in seesat.m   
%
%%%        - EARTH DATA  - 
rearth      =    6.378135e6;                  % Radius
muearth  =  398.6005e12;                  % Gravitational Parameter (EARTH)
omegae   =  1.0*2*pi/86164;                % EARTH's Angular Rate %%%
gearth       =  muearth/rearth^2;                     % Gravity at R_Earth
%%%
disp('  ')
disp('...EARTH DATA...')
disp('  ')
disp('...Earth Radius...km...')
rearth/1000
disp('  ')
disp('...The mu-Constant...')
muearth
disp('  ')
disp('...Earth Angular Rate...rad/sec...')
omegae
disp('  ')
disp('...Gravity at R_Earth...')
gearth
disp('...m/sec^2...')
disp('  ')
disp('Return to Continue')
pause
disp( '--------------------------------------------------- ') 
% === INITIAL CONDITIONS - TRUE VALUES ======
vel0    = 6000;             %7372;  % Initial Velocity  - m/sec
gam0  = 5*pi/180;   	             % Initial Slope     - rad
chi0    = 0.0*pi/180;                 % Initial Heading   - rad - !!! 0/180: EQUATORIAL ORBIT !!!!
alt0     = 40000;                       % Initial Altitude  - m 
lon0    = 0.0*pi/180;                 % Initial Longitude - rad
lat0     = 0.0*pi/180;                 % Initial Latitude  - rad
mas0  = 430;                         % Initial Mass of the S/C (kg)
%%%..........................................................
tftrue = 200;                            %  200 Final Time (Guess) - sec
clc
disp('---------------------------------------------------')
disp('...INITIAL CONDITIONS...')
disp('  ')
disp('...Altitude...')
alt0
disp('...m...')
disp('  ')
disp('...Velocity...')
vel0
disp('...m/sec...')
disp('  ')
disp('...Trajectory Slope...')
180*gam0/pi
disp('...deg...')
disp('...Trajectory Heading...')
180*chi0/pi
disp('...deg...')
disp('  ')
disp('...Longitude...')
180*lon0/pi
disp('...deg...')
disp('  ')
disp('...Latitude...')
180*lat0/pi
disp('...deg...')
disp('  ')
disp('...Final Time Guess...')
tftrue
disp('...sec...')
disp('  ')
incl0=acos(cos(lat0)*cos(chi0));                      %%%  - Rif:Winh !!
disp('...ORBIT INCLINATION...')
180*incl0/pi
disp('...deg...')
disp('...Return to Continue')
pause
disp('---------------------------------------------------')
%%%
%%%        - ROCKET CHARACTERISICS - 
thrust = 2000;               % Engine Thrust - N
vexitd = 3300;                % Propellant Exit velocity - m/sec
disp('  ')
disp('...ROCKET CHARACTERISTICS...')
disp('  ')
disp('...Thrust...')
thrust
disp('...kg...')
disp('  ')
disp('...Propellant Exit Speed...')
vexitd
disp('...m/sec...')
disp('  ')
disp('...Specific Impulse...')
specimp=vexitd/gearth
disp('...sec...')
disp('  ')
disp('...Engine Mass Flow...')
massflow=thrust/vexitd;
massflow
disp('...kg/(m/sec^2)...')
disp('  ')
disp('...Return to Continue')
pause
disp('----------------------------------------------------')
%%%
%%%       - REFERENCE PARAMETERS - 
rad0=rearth+alt0;                                 % Initial Radius                     
rzero  = 1.0;                                        % Nondimensional Initial Radius
vorb0 = sqrt(muearth/rad0);                 % Orbital Velocity at R_zero
vzero = vel0/vorb0;                              % Nondimensional Initial Velocity
mzero=1.0;                                          % Nondimensional Initial Mass
tau=thrust/(muearth*mas0/rad0^2);       % Nondimensional Rocket Thrust
vexita=vexitd/vorb0;                             % Nondimensional Exit Velocity
%%%
torb0=sqrt(rad0^3/muearth);             % Orbital Characteristic Time at R_zero
tf=tftrue/torb0;                                  % Nondimensional Final Time
%%%
disp('  ')
disp('...REFERENCE PARAMETERS...')
disp('  ')
disp('...Nondimensional Initial Radius...')
rzero
disp('...Circular Orbital Velocity at R_zero...')
vorb0
disp('...m/sec...')
disp('  ')
disp('...Nondimensional Initial Velocity...')
vzero
disp('  ')
disp('...Nondimensional Thrust...')
tau
disp('  ')
disp('...Nondimensional Exit Velocity...')
vexita
disp('  ')
disp('...Orbital Characteristic Time at R_zero...')
torb0
disp('...sec...')
disp('...Return to Continue')
pause
disp('------------------------------------------------------------------')
%%%
%%%                                                 - FINAL CONSTRAINTS - TRUE VALUES - 
altf   =  100000;                         % Final Altitude
rfinal = rearth+altf;                    % Final Radius
gfinal = 0.0*pi/180;                    % Final Slope
vfinal = sqrt(muearth/(rfinal))...
    -omegae*(rfinal)*cos(incl0);         %%% !!!!!!!!!
%%%------------------------------------------------------------------
%%%
%%% NONDIMENSIONAL ORBIT-INJECTION VALUES
%%%
torbinj = sqrt((rearth+altf)^3/muearth);      % Orbital Characteristic Time at R_inj 
vorbinj = sqrt(muearth/(rearth+altf));          % Orbital Velocity at R_inj 
rinj    = (rearth+altf)/(rearth+alt0);
ginj    = gfinal;
%%%         vinj=vfinal/vorbinj; %%% ?????
vinj    = vfinal/vorb0;          %%% !!!!!
disp('  ')
disp('...FINAL CONDITIONS - CONSTRAINED OR NOT...')
disp('  ')
disp('... Final Altitude...')
altf
disp('...m...')
disp('  ')
disp('...Final Velocity...')
vfinal
disp('...m/sec...')
disp('  ')
disp('...Final Trajectory Slope...')
180*gfinal/pi
disp('...deg...')
disp('  ')
disp('...Final Radius...')
rfinal
disp('...m...')
disp(' ----------------------------------------------------- ')
disp('...Return to Continue')
pause
format;
%%% .........................................................
alpha       = 1.0*[1.5:-0.125:-1.5];           % Guess Alpha-Starting 
%%%++++++++++++++
alphanew = alpha;
alphaold   = alpha;
%%%++++++++++++++
pzero=[alpha tf];                 % Parameters to be Computed 
n1=length(alpha);
disp('...Number of points in the Guidance Law:...')
n1
n=n1-1;
un=ones(1,n1);
%%.......................................................................................................
vub = 1.0*(pi/2)*un;         % Upper Bound-Permissible Alpha-Values
vlb   = -vub;                       % Lower Bound
%%........................................................................................................
%%%
%dbkeyboard
pzero=[alpha tf];
%%%------------------------------------------------------%%
%options = optimoptions('fmincon','Display','iter','Algorithm','sqp');


%% options = optimset('Display','iter','MaxIter',100,'LargeScale','off',...
     %%'TolX',1.0e-9,'TolFun',1.0e-9,'TolCon',1.0e-9);
options=optimset('Display', 'iter', 'MaxIter', 100, 'LargeScale', 'off', 'TolX', 2e-6, 'TolFun', 2e-6, 'TolCon', 9e-2, 'Algorithm', 'active-set');

%%%------------------------------------------------------
szero=[vzero gam0 chi0 rzero lon0 lat0 mzero]';  % Initial Conditions
%%%..................................................................
h99=figure;
numb=1:n1;
plot(numb,vub,'r-s',numb,vlb,'g-d',numb,alpha,'b-x')
legend('Upper-B','Lower-B','START-CL')
xlabel('Point Number...')
ylabel('Values')
title('Upper-B, Lower-B, START-CLaw');
grid
hold on
disp('...AT keyboard load the existing ??? Control Law - falpha -...')
disp('... !!! DO NOT LOAD IF YOU HAVE LESS POINTS THAN BEFORE')
disp('...>              load orb3dinj.mat             ') 
yload = input(' LOAD or NOT    y|n                  ','s')
if yload =='y'
    load orb3dinj.mat   
end
keyboard
pzero=[alpha tf];                                 %%% THE UNKNOWNS  !!!!!!!!!!!!!!!!!!!!!!!
figure(h99);
plot(numb,alpha,'m')
legend('UpperB','LowerB','START-CL','OLD-CL')
%%%
disp('...COMPUTATION ....')
disp('...Return to continue')
pause
tstart=cputime;
%%%.....................................................................
% p = fmincon(@orbobj3d,pzero,[],[],[],[],vlb,vub,'orbcons3d',options,szero);  % Optimization Routine
p = fmincon(@objfun,pzero,[],[],[],[],vlb,vub,'constraints', options, szero);
%%%.....................................................................
elapsed=cputime-tstart;
disp('......COMPUTATION TIME......')
disp('  ')
disp(elapsed)
disp('......seconds')
plot(numb,p([1:n1]),'k-s','MarkerSize',6,...
    'MarkerFaceColor','m')
legend('UpperB','LowerB','START-CL','OLD-CL','LAST-CL')
disp('...Return to Continue...')
pause
%%%.....................................................................
szero
keyboard
[f,g,s]=objfun(p,szero);                        % Differential Equations 
%%%
falpha=p([1:n1]);             % Computed Final Guidance Law
finalt=p(n1+1);                % Computed Minimum Time
t=finalt*[0:1/n:1];             % Time-vector
%%% Rename Outputs.................
v   =  s(1,:);                                 % Velocity
g   =  s(2,:);                                 % Slope
c   =  s(3,:);                                  % Heading
r    =  s(4,:);                                  % Radius
lon =  s(5,:);                                 % Longitude
lat  =  s(6,:);                                 % Latitude
mas =s (7,:);                                % S/C Mass
%%%.............................
rp=(rearth+alt0)*r;
xspace=rearth*(lon);
hspace=rp-rearth;
plot(0.001*xspace,0.001*hspace,'r');
hold on;
plot(0.001*xspace,0.001*hspace,'bo');
xlabel('X-Ground TRACK - km')
ylabel('km')
title('C.G. TRAJECTORY - Altitude')
legend('hide')
% if orbform==1
%     legend(['RISEN ORBIT'])
% else
%     legend(['LOWERED ORBIT'])
% end
disp('...Return to Continue...')
pause

disp('  ')
disp('...END OF COMPUTATION !!!!......................')
disp('  ')
disp('...Use figinj3.m to display plots......................')
%%%%                       END 
%%%...................................................
tvar=torb0*t;
tadim=t;
tf=finalt;
alpha=falpha;
alphaold=alpha;
if omegae>0
    disp('...Save orb3dinj.mat...')
    save orb3dinj.mat tvar tadim tf alpha  falpha torb0 vorb0 rearth muearth omegae thrust
else
    disp('...Save orb3d0.mat...')
    save orb3d0.mat tvar tadim tf alpha  falpha torb0 vorb0 rearth muearth omegae thrust
end
%%% Additional Data for dynorb1.m !!!
disp('....................................................................')
disp('  ')
disp('...TRAJECTORY...SYNOPTICS...')
format short e
disp('  ')
disp('    Time        Velocity       Slope       Heading      Altitude    ')
disp('  ')
disp([tvar' vorb0*v' 180/pi*s(2:3,:)' ((rearth+alt0)*r-rearth)'])
disp('  ')
disp('....................................................................')
disp(' ')
disp('     Time        Longitude    Latitude      Mass')
disp([tvar'  180/pi*s(5:6,:)' mas0*mas'])
disp('  ')
disp('++++++++++++++++++++++++')
disp('...!!!  BURNED  PROPELLANT:')
mass  = mas0*mas;
propel = gearth*(mass(1)-mass(n1))
disp('++++++++++++++++++ !!!!    kg')
%%%
h3d=figure;
xearth=0.001*rearth*r.*cos(lat).*cos(lon);
yearth=0.001*rearth*r.*cos(lat).*sin(lon);
zearth=0.001*rearth*r.*sin(lat);
plot3(yearth,-xearth,zearth);
xlabel(' Y-Earth - km')
ylabel('-X-Earth - km')
zlabel(' Z-Earth - km')
grid
hold on
plot3(yearth,-xearth,zearth,'ro',...
    'LineWidth',1,'MarkerFaceColor','g','MarkerSize',8);
% stem3(yearth,-xearth,zearth,'ro');
plot3(1.0*yearth,-1.0*xearth,0.0*zearth,'b*-');
% plot3(1.0*yearth,-0.0*xearth,1.0*zearth,'m');
% plot3(0.0*yearth,-1.0*xearth,1.0*zearth,'m');
title('INJECTION TRAJECTORY - EARTH FRAME')
%%%
uvel  =  vorb0*v.*cos(g).*sin(c);
vvel  =  vorb0*v.*cos(g).*cos(c);
wvel = -vorb0*v.*sin(g);
%-----------------------
xdot=-uvel.*sin(lat).*cos(lon) -vvel.*sin(lon)-wvel.*cos(lat).*cos(lon);
%
ydot=-uvel.*sin(lat).*sin(lon)+vvel.*cos(lon)-wvel.*cos(lat).*sin(lon);
%
zdot=uvel.*cos(lat)-wvel.*sin(lat);
%-------------------------------------------
scale=0.25;
quiver3(yearth,-xearth,zearth,ydot,-xdot,zdot,scale,'b')
axis equal;
hold off
%%%...............................
disp('...Return to Continue...')
pause
radius=(rearth+alt0)*r;
hpol=figure;
polar(lon,radius-rearth,'k');
hold on
polar(lon,radius-rearth,'rs');
title('TRAJECTORY POLAR PLOT')
%%% ------------------------------------------------------
%%%
valrate   = 1;
npstore = 10000;
decim    = 10;
itrajec = input('Display trajectory ? y | n               ','s')
if itrajec == 'y'
    nrad      = 1.1;
    nstep     = 1;
    [ok ] = viscapxyz(1000*xearth,1000*yearth,1000*zearth,nrad,rearth,nstep);
end
%%%
disp('   DATA SAVED IN ... orbinj1.mat ...')
save orbinj1.mat 
disp('... Now run ... figinj.m ...')
figinj









