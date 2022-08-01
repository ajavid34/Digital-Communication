function [average_length_huffman] = average_length(chain , k)
%step1: make super-symbol with k-bit groups
res = mod(length(chain),k);
len = length(chain) - res;
normalize_chain = zeros(1, len);
for i = 1:(len)
   normalize_chain(1,i) = chain(1,i);
end
group_num = length(normalize_chain)/k;
group_chain = reshape(normalize_chain, [k group_num]);
%step2: assigning symbols to k-bit sequences
symbol_chain = zeros(1, group_num);
for i = 1:group_num
    separate_chain = group_chain(:,i);
        symbol = 0;
    for j = 1:k
        symbol = symbol + separate_chain(j) * 2^(j);
    end
    symbol_chain(1,i) = symbol;
end
%step3: calculating symbol occurance probability
symbols = unique(symbol_chain);
symbol_count = histc(symbol_chain, symbols); 
symbol_probability = zeros(1, length(symbols));
for i = 1 : length(symbols)
    symbol_probability(1,i) = symbol_count(1, i) /length(symbol_chain);
end
%step4: using huffmandict to find average length
[~,average_length_huffman] = huffmandict(symbols,symbol_probability) ;
end