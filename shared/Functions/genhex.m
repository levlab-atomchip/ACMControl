function genhex(array,nameString)
[m,n] = size(array);
if isempty(array)
    fprintf(2,'No DDS Code\n');
    if exist(nameString,'dir')
        rmdir(nameString,'s')
        fprintf(2,'Removed old DDS directory\n');
    end
    return;
end

str = '{ ';
for i = 1:m
    str = [str '{'];
    for j = 1:n
        str = [str num2str(array(i,j))];
        if j == n;
            str = [str '}'];
        else
            str = [str ', '];
        end
    end
    if i == m;
        str = [str ' }'];
    else
        str = [str ', '];
    end
%     comstr = strrep(str,'{','');
%     comstr = strrep(comstr,'}','');
%     comstr = strrep(comstr,',','');
%     comstr = strrep(comstr,' ','');
%     comstr = strrep(comstr,'9','');
%     comstr = strrep(comstr,';','');
%     length(comstr)
%     length(comstr)/8
end

mstr = num2str(m);
nstr = num2str(n);

varfile = fopen('template\template.pde');
vartext = fscanf(varfile,'%c');
fclose(varfile);
vartext = regexprep(vartext,'&&ARRAY&&', str);
vartext = regexprep(vartext,'&&M&&', mstr);
vartext = regexprep(vartext,'&&N&&', nstr);

if exist(nameString,'dir')
    origindir = cd(nameString);
    oldfile = fopen([nameString '.pde']);
    oldtext = fscanf(oldfile,'%c');
    fclose(oldfile);
    if strcmp(vartext,oldtext)
        disp('     ...DDS code already compiled')
        cd(origindir);
        return
    else
        if exist('obj','dir')
            rmdir('obj','s');
        end
        cd(origindir);
    end
else
    mkdir(nameString)
end

varfileMOD = fopen([nameString '\' nameString '.pde'],'w');
fprintf(varfileMOD,'%c',vartext);
fclose(varfileMOD);

origindir = cd(nameString);
disp('     ...Compiling DDS Code')
evalc('system([''abuild -C '' nameString ''.pde'']);');
cd(origindir)
