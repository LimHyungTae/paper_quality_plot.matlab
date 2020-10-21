%% CDF
clc
close all;
clear all;

%% Color parameter
num_objects = 5; 
linecolors = linspecer(num_objects, 'qualitative');
LineColors = flipud(linecolors);

%% Load output file
i_t = ["elements", "all"];
m_t = ["RNN", "GRU", "LSTM"];
format_name = "materials/output_csvs/a%db%d_%s_%s_EAV2_%d_output.csv";
format_name2 = "materials/0425_seqv2/a%d_%s_%s_EAV2_%d_output.csv";

a_error_m = []; a_error_Re = []; a_error_Ra = []; a_error_Le = []; a_error_La = [];
b_error_m = []; b_error_Re = []; b_error_Ra = []; b_error_Le = []; b_error_La = [];

data_names = [1,3,6];
disp("Loading data...");
for data_name = data_names
    % Load RNN - Elements
    a_seq = 12;
    alpha_csvname = sprintf(format_name2, a_seq, m_t(1), i_t(1), data_name);
    RNN_e.alpha = parseCSV(alpha_csvname, a_seq, "alpha");
    
    a_seq_tmp = 7; % just for loading file
    b_seq = 32;
    beta_csvname = sprintf(format_name, a_seq_tmp, b_seq, m_t(1), i_t(1), data_name);
    RNN_e.beta = parseCSV(beta_csvname, b_seq, "beta");
        
    % Load RNN - All
    alpha_csvname = sprintf(format_name2, a_seq, m_t(1), i_t(2), data_name);
    RNN_a.alpha = parseCSV(alpha_csvname, a_seq, "alpha");
    
    a_seq_tmp = 7; % just for loading file
    beta_csvname = sprintf(format_name, a_seq_tmp, b_seq, m_t(1), i_t(2), data_name);
    RNN_a.beta = parseCSV(beta_csvname, b_seq, "beta");
    
    % Load LSTM - Elements
    a_seq = 12;
    
    alpha_csvname = sprintf(format_name2, a_seq, m_t(3), i_t(1), data_name);
    LSTM_e.alpha = parseCSV(alpha_csvname, a_seq, "alpha");
    
    a_seq_tmp = 12; % just for loading file
    b_seq = 64;
    beta_csvname = sprintf(format_name, a_seq_tmp, b_seq, m_t(3), i_t(1), data_name);
    LSTM_e.beta = parseCSV(beta_csvname, b_seq, "beta");
    
    % Load LSTM - All
    a_seq = 12;
    alpha_csvname = sprintf(format_name2, a_seq, m_t(3), i_t(2),data_name);
    LSTM_a.alpha = parseCSV(alpha_csvname, a_seq, "alpha");
    
    format_name3 = "materials/output_csvs/b%d_%s_%s_EAV2_%d_output.csv";
    b_seq = 36;
    beta_csvname = sprintf(format_name3, b_seq, m_t(3), i_t(2), data_name);
    LSTM_a.beta = parseCSV(beta_csvname, b_seq, "beta");


    %% For getting result for model aided
    % Set C.L
    C.L = [0.53, 2.85];

    % Load target csv
    format_name4 = sprintf("materials/output_csvs/EAV2_%d.csv", data_name);
    csv = parseRawCSV(format_name4);

    Model = calcModelAidedOutput(csv, C.L);
    %% Calculate Absolute Errors
    % Alpha error
    error_m = abs(Model.a_gt_reshaped - Model.a_pred_reshaped);
    error_Re = abs(RNN_e.alpha.a_gt - RNN_e.alpha.a_pred);
    error_Ra = abs(RNN_a.alpha.a_gt - RNN_a.alpha.a_pred);

    error_Le = abs(LSTM_e.alpha.a_gt - LSTM_e.alpha.a_pred);
    error_La = abs(LSTM_a.alpha.a_gt - LSTM_a.alpha.a_pred);
    a_error_m = [a_error_m; error_m];
    a_error_Re = [a_error_Re; error_Re]; a_error_Ra = [a_error_Ra; error_Ra];
    a_error_Le = [a_error_Le; error_Le]; a_error_La = [a_error_La; error_La];
    
    % Beta error
    diff_seq = 26; % b_seq - a_seq + 1
    error_m = abs(Model.b_gt_reshaped - Model.b_pred_reshaped);
    error_Re = abs(RNN_e.beta.b_gt(diff_seq:end) - RNN_e.beta.b_pred(diff_seq:end));
    error_Ra = abs(RNN_a.beta.b_gt(diff_seq:end) - RNN_a.beta.b_pred(diff_seq:end));

    diff_seq2 = 53; % b_seq - a_seq + 1
    error_Le = abs(LSTM_e.beta.b_gt(diff_seq2:end) - LSTM_e.beta.b_pred(diff_seq2:end));
    error_La = abs(LSTM_a.beta.b_gt - LSTM_a.beta.b_pred);
    
    b_error_m = [b_error_m; error_m];
    b_error_Re = [b_error_Re; error_Re]; b_error_Ra = [b_error_Ra; error_Ra];
    b_error_Le = [b_error_Le; error_Le]; b_error_La = [b_error_La; error_La];
    
end

disp("Loading data complete");


%% Plot parameters;
MAX_RANGE = 0.012; % --------------- TO BE SET ---------------
INTERVAL = 1000;   % --------------- TO BE SET ---------------
lindwidth = 1.5;
LegendFontSize = 13;
XLabelFontSize = 12;  YLabelFontSize = 12;

