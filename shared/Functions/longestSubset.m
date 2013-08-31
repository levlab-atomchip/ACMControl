function lsub = longestSubset(inputList)

lsub = 0;
tsub = 0;
last = 0;

for i=1:length(inputList)
    if i==1
        last = inputList(i);
        lsub = 1;
        tsub = 1;
    elseif inputList(i) == last + 1
        last = inputList(i);
        tsub = tsub + 1;
    elseif tsub > lsub
        lsub = tsub;
        tsub = 1;
        last = inputList(i);
    else
        tsub = 1;
        last = inputList(i);
    end
end  