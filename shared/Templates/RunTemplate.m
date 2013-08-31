clc
AdjContParValue = 'REPLACEValue';
NumOfTOF = REPLACEN;

uploadArduino('REPLACEDDS');

for CurrTOFNum = 1:NumOfTOF
    
    var = ['ACMBlock' num2str(REPLACEj) '_' num2str(CurrTOFNum)];
    load(var);
    
    block = eval('ACMBlock');
    
    % Don't pass too fast and overwrite experiment parameters before imaging reads file
    while CurrTOFNum > 1 && toc < .5
    end
    
    drawnow
    if exist('handles','var') && get(handles.RunStop_btn,'userdata')
        block = block.clearTasks;
        clear block;
        break
    end
    
    while 1
        [stat,saveAttrib] = fileattrib('Z:\Data\ACM Data\ImagingData\ACMRunData.mat');
        if saveAttrib.UserWrite
            break
        end
    end 
    save('Z:\Data\ACM Data\ImagingData\ACMRunData.mat','ContParName','CurrContPar','CurrTOF','AdjContParValue','NumOfTOF','CurrTOFNum','AllFiles','-append');
    
    disp(['[' var ']']);
    disp('-----------------------------')
    if exist('SBList','var') || exist('IsoImg','var')
%         disp('-----------------------------')
        if exist('SBList','var')
            disp(SBList)
        end
        if exist('IsoImg','var')
            disp(['IsoImg: ' num2str(IsoImg)])
        end
    end
    disp([ContParName ': ' num2str(CurrContPar)]);
    disp(['TOF: ' num2str(CurrTOF) ' ms']);
    disp('-----------------------------')
    block = block.initializeHardware;
    block = block.run;
    tic
    
    block = block.clearTasks;
    
    clear block;
    disp(' ')
end