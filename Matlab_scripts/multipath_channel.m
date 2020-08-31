clc
%close all
clear all
N=31; %Period of the sequence N=2ˆL-1
snr_dB = 0; % SNR in decibels -15 -10 -5 0 5 
threshold = 0.001:0.001:1.1; % Pf = Probability of False Alarm
ref_poly = [1 0 1 0 0 1]; %X^5 + x^3 + 1 will be coded as 1 0 1 0 0 1
ref_init = [0 0 0 0 1];
ref_lfsr = lfsr(ref_poly,ref_init);
n_packets = 100000;
total_false_alarm = zeros(size(threshold));

test_case = {'ref,ref','diff,diff'};
%test_case = {'ref,ref', 'ref,diff','diff,diff'};

%% Simulation to plot Probability of Detection (Pd) vs. Probability of False Alarm (Pf)
total_false_alarm = NaN(length(test_case),length(threshold));
for current_case=1:length(test_case)
    total_false_alarm(current_case,:) = 0;
    t_case = test_case{current_case};
    for kk=1:n_packets
  
            current_poly = double(rand(size(ref_poly)) > 0.5);
            current_poly(end) = 1;
            while isequal(current_poly, ref_poly)
                current_poly = double(rand(size(ref_poly)) > 0.5);
                current_poly(end) = 1;
            end
            
            current_init = double(rand(size(ref_init)) > 0.5);
            while isequal(current_init, ref_init)
                current_init = double(rand(size(ref_init)) > 0.5);
            end 
       
            s = getCase(t_case, current_init, current_poly,ref_poly, ref_init);
            
            channel_in = 2*s-1;
            if (dff/diff)  (no need with "updated" method)
            
                loop over many mnay ch real
            
            channel_1 = [0 1 0 0 (rand-1/2) 0 0 (rand-1/2)];  % main tap==1 : real sys never works this way as there is agc (constant "power"
            %channel_1 = [0 1 0 0 0 0 0 0];  % main tap==1 : real sys never works this way as there is agc (constant "power"

            %channel_2 = [0 1 0 0 (rand-1/2)*2 0 0 (rand-1/2)*2];  % main tap==1 : real sys never works this way as there is agc (constant "power"
            %channel_3 = [0 1 (rand(1,6)-1/2)/6]; % 6 random taps with "energy" total close to main tap
            
            %channel_energy = channel_3/sqrt(sum(abs(channel_3).^2)); %normlize wuth "sqrt energy" of channel
            channel_out = conv(channel_1, channel_in);
            
            x = awgn(channel_out,snr_dB,'measured');

                store d/d(0)  xxx(real of d/d) x from ch_0
                store d/d(0)  xxx(real of d/d) x from ch_1
                store d/d(0)  xxx(real of d/d) x from ch_2...
                store d/d(0)  xxx(real of d/d) x from ch_1000
            
            
            training : same as before : only takes in r/r/, d/d {0/1}  and awgn_ch_out x  (ignore fact that there may be many ch real for same d/d)
            test/inf : put all r/r together (all will have 1 ch per real). for d/d pick "2 cases: avg, largest" Rxy among the 1000chs it varied over
            
            N packets., M channels/pkt, r/r d/d
            traiing : N of (1) and N*M (0) with no qualification on details about M
            inrefence : N1 or (1)  and N1 which is avg/worst of M possibilities with each d/d
            
            N packets., M channels/pkt, r/r d/d
            traiing : N*M of (1) and N*M (0) with no qualification on details about M
            inrefence : pick "avg, worst" of M poss in each of N1 (1)  and N1 which is avg/worst of M possibilities with each d/d
            in ML/python : training will get 2 * N * M possibilites, inf will take in 2*N1*M poss anf give out 2*N*M outputs .... take in maltab, "group" the M realizations correctly and  pick avg/worst as metric for that rr or dd. go histogram...
                     (creful not to shuffle the inf patterns... OK to shuffle the training patterns)
            
            Rxy = max(abs(xcorr(x, 2*ref_lfsr-1)))/31; 
            if (current_case>1)
            if (Rxy > 0.7)
                %keyboard;
            end
            end
            %temp(current_case,kk) = Rxy; 
            
            total_false_alarm(current_case,:) = total_false_alarm(current_case,:) + (Rxy >= threshold); %threshold based on where you want to be on NP curve
    
    end
    
end

total_false_alarm = total_false_alarm/n_packets;

%% Develop Plots
% figure("Name", ['SNR ',num2str(snr_dB)])
% plot(threshold, total_false_alarm,'linewidth',2)
% grid on
% hold on
% xlabel('Threshold')
% ylabel('Probability of Detection')
% title(['SNR ',num2str(snr_dB)])

figure(2)
%loglog(1-total_false_alarm(1,:), max(total_false_alarm(2:3,:),[],1))
loglog(1-total_false_alarm(1,:), total_false_alarm(2:2,:))
hold on
grid on
xlabel('False Alarm')
ylabel('Missed Detection')