function [error] = error_detect(N, M, detected_symbols, modulated_symbols)
error = zeros(1,N);
for i = 1:N
    for j =1:M
        if detected_symbols(i,j) ~= modulated_symbols(j)
            error(i)=error(i)+1;
        end
    end
end

end
