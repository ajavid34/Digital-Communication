function [symbols] = modulate(bits)
symbols = zeros(1,length(bits));
for i = 1 : length(bits)   
    if (bits(i)<0.1) && (bits(i)>=0)
        symbols(i) = 3;
    end
    if (bits(i)>=0.1) && (bits(i)<0.5)
        symbols(i) = 1;
    end
    if (bits(i)>=0.5) && (bits(i)<0.9)
        symbols(i) = -1;
    end
    if (bits(i) >= 0.9) && (bits(i) < 1)
        symbols(i) = -3;
    end
end
end