function[Gk] = entropy_memless(prob_symbol,k)
Hx = 0;
for i =1:length(prob_symbol)
    Hx = Hx - prob_symbol(i) *log2(prob_symbol(i));
end
Gk = (k+1)/k * Hx;
end