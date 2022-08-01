function[Gk] = entropy(transition_states,k)
size = length(transition_states);
%step 1 : find P 
ts_tp = transpose(transition_states);
% P = (phi)^T *P --> ((phi)^T - I) P = 0 --> Ax = 0    
A = ts_tp - eye(size);
% add sigma(pi)= 1
ts = [A ; ones(1 , size)];
U = [zeros(size, 1) ;ones(1,1)] ;
%solve Ax = 0
P = linsolve(ts , U);
% step 2 : find Hs1
Hs = 0;
for i = 1:size 
    Hs = Hs - P(i)* log2(P(i));
end
% step 2 : find Hs2s1
Hs2s1 = 0;
for i = 1:size 
    Hx = 0;
    for j = 1:size
        Hx = Hx - transition_states(i,j)*log2(transition_states(i,j));
    end
    Hs2s1 = Hs2s1 + P(i,1) * Hx;
end
% step 3 : calculating Gk
Gk = (Hs + k*Hs2s1) / k;
end