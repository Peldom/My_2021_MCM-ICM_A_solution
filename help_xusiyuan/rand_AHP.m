function [judgemtx]=rand_AHP(n,diff)
judgemtx=ones(n);
randIndex = randperm(n);
    for i=1:n
        for j=1:n
            if(i~=j)
                 if((find(randIndex==j)-find(randIndex==i))>0)
                    judgemtx(i,j)=rand_pos_or_neg()*abs((find(randIndex==j)-find(randIndex==i))/(n-1)*diff);
                    judgemtx(j,i)=1/judgemtx(i,j);
                 else
                     judgemtx(i,j)=rand_pos_or_neg()*abs(1/((find(randIndex==j)-find(randIndex==i))/(n-1)*diff));
                     judgemtx(j,i)=1/judgemtx(i,j);
                 end
            end
        end
    end
end