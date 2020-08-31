function y = flip_bits(x,e)
%Process an input vector x through a m sequences with error probability e.
y = x; %copy the input vector
errors = rand(1,length(x))<e; %Bernoulli trials with probability e
y(errors) = 1 - y(errors); %flip the bits