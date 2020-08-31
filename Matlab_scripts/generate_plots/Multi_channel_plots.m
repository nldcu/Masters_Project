% Channel One
%x = csvread('/Users/niall/Documents/Cypress_Code/Predictions/LSTM/Multipath/model_one_channel_one.csv',1,0);
%x = csvread('/Users/niall/Documents/Cypress_Code/Predictions/BLSTM/Multipath/model_one_channel_one.csv',1,0);
%x = csvread('/Users/niall/Documents/Cypress_Code/Predictions/RNN/Multipath/model_one_rnn_channel_one.csv',1,0);

% Channel One Normalised
%x = csvread('/Users/niall/Documents/Cypress_Code/Predictions/LSTM/Multipath/Channel_1_multipath_power_data_preds.csv',1,0);
%x = csvread('/Users/niall/Documents/Cypress_Code/Predictions/BLSTM/Multipath/model_one_channel_one_power.csv',1,0);
%x = csvread('/Users/niall/Documents/Cypress_Code/Predictions/RNN/Multipath/RNN_Channel_1_multipath_power_data_preds.csv',1,0);

% Channel Two 
%x = csvread('/Users/niall/Documents/Cypress_Code/Predictions/LSTM/Multipath/model_one_channel_two.csv',1,0);
%x = csvread('/Users/niall/Documents/Cypress_Code/Predictions/BLSTM/Multipath/model_one_channel_two.csv',1,0);
%x = csvread('/Users/niall/Documents/Cypress_Code/Predictions/RNN/Multipath/model_one_rnn_channel_two.csv',1,0);

% Channel Two Normalised
%x = csvread('/Users/niall/Documents/Cypress_Code/Predictions/LSTM/Multipath/Channel_2_multipath_power_data_preds.csv',1,0);
%x = csvread('/Users/niall/Documents/Cypress_Code/Predictions/BLSTM/Multipath/model_one_channel_two_power.csv',1,0);
%x = csvread('/Users/niall/Documents/Cypress_Code/Predictions/RNN/Multipath/RNN_Channel_2_multipath_power_data_preds.csv',1,0);

% Channel Three
%x = csvread('/Users/niall/Documents/Cypress_Code/Predictions/LSTM/Multipath/model_one_channel_three.csv',1,0);
%x = csvread('/Users/niall/Documents/Cypress_Code/Predictions/BLSTM/Multipath/model_one_channel_three.csv',1,0);
%x = csvread('/Users/niall/Documents/Cypress_Code/Predictions/RNN/Multipath/model_one_rnn_channel_three.csv',1,0);

% Channel Three Normalised
%x = csvread('/Users/niall/Documents/Cypress_Code/Predictions/LSTM/Multipath/Channel_3_multipath_power_data_preds.csv',1,0);
%x = csvread('/Users/niall/Documents/Cypress_Code/Predictions/BLSTM/Multipath/model_one_channel_three_power.csv',1,0);
x = csvread('/Users/niall/Documents/Cypress_Code/Predictions/RNN/Multipath/RNN_Channel_3_multipath_power_data_preds.csv',1,0);

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
   
figure(1)
loglog(1-total_false_alarm(1,:), (total_false_alarm(2,:)))
hold on
grid on
xlabel('False Alarm')
ylabel('Missed Detection')