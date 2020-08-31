
%close all
clear all

%% Read in data

% LSTM y_preds_two_layer
%x = csvread('/Users/niall/Documents/Cypress_Code/Predictions/LSTM/Flip_bits/y_preds_two_layer.csv',1,0);

% LSTM model_lstm_stack
%x = csvread('/Users/niall/Documents/Cypress_Code/Predictions/LSTM/Flip_bits/model_lstm_stack.csv',1,0);

% LSTM model_lstm_max
%x = csvread('/Users/niall/Documents/Cypress_Code/Predictions/LSTM/Flip_bits/model_lstm_max.csv',1,0);

% LSTM pred_avg
%x = csvread('/Users/niall/Documents/Cypress_Code/Predictions/LSTM/Flip_bits/pred_avg.csv',1,0);

% LSTM low_complexity_lstm
%x = csvread('/Users/niall/Documents/Cypress_Code/Predictions/LSTM/Flip_bits/model_lstm_low_comp.csv',1,0);

% BLSTM Model
%x = csvread('/Users/niall/Documents/Cypress_Code/Predictions/BLSTM/Flip_bits/model_one_blstm_flip_bits.csv',1,0);

%% Plot Trad Vs RNN Vs LSTM Vs BLSTM

% RNN
% x = csvread('/Users/niall/Documents/Cypress_Code/Predictions/RNN/Flip_bits/model_one_rnn_flip_bits.csv',1,0);

% LSTM pred_avg
% x = csvread('/Users/niall/Documents/Cypress_Code/Predictions/LSTM/Flip_bits/pred_avg.csv',1,0);

% BLSTM Model
% x = csvread('/Users/niall/Documents/Cypress_Code/Predictions/BLSTM/Flip_bits/model_one_blstm.csv',1,0);

%%
% RNN
% x = csvread('/Users/niall/Documents/Cypress_Code/Predictions/RNN/AWGN/model_one_rnn_awgn_minus5.csv',1,0);

% LSTM pred_avg
% x = csvread('/Users/niall/Documents/Cypress_Code/Predictions/LSTM/AWGN/model_one_snr_minus5.csv',1,0);

% BLSTM Model
x = csvread('/Users/niall/Documents/Cypress_Code/Predictions/BLSTM/AWGN/model_one_blstm_snr_minus5.csv',1,0);
%% Plot Data
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
