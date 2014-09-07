% This is the callbak function for the grasping simulation
% Antonio Ulloa
% Cognitive & Neural Systems
% Fri Dec  8 12:32:48 EST 2000
% Last updated: Tue Dec 17 17:34:48 EST 2002

global inputData;

ans = menu('Choose a simulation',...
           'Saling et al (1996): Small, unperturbed',...
           'Saling et al (1996): Large, unperturbed',...
           'Saling et al (1996): Small, perturbed',...
           'Saling et al (1996): Large, perturbed',...
           'Paulignan et al (1991b): Small, unperturbed',...
           'Paulignan et al (1991b): Small, perturbed',...
           'Paulignan et al (1991a): Small, unperturbed',...
           'Paulignan et al (1991a): Large, unperturbed',...
           'Paulignan et al (1991a): Small, perturbed',...
           'Paulignan et al (1991a): Large, perturbed' );
switch ans
case 1
  inputData = load('salingSmall.dat');
case 2
  inputData = load('salingLarge.dat');
case 3
  inputData = load('salingSmallPerturbed.dat');
case 4
  inputData = load('salingLargePerturbed.dat');
case 5
  inputData = load('paulignan1Small.dat');
case 6
  inputData = load('paulignan1SmallPerturbed.dat');
case 7
  inputData = load('paulignan2Small.dat');
case 8
  inputData = load('paulignan2Large.dat');
case 9
  inputData = load('paulignan2SmallToLarge.dat');
case 10
  inputData = load('paulignan2LargeToSmall.dat');
end  

T_T=inputData(2);            % target transport vector (distance to object)
P_T=inputData(5);            % initial transport position vector
D_T=abs(T_T-P_T);            % transport difference vector is primed
V_T=inputData(24);           % initial transport velocity cell

T_A=inputData(1);            % target aperture vector (object size)
P_A=inputData(7);            % initial aperture position vector
D_A=T_A-P_A;                 % aperture difference vector is primed
V_A=inputData(26);           % initial aperture velocity cell

C_AT=0; C_TA=0; C_OA=0;      % coupling interneurons

GO=0;                        % GO signal cell

E_T=0; E_A=0; E_O=0;         % discrepancies between internal and
                             % perceived targets

T_O=inputData(31);           % object orientation
P_O=inputData(32);           % initial orientation vector
D_O=abs(T_O-P_O);            % orientation difference vector is primed
V_O=inputData(33);           % initial orientation velocity cell

R=0;                         % neuron that inhibits aperture

t0=inputData(9);             % initial time for integration
tf=inputData(10);            % final time for integration
dt=inputData(11);            % time step
tSpan=[t0:dt:tf];            % time span

[t,x]=ode45('circuit',...
            [tSpan],...
            [D_T V_T P_T D_A V_A P_A ... % transport and aperture vectors
             C_AT C_TA ...               % coupling terms
             GO GO ...                   % GO signal cell
             E_T T_T E_A T_A ...         % target and discrepancy vectors
             D_O V_O P_O T_O E_O C_OA ...% orientation vectors
             R ] );                      % aperture reset cell

plotOutput(t, x);            % plot results



