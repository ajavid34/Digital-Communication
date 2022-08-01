clc
clear all
N = 10000000;
prob1 = [0.7, 0.29, 0.01];
alphabet1 = 1 : 3;
chain1 = randsrc(1,N, [alphabet1; prob1]);

alphabet2 = 1 : 9;
prob2 = kron(prob1,prob1);
chain2 = randsrc(1,N, [alphabet2; prob2]);

alphabet3 = 1 : 27;
prob3 = kron(prob1,prob2);
chain3 = randsrc(1,N, [alphabet3; prob3]);

K = 1:10;
G1 = zeros(1,length(K));
G2 = zeros(1,length(K));
G3 = zeros(1,length(K));
average_length1 = zeros(1,length(K));
average_length2 = zeros(1,length(K));
average_length3 = zeros(1,length(K));
HN1 = zeros(1, length(K));
HN2 = zeros(1, length(K));
HN3 = zeros(1, length(K));

for i=1:length(K)
    G1(i) = entropy_memless(prob1,i);
    G2(i) = entropy_memless(prob2,i);
    G3(i) = entropy_memless(prob3,i);
    average_length1(1,i) = average_length(chain1, i);
    average_length2(1,i) = average_length(chain2, i);
    average_length3(1,i) = average_length(chain3, i);
    HN1(1,i) = average_length1(1,i)/i;
    HN2(1,i) = average_length2(1,i)/i;
    HN3(1,i) = average_length3(1,i)/i;
end
HX1 = G1(1)/2; 
HX2 = G2(1)/2;
HX3 = G3(1)/2;

plot_memless(G1,HX1,HN1,K,average_length1,'X^1')
plot_memless(G2,HX2,HN2,K,average_length2,'X^2')
plot_memless(G3,HX3,HN3,K,average_length3,'X^3')