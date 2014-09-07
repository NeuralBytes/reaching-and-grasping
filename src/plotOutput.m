% plotOutput.m
% Plot and write results of grasping simulation
% Antonio Ulloa
% Cognitive & Neural Systems
% Fri Dec  8 12:32:48 EST 2000
% Last Updated: Tue Dec 17 17:15:54 EST 2002

function plotOutput = plotOutput (t,x)
  
global inputData;

if inputData(28)
  objectSize=inputData(28);
else
  objectSize=inputData(1);
end

if inputData(27)
  reachingDistance=inputData(27);
else
  reachingDistance=inputData(2);
end

Gamma=inputData(19);
G_0   =  inputData(3);

D_T=x(:, 1); V_T=x(:, 2); P_T=x(:, 3); 
D_A=x(:, 4); V_A=x(:, 5); P_A=x(:, 6); 
GO= x(:,10); E_T=x(:,11); T_T=x(:,12);
E_A=x(:,13); T_A=x(:,14);
D_O=x(:,15); V_O=x(:,16); P_O=x(:,17);
T_O=x(:,18); E_O=x(:,19);
R1 =x(:,21);
C_TA=x(:,8); C_OA=x(:,20); 
%---------------------------------------------
% calculate results to plot and print

[maximumPos,index]=max((P_T>=reachingDistance) .* (der(t, P_T)<=0.05));   
movementTime=t(index)

[maxWristVel,index]=max(V_T);
timeOfMaxWristVel=t(index);

[finalAp,index]=max((P_T>=reachingDistance) .* (P_A<objectSize));
%[finalAp,index]=max((P_T>=reachingDistance./1.5) .* (P_A<objectSize));
graspingTime=t(index);

% truncate aperture when contact occurs
pGrasp = cat(1, P_A(1:index-1), objectSize*ones(length(P_A)-(index-1), 1) );
vGrasp = der(t, P_A);
vGrasp = cat(1, vGrasp(1:index-1), zeros(length(vGrasp)-(index-1), 1) );

[maxAp,index]=max(pGrasp);
timeOfMaxHandAp=t(index);

% calculate percentages
percentMWV=timeOfMaxWristVel.*100./movementTime;
percentTMA=timeOfMaxHandAp.*100./graspingTime

encloseTime=graspingTime-timeOfMaxHandAp

apertureTime = graspingTime - encloseTime

mga = max(pGrasp)

%--------------------------------------------------------
% plot evolution of variables in a window with subwindows
%--------------------------------------------------------
figure;

subplot(4,3,1); 
plot(t, P_T, 'lineWidth', 2); 
axis tight;
title('Pt');

subplot(4,3,2); 
plot(t, pGrasp, 'lineWidth', 2); 
axis tight;
title('Pa');

subplot(4,3,3); 
plot(t, P_O, 'lineWidth', 2); 
axis tight;
title('Po');

subplot(4,3,4); 
plot(t, der(t, P_T), 'lineWidth', 2); 
axis tight;
title('Vt');

subplot(4,3,5); 
plot(t, vGrasp, 'lineWidth', 2); 
axis tight;
title('Va');

subplot(4,3,6); 
plot(t, der(t, P_O), 'lineWidth', 2); 
axis tight;
title('Vo');

subplot(4,3,7); 
plot(t, D_T, 'lineWidth', 2); 
axis tight;
title('Dt');

subplot(4,3,8); 
plot(t, D_A, 'lineWidth', 2); 
axis tight;
title('Da');

subplot(4,3,9); 
plot(t, D_O, 'lineWidth', 2); 
axis tight;
title('Do');

subplot(4,3,10); 
plot(t, E_T, 'lineWidth', 2); 
axis tight;
title('Et');

subplot(4,3,11); 
plot(t, E_A, 'lineWidth', 2); 
axis tight;
title('Ea');

subplot(4,3,12); 
plot(t, GO, 'lineWidth', 2); 
axis tight;
title('GO');

