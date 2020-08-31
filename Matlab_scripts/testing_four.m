
%close all
clear all

%% Read in data

% y_preds_two_layer
%x = csvread('/Users/niall/Documents/Cypress_Code/Predictions/Flip_bits/y_preds_two_layer.csv',1,0);

% model_lstm_stack
%x = csvread('/Users/niall/Documents/Cypress_Code/Predictions/Flip_bits/model_lstm_stack.csv',1,0);

%model_lstm_max
%x = csvread('/Users/niall/Documents/Cypress_Code/Predictions/Flip_bits/model_lstm_max.csv',1,0);

%pred_avg
x = csvread('/Users/niall/Documents/Cypress_Code/Predictions/Flip_bits/pred_avg.csv',1,0);


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

% figure("Name", ['Error Probability ',num2str(errorProbs),'%'])
% plot(threshold, total_false_alarm,'linewidth',2)
% grid on
% hold on
% xlabel('Threshold')
% ylabel('Probability of Detection')
% title(['Error Probability ',num2str(errorProbs),'%'])
   
figure(2)
loglog(1-total_false_alarm(1,:), (total_false_alarm(2,:)))
hold on
grid on
xlabel('False Alarm')
ylabel('Missed Detection')
