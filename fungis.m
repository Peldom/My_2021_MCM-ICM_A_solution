function [denv]=fungis(t,env)
%% environment paras
C1=env(1);
C2=env(2);
N1=env(3);
NH4=env(4);
global T;
global M;
global VNH4;
% env(8)..(n)=community

%% fungi paras
global community_num;
global distance;
denv=ones(community_num,1);

fn=0.05;fc=0.5;alpha=fc/0.4;beta=4;
% 0.4:ratio of carbon assimilated to carbon decomposed
% fn=average fraction of nitrogen in the decomposer’s cell

global C_tendency;
global N_tendency;
global Gopt;
Kc=20;Kn=0.4;
% Kc(g/m^-2) a constant which describes the concentration of c’ at given N which
% will give G = Gmax/2, same as Kn
Tmax=40;
global Topt;
Mmin=0.01*20;
global Mopt;
% Tmax/Mmax(C) is the temperature where growth ceases (i.e., where the curve subtends thex-axis)
% Topt/Mopt(C) growth rate achieved at the optimal temperature/moisture
global Q1;global Q2;

growth_rates=(Gopt*(C1+C2)*N1)/((Kc+C1+C2)*(Kn+N1)).*((Tmax-T)./(Tmax-Topt)).^Q1.*((Mmin-M)./(Mmin-Mopt)).^Q2;
% growth rate of all fungal commuities
global k;

%% community change order linear differential equations of all communities
sumGB=0;sumS=0;
for iter=[1:1:community_num]
    grow_ac=growth_rates(iter);
    sumS=k(iter)*env(iter+4);
    for jter=[1:1:community_num]
        if jter==iter
            continue
        else
            
            grow_ac=grow_ac-1/distance(iter,jter)*growth_rates(jter);
        end
    end
    denv(iter+4)=grow_ac*k(iter)+C_tendency(iter)*C1+N_tendency(iter)*C2;
    sumGB=sumGB+growth_rates(iter)*env(iter+4);
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

end