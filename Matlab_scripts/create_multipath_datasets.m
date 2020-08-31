clc
%close all
clear all
N=31; %Period of the sequence N=2ˆL-1
snr_dB = 0; % SNR in decibels -15 -10 -5 0 5 
threshold = 0.001:0.001:1.1; % Pf = Probability of False Alarm
ref_poly = [1 0 1 0 0 1]; %X^5 + x^3 + 1 will be coded as 1 0 1 0 0 1
ref_init = [0 0 0 0 1];
ref_lfsr = lfsr(ref_poly,ref_init);
n_packets = 250000;
%n_packets = 135000;
total_false_alarm = zeros(size(threshold));

test_case = {'ref,ref'};
%test_case = {'ref,diff','diff,diff'};

multipath_data = [];

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
            %channel_1 = [0 1 0 0 (rand-1/2) 0 0 (rand-1/2)];  % main tap==1 : real sys never works this way as there is agc (constant "power"
            %channel_2 = [0 1 0 0 (rand-1/2)*2 0 0 (rand-1/2)*2];  % main tap==1 : real sys never works this way as there is agc (constant "power"
            channel_3 = [0 1 (rand(1,6)-1/2)/6]; % 6 random taps with "energy" yotal close to main tap
            
            channel_energy = channel_3/sqrt(sum(abs(channel_3).^2)); %normlize wuth "sqrt energy" of channel
            channel_out = conv(channel_energy, channel_in);
            
            x = awgn(channel_out,snr_dB,'measured');
            multipath_data = [multipath_data ; x];
            disp(kk) 
                
    end
    
end