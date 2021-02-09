function [denv]=fungis(t,env)
%% environment paras
C1=env(1);
C2=env(2);
N1=env(3);
NH4=env(4);
global T;
global M;
global VNH4;
fungi_Bms=env;
for i=1:4
    fungi_Bms(1,:)=[];
end
% env(8)..(n)=community=fungi_Bms

%% fungi paras
global community_num;
denv=ones(community_num,1);
fc=0.5;
fn=0.05;alpha=fc/0.4;beta=4;
% 0.4:ratio of carbon assimilated to carbon decomposed
% fn=average fraction of nitrogen in the decomposer’s cell
% %% weather change
% T_weather=[20 40 3 25];
% M_weather=[1.00 0.45 0.50 0.80];
% %rain sunburn snow cloud
% if t<8
%     T=T_weather(1);
%     M=M_weather(1);
% elseif t<11 %ex
%     T=T_weather(2);
%     M=M_weather(2);
% elseif t<20
%     T=T_weather(4);
%     M=M_weather(4);
% elseif t<23 
%     T=T_weather(3);
%     M=M_weather(3);
% elseif t<36
%     T=T_weather(4);
%     M=M_weather(4);
% elseif t<39
%     T=T_weather(2);
%     M=M_weather(2);
% else
%     T=T_weather(4);
%     M=M_weather(4);
% end
%% climate change
% global T_M5
% T=T_M5(ceil(t),1);
% M=T_M5(ceil(t),2);
%% env continue
global Gopt;
Kc=20;Kn=0.4;
% Kc(g/m^-2) a constant which describes the concentration of c’ at given N which
% will give G = Gmax/2, same as Kn
global Tmax;
global Tmin;
global Mhalf;
% Tmax/Mmax(C) is the temperature where growth ceases (i.e., where the curve subtends thex-axis)
% Topt/Mopt(C) growth rate achieved at the optimal temperature/moisture
Tfit=zeros(community_num,1);
Mfit=zeros(community_num,1);
for i=1:1:community_num
    Tfit(i)=T_dis(Tmin(i),Tmax(i),T);
    Mfit(i)=M_dis(Mhalf(i),M);
end
% g_change=ones(community_num,100);
% for i=1:100
% g_change(:,i)=((Tmax-i)./(Tmax-Topt)).^Q1.*exp(-Q1*((Tmax-T)./(Tmax-Topt)-1));
% end
% plot(g_change)
% for t=1:community_num
% plot(g_change(t,:));hold on
% end
growth_rates=(Gopt*(C1+C2)*(N1+NH4))/((Kc+C1+C2)*(Kn+(N1+NH4))).*(Tfit.*Mfit);
% growth rate of all fungal commuities
global k;%g/m^2
global Smax;

%% community change order linear differential equations of all communities
sumGB=0;sumS=0;
global compete;
sumS=sum(fungi_Bms./k);%m^2
sumGB=sum(growth_rates.*fungi_Bms);
% sumS/Smax-pi/4
for iter=[1:1:community_num]
    if sumS<Smax*pi/4
        denv(iter+4)=growth_rates(iter)*fungi_Bms(iter).*(1-fungi_Bms(iter)./k(iter)/Smax);
    else     
        compete_temp=(compete(iter,:)'.*fungi_Bms./k)/Smax;
        denv(iter+4)=growth_rates(iter)*fungi_Bms(iter)*(1-sum(compete_temp));
    end
end

i=fn*sumGB*NH4/(N1+NH4);
%i is the rate of immobilization of NH4+

%% decomposite rates of all fungi
if (C1+C2)/N1>alpha/fn
    denv(1)=-beta*(fn*sumGB-i);
    denv(2)=-(alpha*sumGB-beta*(fn*sumGB-i));
    denv(3)=-fn*sumGB-i;
    m=0;
    denv(4)=m-i+VNH4;
else
    denv(1)=-alpha*sumGB*(env(1)/(env(1)+env(2)));
    denv(2)=-alpha*sumGB*(env(2)/(env(1)+env(2)));
    denv(3)=-alpha*sumGB*(env(3)/(env(1)+env(2)));
    m=0.1; 
    denv(4)=m-i+VNH4;
end
% NH4-((C1+C2)*fn-alpha*N1)/alpha
% t
% denv(1)=denv(1)+0.2;
% denv(2)=denv(2)+0.9;
% if you add this, ode stays in t=27.84
% denv(3)=denv(3)+0.25;
end