function checkVal = checkLine(exp, line,conditionValue,conditionDirection, duration)
% Checks a line of experiment exp for condition over a duration.  If the
% condition is met for duration then checkLine returns checkVal = 0.  If
% the condition is not met then checkLine returns checkVal = 1.


lineArray = exp.(line).array;

if strcmp('greater',conditionDirection)
    ind = find(lineArray > conditionValue);
elseif strcmp('less', conditionDirection)
    ind = find(lineArray < conditionValue);
else
    error('Condition direction must be given as "greater" or "less"');
end

if isempty(ind)
    checkVal = 1;
    return
end

lsub = 0;
tsub = 0;
last = 0;

for i=1:length(ind)
    if i==1
        last = ind(i);
        lsub = 1;
        tsub = 1;
    elseif ind(i) == last + 1
        last = ind(i);
        tsub = tsub + 1;
    elseif tsub > lsub
        lsub = tsub;
        tsub = 1;
        last = ind(i);
    else
        tsub = 1;
        last = ind(i);
    end
end  

if lsub >= floor(duration/exp.dt)
    checkVal = 0;
else
    checkVal = 1;
end