function table = parseCSV(filename, seq_len,y_type)

T = readtable(filename);
if seq_len == 2
    T(1, :) = []; % Erase padded parts
else
    T([1:seq_len-1], :) = []; % Erase padded parts
end
table.IMU.P = T.("IMU_P");
table.IMU.Q = T.("IMU_Q");
table.IMU.R = T.("IMU_R");

table.IMU.AX  = T.("IMU_AX");
table.IMU.AY  = T.("IMU_AY");
table.IMU.AZ  = T.("IMU_AZ");

table.V_air = T.("V_air");
if y_type == "alpha"
    table.a_gt = T.("alpha");
    table.a_pred = T.("alpha_pred");
elseif y_type == "beta"
    table.b_gt = T.("beta");
    table.b_pred = T.("beta_pred");
end

table.Elevator = T.("Elevator");
table.Aileron = T.("Aileron");
table.Rudder = T.("Rudder");

end
