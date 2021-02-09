function distance=random_dis(community_num,max)
xmax = max;
ymax = max;
x = xmax*rand(community_num,1);
y = ymax*rand(community_num,1);
distance=zeros(community_num);
for i=[1:1:community_num]
    for j=[1:1:community_num]
        distance(i,j)=sqrt((x(i)-x(j))^2+(y(i)-y(j))^2);
    end
end