%----------------------------------------------
% creates window to print, comment out when not needed

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%% this is to plot GO signal 03/15/02 %%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%figure(2);
%h1=axes; set(h1,'fontsize',24);
%hold on;
%plot(t, GO, 'lineWidth', 2);
%p=axis([0 0.5 0 20]); 
%title('GO SIGNAL');
%hold off;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%% this is for normal grasping plots 03/16/02 %%%%%%%%%%%%%
%%%%%%%%% ... and for no-coupling plots 03/17/02 %%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%figure(2);
%h1=axes; set(h1,'fontsize',24);
%hold on; 
%plot(t, der(t, P_T), 'lineWidth', 2); 
%set(h1, 'yTick', [0 30 60 90 120 150]);
%set(h1, 'yTickLabel', [0; 300; 600; 900; 1200; 1500]);
%set(h1, 'xTick', [0.1 0.3 0.5]);
%set(h1, 'xTickLabel', [100; 300; 500]);
%p=axis([0 0.5 0 150]); 
%hold off; 

%figure(3); 
%h1=axes; set(h1,'fontsize',24);
%hold on;
%plot(t, P_A+3.2, 'lineWidth', 2); % NOTE: THIS PLOT INCLUDES SHIFT 
%set(h1, 'yTick', [0 3 6 9]);
%set(h1, 'yTickLabel', [0; 30; 60; 90]);
%set(h1, 'xTick', [0.1 0.3 0.5]);
%set(h1, 'xTickLabel', [100;300;500]);
%p=axis([0 0.5 0 10.2]); 
%hold off;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%% this is for constant-GO grasping plots 03/16/02 %%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%figure(2);
%h1=axes; set(h1,'fontsize',24);
%hold on; 
%plot(t, der(t, P_T), 'lineWidth', 2); 
%set(h1, 'yTick', [0 100 200 300]);
%set(h1, 'yTickLabel', [0; 1000; 2000; 3000]);
%set(h1, 'xTick', [0.1 0.3 0.5]);
%set(h1, 'xTickLabel', [100; 300; 500]);
%p=axis([0 0.5 0 300]); 
%hold off; 

