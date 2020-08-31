channel = [0 1 0 0 -.5 0 0 +0.3];

for i=1:10000
channel = [0 1 0 0 (rand-1/2) 0 0 (rand-1/2)];  % main tap==1 : real sys never works this way as there is agc (constant "power"
channel = [0 1 0 0 (rand-1/2)*2 0 0 (rand-1/2)*2];  % main tap==1 : real sys never works this way as there is agc (constant "power"
%channel = [0 1 (rand(1,6)-1/2)/6]; % 6 random taps with "energy" yotal close to main tap
channel = channel/sqrt(sum(abs(channel).^2)); %normlize wuth "sqrt energy" of channel
  
t_case = 'ref,ref';
s = getCase(t_case, current_init, current_poly,ref_poly, ref_init);
xref=2*s-1;
x1 = conv(channel, 2*s-1);
% add noise
t_case='diff,diff';
s = getCase(t_case, current_init, current_poly,ref_poly, ref_init);
x2 = conv(channel, 2*s-1);
% add noise

[xc, l]=xcorr(xref, xref);xc=xc/31;
[xc1, l1]=xcorr(x1, xref);xc1=xc1/31;
[xc2, l2]=xcorr(x2, xref); xc2=xc2/31;

rxy(i,1) = max(abs(xcorr(xref, xref)))/31;
rxy(i,2) = max(abs(xcorr(x1, xref)))/31;
rxy(i,3) = max(abs(xcorr(x2, xref)))/31;



%plot(l,xc,l1,xc1, l2,xc2, 'g')
%hold on
end