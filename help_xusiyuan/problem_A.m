clear;

%     global fc;
%     fc=0.5*(0.5+0.1*i_t);
%% permanent paras define
global community_num;community_num=200;
% if i_t==1
%     community_num=3;
% else
%     community_num=10;
% end
% community number of fungi
% global C_tendency;C_tendency=rand(community_num,1);
% global N_tendency;N_tendency=ones(community_num,1)-C_tendency;
% % eating habits of each fungi community

global Gopt;Gopt=0.01*randi([8,12],community_num,1);
% Gopt(/day) is maximal growth rate in given environmental conditions
global Tmax;Tmax=randi([30,50],community_num,1);
global Tmin;Tmin=randi([-10,6],community_num,1);
global Mhalf;Mhalf=0.01*randi([10,60],community_num,1);
global Mmin;Mmin=0.01*20;

global Q1;global Q2;
Q1=0.1*randi([12,15]);Q2=0.1*randi([12,15]);
% Q1/Q2(%) are dimensionless scaling 

global k;k=randi([10,20],community_num,1);
% surface per fungal unit (m^2/g)

% global distance;distance=random_dis(community_num,Smax);
global Smax;
Smax=community_num*1/mean(k);% 10 times of max S(m2)


global compete;
[compete]=rand_AHP(community_num,9);

%% env codition
% figure;
%% 1 arid
% climate_filename1='D:\MATLAB\bin\2021A\problem_A_LV\climate_change\1.寒冷沙漠气候\37975_2021-02-07-14-48-59\weatherdata-504572.xlsx';
% global T_M1
% T_M1=count_T_M(climate_filename1);
% tspan1=[1:1:size(T_M1,1)];
% %% 2 semi-arid
% global T_M2
% climate_filename2='D:\MATLAB\bin\2021A\problem_A_LV\climate_change\2.寒冷的半干旱气候_瓦伦西亚\37971_2021-02-07-14-24-13\weatherdata-3950.xlsx';
% T_M2=count_T_M(climate_filename2);
% tspan2=[1:1:size(T_M2,1)];
% %% 3 temperate
% global T_M3
% climate_filename3='D:\MATLAB\bin\2021A\problem_A_LV\climate_change\3.艾尔比斯坦_温暖湿润的大陆性气候\37968_2021-02-07-14-15-13\weatherdata-382372.xlsx';
% T_M3=count_T_M(climate_filename3);
% tspan3=[1:1:size(T_M3,1)];
% %% 4 tropical
% global T_M4
% climate_filename4='D:\MATLAB\bin\2021A\problem_A_LV\climate_change\4.热带雨林气候_新加坡\37976_2021-02-07-14-53-08\weatherdata-141038.xlsx';
% T_M4=count_T_M(climate_filename4);
% tspan4=[1:1:size(T_M4,1)];
% %% 5 aboreal
% global T_M5
% climate_filename5='D:\MATLAB\bin\2021A\problem_A_LV\climate_change\5.乔木_长沙\weatherdata-2831131.xlsx';
% T_M5=count_T_M(climate_filename5);
% tspan5=[1:1:size(T_M5,1)];
%% draw climate
% subplot(1,2,1);grid on
% hold on
% plot(tspan1,smooth(smooth(T_M1(:,1))),'LineWidth',2)
% hold on
% plot(tspan2,smooth(smooth(T_M2(:,1))),'LineWidth',2);
% hold on
% plot(tspan3,smooth(smooth(T_M3(:,1))),'LineWidth',2);
% hold on
% plot(tspan4,smooth(smooth(T_M4(:,1))),'LineWidth',2)
% hold on
% plot(tspan5,smooth(smooth(T_M5(:,1))),'LineWidth',2)
% xlabel('time / d')
% ylabel('Temperature / °C')
% legend('arid','semi-arid', 'temperate','tropical','arboreal')
% hold off
% 
% subplot(1,2,2);grid on
% plot(tspan1,smooth(smooth(T_M1(:,2))),'LineWidth',2)
% hold on
% plot(tspan2,smooth(smooth(T_M2(:,2))),'LineWidth',2)
% hold on
% plot(tspan3,smooth(smooth(T_M3(:,2))),'LineWidth',2)
% hold on
% plot(tspan4,smooth(smooth(T_M4(:,2))),'LineWidth',2)
% hold on
% plot(tspan5,smooth(smooth(T_M5(:,2))),'LineWidth',2)
% hold on
% grid on
% xlabel('time / d')
% ylabel('Moisture / %')
% legend('arid','semi-arid', 'temperate','tropical','arboreal')
% for i=1:1:6
%     hold on
%     T_M=count_T_M(climate_filename(i,:));
%     tspan=[1:1:size(T_M,1)];
%     subplot(1,2,1);
%     plot(tspan,T_M(:,1))
%     xlabel('time / d');
%     ylabel('Temperature / °C');
%     subplot(1,2,2);
%     plot(tspan,T_M(:,2))
%     xlabel('time / d');
%     ylabel('Moisture / %');
% end

