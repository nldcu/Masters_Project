function [y,states] = lfsr(G,X)
%Galois LFSR for m-sequence generation
% G - polynomial (primitive for m-sequence) arranged as vector
% X - initial state of the delay elements arranged as vector
% y - output of LFSR
% states - gives the states through which the LFSR has sequenced.
%The function outputs the m-sequence for a single period
%Sample call:
%3rd order LFSR polynomial:xˆ5+xˆ2+1=>g5=1,g4=0,g3=0,g2=1,g1=0,g0=1
%with intial states [0 0 0 0 1]: lfsr([1 0 0 1 0 1],[0 0 0 0 1])

g=G(:); x=X(:); %serialize G and X as column vectors
g = flipud(g);

if length(g)-length(x)~=1
error('Length of initial seed X0 should be equal to the number of delay elements (length(g)-1)');
end

%LFSR state-transistion matrix construction
L = length(g)-1; %order of polynomial

N = 2^L-1; %period of maximal length sequence
y = zeros(1,N);%array to store output

for i=1:N %repeate for each clock period
    y(i) = x(end); %output the last bit
    x = [mod(sum(x .* g(2:end)),2); x(1:end-1)];
end