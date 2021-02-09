clear;
%% permanent paras define
global community_num;community_num=30;
% community number of fungi

global C_tendency;C_tendency=rand(community_num,1);
global N_tendency;N_tendency=ones(community_num,1)-C_tendency;
% eating habits of each fungi community

global Gopt;Gopt=0.01*randi([8,12],community_num,1);
% Gopt(/day) is maximal growth rate in given environmental conditions
global Topt;Topt=randi([22,36],community_num,1);
global Mopt;Mopt=0.01*randi([65,100],community_num,1);

global Q1;global Q2;
Q1=0.1*randi([12,15]);Q2=0.1*randi([12,15]);
% Q1/Q2(%) are dimensionless scaling 

global k;k=randi([10,20],community_num,1);
% surface per fungal unit (m^2/g)

global distance;
distance=random_dis(community_num,100);

%% env codition
tspan=[1:1:100];
C1=2;C2=9;N1=0.25;NH4=0; %g/m^-2
global T;T=25; %C temperature
global M;M=0.6; % M moisture
global VNH4;VNH4=0.1; %g/d VNH4 input of NH4 from an independent source(bacteria)
env_condition=[C1 C2 N1 NH4]; %g/m^-2
B0=ones(community_num,1);
env0=vertcat(env_condition',B0);

%% draw
[T,env]=ode45('fungis',tspan,env0);
figure;
for i=[1:1:community_num]
    hold on
    plot(T,env(:,(i+7))); 
end
grid on
hold off
figure;
for i=[1:1:4]
    hold on
    plot(T,env(:,i)); 
end
xlabel('time')
ylabel('remain mass')
legend('C1','C2','N','NH_4')
grid on
hold off