tspan=[1:1:100];
C1=2;C2=9;N1=0.25;NH4=0; %g/m^-2
global T;T=28; %C temperature
global M;M=0.75; % M moisture
global VNH4;VNH4=0.1; %g/d VNH4 input of NH4 from an independent source(bacteria)
env_condition=[C1 C2 N1 NH4]; %g/m^-2
env_condition=env_condition.*10;
B0=0.01*randi([95,105],community_num,1)/community_num;%initial biomass of communities
env0=vertcat(env_condition',B0);

%% solve
% lags=randi([20,30],community_num,1);
[t,env_result]=ode45('fungis',tspan,env0);
%% draw curves
% subplot(2,3,i)
fungi_nums=env_result;
for i=1:4
    fungi_nums(:,1)=[];
end
% miny=min(min(fungi_nums));
% maxy=max(max(fungi_nums))+1;
% dotted_x=[8 11 20 23 36 39];
% for d_i=[1:6]
%     hold on
%     plot([dotted_x(d_i),dotted_x(d_i)],[miny,maxy],'--','LineWidth',2,'Color',[0.5 0.5 0.5]);
% end
% hold on
% patch([0 dotted_x(1) dotted_x(1) 0],[miny miny maxy maxy],[0.5 0.5 0.5],'facealpha',0.1);
% figure(1);
% subplot(2,2,i_t);
% for i=[1:1:community_num]
%     hold on
%     plot(t,env_result(:,(i+4)),'LineWidth',2); 
% end
% xlabel('time / d')
% ylabel('fungal biomass / g')
% title_string=strcat('number of community=',num2str(community_num));
% title(title_string)
% grid on
% hold off

% subplot(2,2,i_t+2);
% for i=[1:1:4]
%     hold on
%     plot(t,env_result(:,i),'LineWidth',2); 
% end
figure(1);
grid on
% for d_i=[1:6]
%     hold on
%     plot([dotted_x(d_i),dotted_x(d_i)],[0,max(env_result(1,:))],'--','LineWidth',2,'Color',[0.5 0.5 0.5]);
% end
% title_string=strcat('number of community=',num2str(community_num));
% title(title_string)
% legend_string=strcat('fc=',num2str(fc));
% CdN=(env_result(:,1)+env_result(:,2))./(env_result(:,3));

% for d_i=size(CdN,1):-1:1
%     if CdN(d_i)<0
%         CdN(d_i)=[];
%     end
% end
% hold on
% plot(CdN,'LineWidth',2);
% xlabel('time / d')
% ylabel('C/N ')
% %'C/N')

% legend('0.30','0.35','0.40','0.45','0.50','0.55','0.60','0.65','0.70','0.75');
%% draw maps
figure;hold on
fungi_map=bestCandidate(community_num,sqrt(Smax));
color=linspace(1,10,community_num);
for i_t=1:4
subplot(2,2,i_t);
scatter(fungi_map(:,1),fungi_map(:,2),2000*(fungi_nums(round((i_t-1)*max(tspan)/4)+1,:)'./k),color,'filled','o');
xlabel('length / m')
ylabel('width / m')
title_string=strcat('t=',num2str(round((i_t-1)*max(tspan)/4)+1));
title(title_string)
end
hold off
