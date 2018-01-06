function N50(M)
%%
% Give me a vector

len = length(M);
sorted_M = sort(M,'descend');
M_sum = int64(sum(M));
s = 0;
    
for i = 1:len
    s = s + sorted_M(i);
    while s >= M_sum/2
        n = sorted_M(i);
        fprintf('Congratulations! The N50 is %d.\n',n)
        return
    end    
end
