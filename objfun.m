function [f,g,s] = orbobj3d(p,szero);  %%% Optimize tf
%%%
%%%..................................................
global tau vexita vinj ginj rinj omegae torb0 torbinj;
global rfin gfin vfin;
global orbform
%%%    n=length(p);
n=length(p)-1;         %%% Minimum Time Problem
al= p([1:n]);               %%% Alpha-Time History
tf= p(n+1);                 %%% Final Time - When optimized !
%%%
 [t,s]=odeu('orbequa3d',al,szero,tf); %%% ------------------
%%% odeu.m  in A.E.Bryson:Dynamic Optimization
%%%                                    Addison Wesley, 1999.
%%%-----------------------------------------------------------------
vfin   =  s(1,n);
gfin   = s(2,n);
cfin   = s(3,n);
rfin   = s(4,n);
lonfin  = s(5,n);
latfin  = s(6,n);
masfin  = s(7,n);
%%%---------------------------------------------
 f = tf;                   %%% MINIMIZE tf !!!
%%%---------------------------------------------
g = [ ];
%%%......................END..........................
