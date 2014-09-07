% circuit.m
% VITE equations for grasping model
% Antonio Ulloa
% Cognitive & Neural Systems
% Fri Dec  8 12:32:48 EST 2000
% Last updated: Tue Dec 17 18:47:17 EST 2002

function dx = circuit(t, x)

global inputData;

%--------------------------------------------------------------------------
% Several parameters to be read from input file
%--------------------------------------------------------------------------
alpha    =  inputData(20);        % integration speed for most cells
alpha_V  =  inputData(25);        % integration speed for velocity cells

gamma    =  inputData(12);        % parameter for discrepancy in transport  
delta    =  inputData(13);        % parameter for discrepancy in aperture
epsilon  =  inputData(14);        % parameter for discrepancy in orientation

I_T      =  inputData(2);         % perceived transport target
I_A      =  inputData(1);         % perceived aperture target
I_O      =  inputData(31);        % perceived orientation target

c_at     =  inputData(29);        % cross-coupling aperture to transport
c_ta     =  inputData(30);        % cross-coupling transport to aperture
c_oa     =  inputData(35);        % cross-coupling orientation to aperture

cost     =  inputData(36);        % cost of having the hand open

%--------------------------------------------------------------------------
% The following assigns target data, which can be perturbed at mov. onset 
%--------------------------------------------------------------------------
if (inputData(27)) & (t>0.18)
  I_T=inputData(27);              % distance input
end

if (inputData(28)) & (t>0.2)
  I_A=inputData(28);              % size input
end

if (inputData(34)) & (t>0.18)
  I_O=inputData(34);              % orientation input
end   

%--------------------------------------------------------------------------
% Intialize the vector used for derivatives
%--------------------------------------------------------------------------
dx = zeros(21, 1);

%--------------------------------------------------------------------------
% D_T, transport difference vector 
%--------------------------------------------------------------------------
dx(1) = alpha .* (-x(1) + x(12) - x(3)); 

%--------------------------------------------------------------------------
% V_T, transport velocity cell
%--------------------------------------------------------------------------
dx(2) = alpha_V .* (-x(2) + x(10).*pos(x(1)) );

%--------------------------------------------------------------------------
% P_T, present position vector
%--------------------------------------------------------------------------
dx(3) = x(2) + x(7);              

%--------------------------------------------------------------------------
% D_A, aperture difference vector
%--------------------------------------------------------------------------
dx(4) = alpha .* (-x(4) + x(14) - x(6));

%--------------------------------------------------------------------------
% V_A, aperture velocity cell
%--------------------------------------------------------------------------
dx(5) = alpha_V .* (-x(5) + x(10).* x(4));

%--------------------------------------------------------------------------
% P_A, aperture position vector   
%--------------------------------------------------------------------------
dx(6) =  x(5) + x(8) + x(20) - cost.*x(21);

%--------------------------------------------------------------------------
% C_AT, interneuron for aperture-transport coupling   
%--------------------------------------------------------------------------
dx(7) = alpha .* (-x(7) + c_at .* x(5) );

%--------------------------------------------------------------------------
% C_TA, interneuron for transport-aperture coupling   
%--------------------------------------------------------------------------
dx(8) = alpha.* (-x(8) + c_ta .* x(2) );

%--------------------------------------------------------------------------
% follows the GO signal
%--------------------------------------------------------------------------
dx(10) = alpha_V.*(-x(10)+ G(t) - ...
         x(10).*(gamma.*x(11)+delta.*x(13)+ epsilon.*x(19) ) );

%--------------------------------------------------------------------------
% E_T, detects discrepancies between current target and any new target
%--------------------------------------------------------------------------
dx(11) = alpha.*(-x(11) + abs(I_T - x(12)));

%--------------------------------------------------------------------------
% T_T, cell for internal transport target
%--------------------------------------------------------------------------
dx(12) = alpha .* (-x(12) + I_T);

%--------------------------------------------------------------------------
% E_A, detects discrepancies between current target and any new target
%--------------------------------------------------------------------------
dx(13) = alpha.*(-x(13) + abs(I_A - x(14)));

%--------------------------------------------------------------------------
% T_A, cell for internal aperture target
%--------------------------------------------------------------------------
dx(14) = alpha .* (-x(14) + I_A);

%--------------------------------------------------------------------------
% D_O, orientation difference vector 
%--------------------------------------------------------------------------
dx(15) = alpha .* (-x(15) + x(18) - x(17)); 

%--------------------------------------------------------------------------
% V_O, orientation velocity cell
%--------------------------------------------------------------------------
dx(16) = alpha_V .* (-x(16) + x(10).*pos(x(15)) );

%--------------------------------------------------------------------------
% P_O, present orientation vector
%--------------------------------------------------------------------------
dx(17) = x(16);              

%--------------------------------------------------------------------------
% T_O, cell for internal orientation target
%--------------------------------------------------------------------------
dx(18) = alpha .* (-x(18) + I_O);

%--------------------------------------------------------------------------
% E_O, detects discrepancies between current target and any new target
%--------------------------------------------------------------------------
dx(19) = alpha.*(-x(19) + abs(I_O - x(18)) );

%--------------------------------------------------------------------------
% C_OA, interneuron for orientation-aperture coupling   
%--------------------------------------------------------------------------
dx(20) = alpha .* (-x(20) + c_oa .* x(16) );

%--------------------------------------------------------------------------
% R, this neuron is for P_A self-inhibition
%--------------------------------------------------------------------------
dx(21) = alpha .* (-x(21) + x(6));
