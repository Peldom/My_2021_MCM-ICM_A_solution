function T_M_SGA=count_T_M(filename)
% filename'D:\MATLAB\bin\2021A\problem_A_LV\climate_change\1.热带雨林气候_新加坡\37976_2021-02-07-14-53-08\weatherdata-141038.xlsx'
[num]=xlsread(filename);
% T_singapore=fileread();
% T_singapore=strsplit(T_singapore,{','});
% T_singapore = strip(T_singapore,'left','"');
% T_singapore = strip(T_singapore,'right','"');
% T_singapore=char(T_singapore);
T_M_SGA=zeros(size(num,1),2);
for i=1:size(num,1)
       T_M_SGA(i,1)=(num(i,4)+num(i,5))/2;
       T_M_SGA(i,2)=num(i,6);
end
end