function distance=bestCandidate(community_num,max)
xmax = max;
ymax = max;
N = community_num;
x = zeros(N,1); y = zeros(N,1);
x(1) = rand(1,1)*xmax; % 初始布置一个点
y(1) = rand(1,1)*ymax; % 或许可以布置多个点在边界上哦
numCandidates = 10;
for ii = 2:N
    xCand = rand(numCandidates,1)*xmax; % 随机选择 numCand.. 个候选点
    yCand = rand(numCandidates,1)*ymax;
    bestDistance = 0;
    for jj = 1:numCandidates 
        dists = sqrt( (x(1:ii-1)-xCand(jj)).^2 + (y(1:ii-1)-yCand(jj)).^2 ); % 已知点和 jj 号候选点的距离
        dist = min(dists);     % 获取最小的距离
        if (dist > bestDistance) % 如果 c 点的距离大于任何点
            bestDistance =  dist; % 更新最大距离
            bestCandidate = jj;   % 更新最佳点
        end
    end
    x(ii) = xCand(bestCandidate); y(ii) = yCand(bestCandidate); % 插入一个点
end
distance=[x y];
end