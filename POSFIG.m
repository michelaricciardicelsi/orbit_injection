%%%                                                     posfig.m
%              Set the default figure position, in pixels
%              On small screens, make figure smaller
%                                      with same aspect ratio
%%% ..................................................................
screen = get(0, 'ScreenSize');
width = screen(3);
height = screen(4);
%%% -------------
mwwidth  = 670;
mwheight = 500;
left = width-mwwidth-10;
bottom =height-mwheight-90;
rect = [ left bottom mwwidth mwheight ];
set(0, 'defaultfigureposition',rect);
colordef(0,'white') % Set up for white defaults
