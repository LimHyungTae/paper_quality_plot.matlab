function table = parseRawCSV(filename)

T = readtable(filename);
table.IMU.P = T.("IMU_P");
table.IMU.Q = T.("IMU_Q");
table.IMU.R = T.("IMU_R");

table.IMU.AX  = T.("IMU_AX");
table.IMU.AY  = T.("IMU_AY");
table.IMU.AZ  = T.("IMU_AZ");

table.V_air = T.("V_air");
table.alpha_gt = T.("alpha");
table.beta_gt = T.("beta");

table.Elevator = T.("Elevator");
table.Aileron = T.("Aileron");
table.Rudder = T.("Rudder");

end
