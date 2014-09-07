% der.m
% calculate derivative across a time course
% Antonio Ulloa
% Cognitive & Neural Systems
% Tue Oct 10 11:17:36 EDT 2000

function der = der(t, x)

dx=diff(x);
dt=diff(t);

der=[0; dx./dt];