%figure(3); 
%h1=axes; set(h1,'fontsize',24);
%hold on;
%plot(t, pGrasp+3.2, 'lineWidth', 2); % NOTE: THIS PLOT INCLUDES SHIFT 
%set(h1, 'yTick', [0 2 4 6 8 10 12]);
%set(h1, 'yTickLabel', [0 20 40 60 80 100 120]);
%set(h1, 'xTick', [0.1 0.3 0.5]);
%set(h1, 'xTickLabel', [100;300;500]);
%p=axis([0 0.5 0 12]); 
%hold off;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%% this is for Saling's plots 03/17/02 %%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%figure(2);  
%h1=axes; set(h1,'fontsize',24);
%hold on;
%plot(t, pGrasp, '--', 'lineWidth', 2);
%set(h1, 'yTickLabel', [0;20;40;60;80;100;120]);
%set(h1, 'xTickLabel', [0;200;400;600]); 
%p=axis([0 0.6 0 12]); 
%title('LARGE OBJECT');
%
%figure(3);  
%h2=axes; set(h2,'fontsize',24);
%hold on;
%plot(t, vGrasp, '--', 'lineWidth', 2); 
%set(h2, 'yTickLabel', [-600;-400;-200;0;200;400;600]); 
%set(h2, 'xTickLabel', [0;200;400;600]); 
%p=axis([0 0.6 -60 60]); 
%title('LARGE OBJECT');
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%% this is for location perturbation plots (03/17/02 %%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%figure(2);
%h1=axes; set(h1,'fontsize',24);
%hold on;
%plot(t, der(t, P_T), 'lineWidth', 2); 
%set(h1, 'yTick', [30 60 90 120 150]);
%set(h1, 'yTickLabel', [300; 600; 900; 1200; 1500]);
%set(h1, 'xTick', [0 0.2 0.4 0.6]);
%set(h1, 'xTickLabel', [0; 200; 400; 600]);
%p=axis([0 0.6 0 150]); 
%title('TRANSPORT VELOCITY (CONTROL)');
%
%figure(3); 
%h2=axes; set(h2,'fontsize',24);
%hold on;
%plot(t, pGrasp+2.2, 'lineWidth', 2); % NOTE: THIS PLOT INCLUDES SHIFT 
%set(h2, 'yTick', [3 6 9]);
%set(h2, 'yTickLabel', [30; 60; 90]);
%set(h2, 'xTick', [0 0.2 0.4 0.6]);
%set(h2, 'xTickLabel', [0; 200; 400; 600]);
%p=axis([0 0.6 0 9]); 
%title('HAND APERTURE (CONTROL)');
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% to print internal vars in orientation perturb 03/17/02 %%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%figure;
%p=subplot(7,3,1);  
%plot(t, T_T, 'linewidth', 2); title('T_T'); grid on; 
%set(p, 'xTick', []);
%set(p, 'yTick', []);
%p=subplot(7,3,4);
%plot(t, D_T, 'linewidth', 2); title('D_T'); grid on; 
%set(p, 'xTick', []);
%set(p, 'yTick', []);
%p=subplot(7,3,7);
%plot(t, P_T, 'linewidth', 2); title('P_T'); grid on; 
%set(p, 'xTick', []);
%set(p, 'yTick', []);
%p=subplot(7,3,10);
%plot(t, V_T, 'linewidth', 2); title('V_T'); grid on; 
%set(p, 'xTick', []);
%set(p, 'yTick', []);
%p=subplot(7,3,13);
%plot(t, E_T, 'linewidth', 2); title('E_T'); grid on; 
%set(p, 'xTick', []);
%set(p, 'yTick', []);
%p=subplot(7,3,16);
%plot(t, C_TA, 'linewidth', 2); title('C_{TA}'); grid on; 
%set(p, 'xTick', []);
%set(p, 'yTick', []);
%p=subplot(7,3,19);
%plot(t, GO, 'lineWidth', 2); title('GO'); grid on;
%set(p, 'yTick', []);

%p=subplot(7,3,2);
%plot(t, T_A, 'linewidth', 2); title('T_A'); grid on; 
%set(p, 'xTick', []);
%set(p, 'yTick', []);
%p=subplot(7,3,5);
%plot(t, D_A, 'linewidth', 2); title('D_A'); grid on; 
%set(p, 'xTick', []);
%set(p, 'yTick', []);
%p=subplot(7,3,8);
%plot(t, P_A, 'linewidth', 2); title('P_A'); grid on; 
%set(p, 'xTick', []);
%set(p, 'yTick', []);
%p=subplot(7,3,11);
%plot(t, V_A, 'linewidth', 2); title('V_A'); grid on; 
%set(p, 'xTick', []);
%set(p, 'yTick', []);
%p=subplot(7,3,14);
%plot(t, E_A, 'linewidth', 2); title('E_A'); grid on; 
%set(p, 'xTick', []);
%set(p, 'yTick', []);
%p=subplot(7,3,17);
%plot(t, R1, 'linewidth', 2); title('R'); grid on;
%set(p, 'yTick', []);

%p=subplot(7,3,3);
%plot(t, T_O, 'linewidth', 2); title('T_O'); grid on; 
%set(p, 'xTick', []);
%set(p, 'yTick', []);
%p=subplot(7,3,6);
%plot(t, D_O, 'linewidth', 2); title('D_O'); grid on; 
%set(p, 'xTick', []);
%set(p, 'yTick', []);
%p=subplot(7,3,9);
%plot(t, P_O, 'linewidth', 2); title('P_O'); grid on; 
%set(p, 'xTick', []);
%set(p, 'yTick', []);
%p=subplot(7,3,12);
%plot(t, V_O, 'linewidth', 2); title('V_O'); grid on; 
%set(p, 'xTick', []);
%set(p, 'yTick', []);
%p=subplot(7,3,15);
%plot(t, E_O, 'linewidth', 2); title('E_O'); grid on; 
%set(p, 'xTick', []);
%set(p, 'yTick', []);
%p=subplot(7,3,18);
%plot(t, C_OA, 'linewidth', 2); title('C_{OA}'); grid on;
%set(p, 'yTick', []);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%% this is for size perturbation plots 03/17/02 %%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%figure(2);
%[ax, h1, h2] = plotyy(t, pGrasp + 5, t, vGrasp);
%set(ax(1), 'ylim', [0 14.5]);
%set(ax(2), 'ylim', [-80 80]);
%set(ax, 'xlim', [0 0.8]);
%set(ax, 'fontsize', 24);
%title('LARGE -> SMALL');
%set(h1, 'linewidth', 2); 
%set(h2, 'linewidth', 2);
%set(h2, 'linestyle', '--');
%legend(ax(2), 'GRIP VELOCITY', 3); legend(ax(1), 'GRIP APERTURE', 3); 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
