%Typical Loading
%Region I is 0<x<0.5
%Region II is 0.5<0.75
close all
clc
clear
L = 8.34;
DF = L /0.1203;
%Width Equations for Region I and II along wing
%Multiplied by -1 to get a positive width
YI = @(x) -DF*(0.1918417279*x-.25);
YII = @(x) -DF*((0.1918417279*x-.25)-(-0.4244748164*x+0.2122374082));

%x * Width equtions to calculate xbar
xYI = @(x) -DF*(0.1918417279*x.^2-.25*x) ;
xYII = @(x) -DF*((0.1918417279*x.^2-.25*x)-(-0.4244748164*x.^2+0.2122374082*x));

%The shear force at a point x is the width * DF

%Centriod locations for region I and region II
xbarI = @(x) (integral(xYI,0,x))/integral(YI,0,x);
xbarII = @(x) (integral(xYII,0.5,x))/integral(YII,0.5,x);


ArrayI = zeros(1,501);
ArrayII = zeros(1,251);
t1 = 0:0.001:0.5;
t2 = 0.5:0.001:.75;


for i=1:501
    ArrayI(i) = YI(t1(i));
end

for i=1:251
    ArrayII(i) = YII(t2(i));
end

hold on
plot(t1,ArrayI)
plot(t2,ArrayII)
xlabel("Length along Wing (m)")
ylabel("Shear Force (N)")
title("Distributed Load along Wing Typical Loading")


%Internal Shear when sectioning regionI and region II
VI = @(x) L - integral(YI,0,x);
VII = @(x) L - integral(YI,0,0.5) - integral(YII,0.5,x);

%Graphing Internal Shear
for i=1:501
    ArrayI(i) = VI(t1(i));
end

for i=1:251
    ArrayII(i) = VII(t2(i));
end

figure
hold on
plot(t1,ArrayI)
plot(t2,ArrayII)
xlabel("Length along Wing (m)")
ylabel("Internal Shear (N)")
title("Internal Shear Typical Loading")

xm = @(x) 13.2998*(0.75-x).^2+7.35685*(0.75-x);
m = @(x) 13.2998*(0.75-x)+7.35685;
%Internal Bending Moments sectioning Region I and Region II

MI = @(x) -(0.25*10.6818/2)*((0.75-x)-(1/6))-((13.2998*0.25+7.35685 + 13.2998*(0.75-x)+7.35685)/2)*((0.75-x)-0.25)*((0.75-x)-(integral(xm,0.25,(0.75-x))/integral(m,0.25,(0.75-x))));
MII = @(x) -(4/3)*10.8618*(.75-x)^3; 


for i=1:501
    ArrayI(i) = MI(t1(i));
end

for i=1:251
    ArrayII(i) = MII(t2(i));
end

figure
hold on
plot(t1,ArrayI)
plot(t2,ArrayII)
xlabel("Length along Wing (m)")
plot([0.5 0.5],[-.1099,-0.2263],'k:')
ylabel("Internal Bending Moments (N*m)")
title("Internal Bending Moment Typical Loading")

xm = @(x) 13.2998*(0.75-x).^2+7.35685*(0.75-x);
m = @(x) 13.2998*(0.75-x)+7.35685;


E = 7.3 * 1000; %N/mm^2
I = 46219.898; %mm^4
%slopeI
slopeI = @(x) (int(MI,x));
slopeII = @(x) (int(MII,x));

DeflecI = @(x) (1/(E*I))*(int(slopeI,x));
DeflecII = @(x) (1/E*I)*(int(slopeII,x));
%%
%for i=1:501
%    ArrayI(i) = DeflecI(t1(i));
%end

for i=1:251
    ArrayII(i) = DeflecII(t2(i));
end

%figure
%hold on
%plot(t1,ArrayI)
%plot(t2,ArrayII)
%xlabel("Length along Wing (m)")

 