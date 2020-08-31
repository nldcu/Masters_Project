
%close all
clear all

%% Read in data

% 0 SNR (dB)
%x = csvread('/Users/niall/Documents/Cypress_Code/Predictions/LSTM/AWGN/model_one_snrzero.csv',1,0);

% -10 SNR (dB)
%x = csvread('/Users/niall/Documents/Cypress_Code/Predictions/LSTM/AWGN/model_one_snrminusten.csv',1,0);

% MSE LSTM
%x = csvread('/Users/niall/Documents/Cypress_Code/Predictions/LSTM/AWGN/model_one_mse_snrzero.csv', 1,0);

% -5 SNR(dB) LSTM 
%x = csvread('/Users/niall/Documents/Cypress_Code/Predictions/LSTM/AWGN/model_one_snr_minus5.csv',1,0);

% -5 SNR (dB) BLSTM
%x = csvread('/Users/niall/Documents/Cypress_Code/Predictions/BLSTM/AWGN/model_one_blstm_snr_minus5.csv',1,0);

% 0 SNR (dB) BLSTM
%x = csvread('/Users/niall/Documents/Cypress_Code/Predictions/BLSTM/AWGN/model_one_blstm_snr_zero.csv',1,0);

% 0 SNR (dB) LSTM
x = csvread('/Users/niall/Documents/Cypress_Code/Predictions/LSTM/AWGN/model_one_snrzero.csv',1,0);
%% Plot Data;
threshold = 0.001:0.001:1.1;

idx1 = find(x(:,2) == 1);
idx0 = find(x(:,2) == 0);


for i = 1:length(threshold)
    total_false_alarm(1,i) = sum(x(idx1,1) > threshold(i));
    total_false_alarm(2,i) = sum(x(idx0,1) > threshold(i));
    
end
 
total_false_alarm(1,:) = total_false_alarm(1,:)/size(idx1,1);
total_false_alarm(2,:) = total_false_alarm(2,:)/size(idx0,1);
   
figure(2)
loglog(1-total_false_alarm(1,:), (total_false_alarm(2,:)))
hold on
grid on
xlabel('False Alarm')
ylabel('Missed Detection')
