clc
clear all

%% initial
transition_states = [0.5 0.5;0.8 0.2];
N = 10000000;
%% calculate Hx
size = length(transition_states);
ts_tp = transpose(transition_states);  
A = ts_tp - eye(size);
ts = [A ; ones(1 , size)];
U = [zeros(size, 1) ;ones(1,1)] ;
P = linsolve(ts , U);
Hxx = zeros(1,size);
for i=1:size
    for j=1:size
        Hxx(1,i)=Hxx(1,i) - transition_states(i,j)*log2(transition_states(i,j));
    end
end
Hx = 0;
for i=1:size
    Hx = Hx + P(i)*Hxx(1,i);
end
%% state entropy
K = 1:10;
G = zeros(1,length(K));
for k = 1 : length(K)
    G_k = entropy(transition_states,k);
    G(1,k)=G_k;
end
%% symbol generation
chain = zeros(1,N);
x = rand;
if x < P(1,1) % setting the source current state with state ptrobabilities
    chain(1,1) = 1;
else
    chain(1,1) = 2 ;
end
for i = 1 : N
    temp  = rand;
    switch chain(1,i)
        case 1
            if temp < transition_states(1,1)
                chain(1,i+1) = 1 ;
            else
                chain(1,i+1) = 2 ;
            end
        case 2
            if temp < transition_states(2,2) 
                chain(1,i+1) = 2 ;
            else
                chain(1,i+1) = 1 ;
            end 
    end
end
%% average code length and code efficiency
average_length_huffman = zeros(1,length(K));
HN = zeros(1, length(K));
for i = 1:length(K)
    average_length_huffman(1,i) = average_length(chain, i);
    HN(1,i) = average_length_huffman(1,i)/i;
end

H = zeros(1,length(K)); 
for i = 1:length(H)
    H(1,i) = Hx;
end
code_efficiency = zeros(1,length(K));
for i = 1:length(code_efficiency)
    code_efficiency(i) = H(1,i) / HN(1,i);
end
Hx
figure
plot(K,G,'r');
hold on ;
plot(K,average_length_huffman,'black');
hold on 
plot(K,H,'b');
title('Average Code Length and G_k ');
legend({'$G_k$','Average Length','Entropy'},'Interpreter','latex')
grid on;
hold off
figure
plot(K,code_efficiency,'black');
hold on ;
plot(K,H,'b');
hold on ;
plot(K, HN,'r');
title('Code Efficiency and Entropy ');
legend({'Coding Efficiency','Entropy','$\hat{H}_k$'},'Interpreter','latex')
grid on;