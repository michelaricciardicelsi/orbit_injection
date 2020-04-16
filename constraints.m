function [c,ceq] = orbcons3d(p,szero);
%%%
%%%..................................................
global tau vexita vinj ginj rinj omegae torb0 torbinj;
global rfin gfin vfin;
global orbform;
%%%
ceq(1) = ginj-gfin;
ceq(2) = rinj-rfin;
ceq(3) = vinj-vfin;
%%%
c=[ ];
%%% END
