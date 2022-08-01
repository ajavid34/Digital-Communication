function [symbols] = detect(samples,N,delata)
symbols = zeros(1,length(samples));
for i = 1 : N
    for j = 1 : length(samples)
        if (samples(i,j) <= delata(1,i))
            symbols(i,j) = -3;
        end
        if (samples(i,j) > delata(1,i)) && (samples(i,j) <= delata(2,i))
            symbols(i,j) = -1;
        end
        if (samples(i,j) > delata(2,i)) && (samples(i,j) <= delata(3,i))
            symbols(i,j) = 1;
        end
        if (samples(i,j) > delata(3,i))
            symbols(i,j) = 3;
        end
    end
end
end