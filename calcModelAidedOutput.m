function output = calcModelAidedOutput(table, coffeicient)
g = 9.80665;    % acceleration due to gravity (m/s^2)
rho = 1.2754;       % kg/m^2
G.b = 19.5; % wing span [m]
G.c_ = 1.30;    % MAC [m];  % MBR - used the "chord" value from the first table on page 3 of the PDF
I.m = 52.4;  % mass [kg] % MBR - changed this to I instead of l to group with other inertia variables
G.S = 21.84; % wing area [m^2]
cldAtune = 8.0;
cndAtune = 1.0;

c.Yb = -0.1986; %[rad^-1]
c.Yp = -0.0610; %[rad^-1]
c.Yr = 0.1074;  %[rad^-1]
c.YdR = 0.1646; %[rad^-1]

c.l0 = 1.080;  % spec sheet at report p.140 of KARI EAV 3
c.l0 = 0;  % spec sheet at report p.140 of KARI EAV 3

c.lb = -0.0547;
c.lp = -0.5533;
c.lr = 0.3491;
c.ldA = 0; % no data;
c.ldA = -0.134*(0.0033/0.107)*cldAtune;  % GUESS based on scaling from NAVION
c.ldR = 0.0033;

% Youn Guess
cldEtune = 0.6;
cldEtune = 0.9;

c.l0_a = 1.080 ;  % spec sheet at report p.140 of KARI EAV 3
c.l0_a = 1.080 - 0.3;  % spec sheet at report p.140 of KARI EAV 3 & tunned 
c.la =  5.817;  % spec sheet at report p.140 of KARI EAV 3
c.la =  6.217;  % spec sheet at report p.140 of KARI EAV 3
c.lq = 41.937*(5.817/3.309)*cldEtune; % GUESS based on Phastball UAV 
c.ldE = 1.787*(0.1646/0.045)*cldEtune; % GUESS based on Phastball UAV 

c.m0 = -0.0586; % MBR - found in "Pitching Moment Coefficients" Table
c.ma = -1.325;
c.mq = -19.221;
c.miH = -1.885;

c.n0 = 0; % no data;
c.nb = 0.0552;
c.np = -0.1725;
c.nr = -0.0626;
c.ndA = 0; % no data
c.ndA = -0.0035*(-0.0498/-0.072)*cndAtune;   % GUESS based on scaling from NAVION
c.ndR = -0.0498;

output.alpha_pred(1) = table.alpha_gt(1);
output.beta_pred(1) = table.beta_gt(1);

for k = 2: length(table.alpha_gt)
    V_k = table.V_air(k);
    q_k = 1/2*rho*V_k^2;
    K_k = (1/I.m)*q_k.*G.S;
    
    % alpha, beta prediction based on dynamic model 
    output.alpha_pred(k) = (-K_k*coffeicient(1) - table.IMU.AZ(k))/(K_k*coffeicient(2));
    output.beta_pred(k) = (1/c.Yb)*((I.m*table.IMU.AY(k))./(q_k.*G.S) - c.Yp * (G.b./(V_k.*2)).*table.IMU.P(k)- c.Yr * (G.b./(V_k.*2))*table.IMU.R(k) -  c.YdR*table.Rudder(k,:));
end
output.a_pred_reshaped = reshape(output.alpha_pred, [],1);
output.b_pred_reshaped = reshape(output.beta_pred, [],1);
output.a_gt_reshaped = reshape(table.alpha_gt, [],1);
output.b_gt_reshaped = reshape(table.beta_gt, [],1);

output.rmse_alpha = RMSE(output.a_pred_reshaped, output.a_gt_reshaped);
output.rmse_beta = RMSE(output.b_pred_reshaped, output.b_gt_reshaped);
end
