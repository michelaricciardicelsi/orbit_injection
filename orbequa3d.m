function [f1,f2] = orbequa3d(al,x,t,flg);
%%%
%%% Differential Equations for SATELLITE Injection - Generic Orbit !!!
%%%
global tau vexita vinj ginj rinj omegae torb0 torbinj;
global orbform;
%%%...................................................
%%%...RENAME STATES....
vel   = x(1);
gam = x(2);
chi   = x(3);
rad   = x(4);
lon   = x(5);
lat    = x(6);
mas = x(7); 
%%%...................................
%%%
                   cphi=1;    sphi=0; %%% NO ROLL  !!!
cosa=cos(al);
sina=sin(al);
%%%...................................
cgam  =cos(gam);       sgam=sin(gam);
%%%
cchi  =cos(chi);             schi=sin(chi);
%%%
clon  =cos(lon);             slon=sin(lon);
%%%
clat  =cos(lat);               slat=sin(lat);
%%%...................................
%%%.******************************** DIFFERENTIAL EQUATIONS
vdot=...
         orbform*tau/mas*cosa-sgam/rad^2+...
         (omegae*torb0)^2*rad*clat*(clat*sgam-cgam*schi*slat);
%%%----------------------------------------------------------------------------
gdot=...
         orbform*tau/(mas*vel)*sina*cphi+cgam*(vel/rad-1/(vel*rad^2))...
         +2*omegae*torb0*clat*cchi...
         +(omegae*torb0)^2*rad/vel*clat*(cgam*clat+sgam*schi*slat); 
%%%------------------------------------------------------------------------------------
cdot=...
           orbform*tau*sina*sphi/cgam/mas/vel...
          -vel/rad*cgam*cchi*tan(lat)...
          +2*omegae*torb0*(tan(gam)*schi*clat-slat)...
          -(omegae*torb0)^2*rad/vel/cgam*cchi*slat*clat;
%%%----------------------------------------------------------------
rdot=vel*sgam;                                %%% d(rad)/dt
%%%
londot=vel/rad*cgam*cchi/clat;      %%% d(lon)/dt
%%%
latdot=vel/rad*cgam*schi;              %%% d(lat)/dt  
%%%
masdot=-tau/vexita;                         %%% d(mas)/dt
%%%-----------------------------------------------------------
%%%
f1=[vdot;gdot;cdot;rdot;londot;latdot;masdot];
%%%

