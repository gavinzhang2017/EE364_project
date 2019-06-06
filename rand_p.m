%%% output a random number from 1 to n,
%%% according to the discrete probability distribution given in p
function out = rand_p(p)

n = length(p);
cdf = cumsum(p);
I = zeros(n,2);
I(1,:) = [0, cdf(1)];

for i = 2 : n
    I(i,:) = [cdf(i-1) cdf(i)];
end

rand_u = rand;
for i = 1 : n
    if I(i,1) <= rand_u & rand_u <= I(i,2)
        out = i;
    end
end

end

    
