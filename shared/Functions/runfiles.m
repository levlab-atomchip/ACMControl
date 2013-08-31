function runfiles(name,value,j,numTOFs,ddsName)

mag = floor(log10(abs(value)));
CurrContParChange = value/10^(mag);
while floor(mag/3) ~= (mag/3)
    mag = mag - 1;
    CurrContParChange = CurrContParChange*10;
end
switch mag
    case -Inf
        CurrContParStr = num2str(0);
    case 6
        CurrContParStr = [num2str(CurrContParChange) 'M'];
    case 3
        CurrContParStr = [num2str(CurrContParChange) 'k'];
    case 0
        CurrContParStr = num2str(CurrContParChange);
    case -3
        CurrContParStr = [num2str(CurrContParChange) 'm'];
    case -6
        CurrContParStr = [num2str(CurrContParChange) 'u'];
    case -9
        CurrContParStr = [num2str(CurrContParChange) 'n'];
end
RunFileName_temp = ['GUIRun_' name '_' CurrContParStr];
RunFileName = genvarname(RunFileName_temp);
RunFileName = strrep(RunFileName,'0x2E','xo');
RunFileName = strrep(RunFileName,'0x2D','xn');
AdjustedValue = strrep(RunFileName,['GUIRun_' name '_'],'');

orgPath = cd(fileparts(mfilename('fullpath')));
RunTemplate = fopen('..\templates\RunTemplate.m');
cd(orgPath)
RunText = fscanf(RunTemplate,'%c');
fclose(RunTemplate);
RunText = regexprep(RunText,'REPLACEj', num2str(j));
RunText = regexprep(RunText,'REPLACEN', num2str(numTOFs));
RunText = regexprep(RunText,'REPLACEValue', AdjustedValue);
RunText = regexprep(RunText,'REPLACEDDS', ddsName);
RunNew = fopen([RunFileName '.m'], 'w');
fprintf(RunNew,'%c',RunText);
fclose(RunNew);

end