% G.m
% GO function for the VITE model
% Antonio Ulloa
% Cognitive & Neural Systems
% Sun Oct  8 15:11:08 EDT 2000
% Last updated: Tue Dec 17 18:47:17 EST 2002

function G = G(t)

  global inputData;

  G_0       =  inputData(3);
  beta      =  1; 
  gamma     =  inputData(15);
  n         =  inputData(16);

  G = G_0 .* t.^n ./ (beta.^n + gamma.*t.^n);  %GO function