%% Draw cdf of alpha: 
figure("name", "alpha");
set(gca,'LooseInset', max(get(gca,'TightInset'), 0.02))
disp("Drawing cdf of alpha...");
 
gap = MAX_RANGE / 1000;
x_linspace = 0:gap:MAX_RANGE;
x_linspace = x_linspace * 180.0 / pi; % rad to angle
a_m_cum = calcCDF(a_error_m, MAX_RANGE, INTERVAL) * 100;
a_re_cum = calcCDF(a_error_Re, MAX_RANGE, INTERVAL) * 100;
a_ra_cum = calcCDF(a_error_Ra, MAX_RANGE, INTERVAL) * 100;
a_le_cum = calcCDF(a_error_Le, MAX_RANGE, INTERVAL) * 100;
a_la_cum = calcCDF(a_error_La, MAX_RANGE, INTERVAL) * 100;

plot(x_linspace, a_re_cum, '--o', 'Color', LineColors(1, :), 'LineWidth', lindwidth, 'MarkerIndices',1:50:length(x_linspace));
hold on;
% plot(x_linspace, e_ge_cum,'--+','MarkerIndices',1:50:length(x_linspace));
plot(x_linspace, a_le_cum,'--s', 'Color', LineColors(2, :),  'LineWidth', lindwidth, 'MarkerIndices',1:50:length(x_linspace));

plot(x_linspace, a_m_cum, '-^', 'Color', LineColors(3, :),  'LineWidth', lindwidth, 'MarkerIndices',1:50:length(x_linspace));

plot(x_linspace, a_ra_cum, '-o', 'Color', LineColors(4, :),  'LineWidth', lindwidth, 'MarkerIndices',1:50:length(x_linspace));
% plot(x_linspace, e_ga_cum, '-+','MarkerIndices',1:50:length(x_linspace));
plot(x_linspace, a_la_cum, '-s', 'Color', LineColors(5, :),  'LineWidth', lindwidth, 'MarkerIndices',1:50:length(x_linspace));
lgd = legend({'RNN-\texttt{Minimal}','LSTM-\texttt{Minimal}', 'Model-aided', 'RNN-\texttt{All}','LSTM-\texttt{All}'},'Location','southeast','NumColumns',2, 'fontsize', LegendFontSize);
lgd.Interpreter = 'latex';
grid on;

xlabel('Absolute Error (deg)', "FontSize", XLabelFontSize, "Interpreter", 'latex')
ylabel('Percentage (\%)', "FontSize", YLabelFontSize, "Interpreter", 'latex')

saveas(gcf,"imgs/total_cdf_alpha.png");
% print -depsc 'imgs/total_cdf_alpha.eps'

disp("Drawing cdf of alpha complete");


%% Draw cdf of beta: 
figure("name", "beta");
set(gca,'LooseInset', max(get(gca,'TightInset'), 0.02))
MAX_RANGE = 0.05; % --------------- TO BE SET ---------------

disp("Drawing cdf of beta...");

gap = MAX_RANGE / 1000;
x_linspace = 0:gap:MAX_RANGE;
x_linspace = x_linspace * 180.0 / pi; % rad to angle
b_m_cum = calcCDF(b_error_m, MAX_RANGE, INTERVAL) * 100;
b_re_cum = calcCDF(b_error_Re, MAX_RANGE, INTERVAL) * 100;
b_ra_cum = calcCDF(b_error_Ra, MAX_RANGE, INTERVAL) * 100;
b_le_cum = calcCDF(b_error_Le, MAX_RANGE, INTERVAL) * 100;
b_la_cum = calcCDF(b_error_La, MAX_RANGE, INTERVAL) * 100;

plot(x_linspace, b_re_cum, '--o', 'Color', LineColors(1, :), 'LineWidth', lindwidth, 'MarkerIndices',1:50:length(x_linspace));
hold on;
plot(x_linspace, b_le_cum,'--s', 'Color', LineColors(2, :), 'LineWidth', lindwidth,'MarkerIndices',1:50:length(x_linspace));
plot(x_linspace, b_m_cum, '-^', 'Color', LineColors(3, :), 'LineWidth', lindwidth,'MarkerIndices',1:50:length(x_linspace));
plot(x_linspace, b_ra_cum, '-o', 'Color', LineColors(4, :), 'LineWidth', lindwidth,'MarkerIndices',1:50:length(x_linspace));
plot(x_linspace, b_la_cum, '-s', 'Color', LineColors(5, :), 'LineWidth', lindwidth,'MarkerIndices',1:50:length(x_linspace));
lgd = legend({'RNN-\texttt{Minimal}', 'LSTM-\texttt{Minimal}', 'Model-aided\texttt{}', 'RNN-\texttt{All}','LSTM-\texttt{All}'},'Location','southeast','NumColumns',2, 'fontsize', LegendFontSize);
lgd.Interpreter = 'latex';
grid on;

xlabel('Absolute Error (deg)', "FontSize", XLabelFontSize, "Interpreter", 'latex')
ylabel('Percentage (\%)', "FontSize", YLabelFontSize, "Interpreter", 'latex')

saveas(gcf,"imgs/total_cdf_beta.png");
% print -depsc 'imgs/total_cdf_beta.eps'

disp("Drawing cdf of beta complete");



