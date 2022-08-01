function plot_memless(G,Hx,HN,K,average_length_huffman,name)
H = zeros(1,length(K)); 
for i = 1:length(H)
    H(1,i) = Hx;
end
code_efficiency = zeros(1,length(K));
for i = 1:length(code_efficiency)
    code_efficiency(1,i) = H(1,i) / (HN(1,i));
end

figure
plot(K,G,'r');
hold on ;
plot(K,average_length_huffman,'black');
hold on 
plot(K,H,'b');
title('Average Code Length and G_k for ', name);
legend({'$G_k$','Average Length','Entropy'},'Interpreter','latex')
grid on;
hold off
figure
plot(K,code_efficiency,'black');
hold on ;
plot(K,H,'b');
hold on ;
plot(K, HN,'r');
title('Code Efficiency and Entropy for ', name);
legend({'Coding Efficiency','Entropy','$\hat{H}_k$'},'Interpreter','latex')
grid on;
end