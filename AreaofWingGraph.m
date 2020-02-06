%Evan
%Region I is 0<x<0.5
%Region II is 0.5<0.75
clc
close all
clear
%Width of Wing over the length
%Multiplied by -1 to get a positive width
YI = @(x) -(0.1918417279*x-.25);
YII = @(x) -((0.1918417279*x-.25)-(-0.4244748164*x+0.2122374082));

%Accumulative Area along the length of the wing
AI = @(x) integral(YI,0,x); 
AII = @(x) integral(YII,0.5,x);


ArrayI = zeros(1,50);
ArrayII = zeros(1,25);
t1 = 0:0.01:0.5;
t2 = 0.5:0.01:.75;


for i=1:51
    ArrayI(i) = 69.33*YI(t1(i));
end

for i=1:26
    ArrayII(i) = 69.33*YII(t2(i));
end

hold on
plot(t1,ArrayI)
plot(t2,ArrayII)
xlabel("Length along Wing (m)")
ylabel("Distributed Force (N/m)")
title("Distributed Force along the Wing")
legend("Region I","Region II")

for i=1:51
    ArrayI(i) = AI(t1(i));
end

for i=1:26
    ArrayII(i) = AI(.5) + AII(t2(i));
end

figure
hold on
plot(t1,ArrayI)
plot(t2,ArrayII)

xlabel("Length along Wing (m)")
ylabel("Width of Wing (m)")
title("Cululative Area over the Length of the Wing")
legend("Region I","Region II")