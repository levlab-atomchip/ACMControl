function txt = VariablesSave(filename)
if nargin == 0
    filename = 'Variables.m';
end
file = fopen(filename, 'rt');
txt = fscanf(file,'%c');
fclose(file);