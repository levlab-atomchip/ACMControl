function varargout = ControllerGUI(varargin)
%CONTROLLERGUI M-file for ControllerGUI.fig
%      CONTROLLERGUI, by itself, creates a new CONTROLLERGUI or raises the existing
%      singleton*.
%
%      H = CONTROLLERGUI returns the handle to a new CONTROLLERGUI or the handle to
%      the existing singleton*.
%
%      CONTROLLERGUI('P
%      given property value pairs. Unrecognized properties are passed via
%      varargin to ControllerGUI_OpeningFcn.  This calling syntax produces a
%      warning when there is an existing singleton*.
%
%      CONTROLLERGUI('CALLBACK') and CONTROLLERGUI('CALLBACK',hObject,...) call the
%      local function named CALLBACK in CONTROLLERGUI.M with the given input
%      arguments.roperty','Value',...) creates a new CONTROLLERGUI
%      using the
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help ControllerGUI

<<<<<<< HEAD
% Last Modified by GUIDE v2.5 15-Oct-2013 14:10:12
=======
% Last Modified by GUIDE v2.5 30-Aug-2013 19:11:55
>>>>>>> 4a1ccf7d7d3baea4d17d5e8ef44e2dbe07aa1f63

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
    'gui_Singleton',  gui_Singleton, ...
    'gui_OpeningFcn', @ControllerGUI_OpeningFcn, ...
    'gui_OutputFcn',  @ControllerGUI_OutputFcn, ...
    'gui_LayoutFcn',  [], ...
    'gui_Callback',   []);
if nargin && ischar(varargin{1})
    gui_State.gui_Callback = str2func(varargin{1});
end

if nargout
    [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
    gui_mainfcn(gui_State, varargin{:});
end
% End initialization code - DO NOT EDIT


% --- Executes just before ControllerGUI is made visible.
function ControllerGUI_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   unrecognized PropertyName/PropertyValue pairs from the
%            command line (see VARARGIN)

% Choose default command line output for ControllerGUI
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% Add the GUI directory to path
GUIDir = pwd;
addpath(GUIDir)
set(handles.title_txt,'userdata',GUIDir,'String','Controller Code GUI')

% Initialize some values
% set(handles.NormalMode_rbtn,'Value',1,'KeyPressFcn',@(hObject,eventdata)ControllerGUI('mainfigure_KeyPressFcn',hObject,eventdata,guidata(hObject)))
% set(handles.DataRunNum_etxt,'String','0','KeyPressFcn',@(hObject,eventdata)ControllerGUI('mainfigure_KeyPressFcn',hObject,eventdata,guidata(hObject)))
set(handles.Status_txt,'String','--')
set(handles.CurrNumRuns_txt,'String','--')
set(handles.TotalNumRuns_txt,'String','--')
set(handles.SaveProfile_btn,'KeyPressFcn',@(hObject,eventdata)ControllerGUI('mainfigure_KeyPressFcn',hObject,eventdata,guidata(hObject)))
set(handles.LoadProfile_btn,'KeyPressFcn',@(hObject,eventdata)ControllerGUI('mainfigure_KeyPressFcn',hObject,eventdata,guidata(hObject)))
set(handles.RunStop_btn,'KeyPressFcn',@(hObject,eventdata)ControllerGUI('mainfigure_KeyPressFcn',hObject,eventdata,guidata(hObject)))
set(handles.ClearAll_btn,'KeyPressFcn',@(hObject,eventdata)ControllerGUI('mainfigure_KeyPressFcn',hObject,eventdata,guidata(hObject)))
% set(handles.DataParentFolder_etxt,'KeyPressFcn',@(hObject,eventdata)ControllerGUI('mainfigure_KeyPressFcn',hObject,eventdata,guidata(hObject)))
% set(handles.DataRunNum_etxt,'KeyPressFcn',@(hObject,eventdata)ControllerGUI('mainfigure_KeyPressFcn',hObject,eventdata,guidata(hObject)))
% set(handles.Reset_btn,'KeyPressFcn',@(hObject,eventdata)ControllerGUI('mainfigure_KeyPressFcn',hObject,eventdata,guidata(hObject)))
% set(handles.DataMode_rbtn,'KeyPressFcn',@(hObject,eventdata)ControllerGUI('mainfigure_KeyPressFcn',hObject,eventdata,guidata(hObject)))
set(handles.hardstop_btn,'userdata',0)


for n=1:26
    set(handles.(['SingleClose' num2str(n)]),'callback',@(hObject,eventdata)ControllerGUI('SingleCloseButtons',hObject,eventdata,guidata(hObject),n),'KeyPressFcn',@(hObject,eventdata)ControllerGUI('mainfigure_KeyPressFcn',hObject,eventdata,guidata(hObject)))
    set(handles.(['ChooseFolder' num2str(n)]),'callback',@(hObject,eventdata)ControllerGUI('FolderButtons',hObject,eventdata,guidata(hObject),n),'KeyPressFcn',@(hObject,eventdata)ControllerGUI('mainfigure_KeyPressFcn',hObject,eventdata,guidata(hObject)))
    set(handles.(['RunFile' num2str(n)]),'userdata',1,'callback',@(hObject,eventdata)ControllerGUI('RunButtons',hObject,eventdata,guidata(hObject),n),'Interruptible','on','enable','off','KeyPressFcn',@(hObject,eventdata)ControllerGUI('mainfigure_KeyPressFcn',hObject,eventdata,guidata(hObject)))
    set(handles.(['FileName' num2str(n)]),'String','--')
    set(handles.(['NumOfRuns' num2str(n)]),'String','inf','KeyPressFcn',@(hObject,eventdata)ControllerGUI('mainfigure_KeyPressFcn',hObject,eventdata,guidata(hObject)))
end

% UIWAIT makes ControllerGUI wait for user response (see UIRESUME)
% uiwait(handles.mainfigure);

function SingleCloseButtons(hObject, eventdata, handles, n)
set(handles.(['RunFile' num2str(n)]),'enable','off')
set(handles.(['FileName' num2str(n)]),'String','--')
set(handles.(['NumOfRuns' num2str(n)]),'String','1')

function RunButtons(hObject, eventdata, handles, n)
drawnow
RunDefined = get(handles.(['RunFile' num2str(n)]),'enable');
if strcmp(RunDefined,'off')
    return
end
<<<<<<< HEAD
% set(handles.DataMode_rbtn,'enable','off')
% set(handles.NormalMode_rbtn,'enable','off')
=======
set(handles.DataMode_rbtn,'enable','off')
set(handles.NormalMode_rbtn,'enable','off')
set(handles.randomrun_btn,'enable','off')
>>>>>>> 4a1ccf7d7d3baea4d17d5e8ef44e2dbe07aa1f63
for i = 1:26
    runEnabled{i} = get(handles.(['RunFile' num2str(i)]),'enable');
    set(handles.(['RunFile' num2str(i)]),'enable','off')
end
switch 0;%get(handles.DataMode_rbtn,'Value') %Avoid clear if data mode already running
    case 0
        set(handles.RunStop_btn,'userdata',0) % make sure stop trigger is 0 when 'Run' is selected
        set(handles.hardstop_btn,'userdata',0)
        status_cells = get(handles.Status_txt,'userdata'); % load names of different files
        set(handles.Status_txt,'String',status_cells{n})
        
        set(handles.TotalNumRuns_txt,'String',get(handles.(['NumOfRuns' num2str(n)]),'String'))
        set(handles.CurrNumRuns_txt,'String',1)
        
        for i = 1:str2num(get(handles.TotalNumRuns_txt,'String'))
            drawnow
            if get(handles.RunStop_btn,'userdata') || get(handles.hardstop_btn,'userdata')
                break
            end
            set(handles.CurrNumRuns_txt,'String',i)
            set(handles.StatusState_txt,'String','Running')
            drawnow
            clc
            assignedFile = get(handles.(['FileName' num2str(n)]),'userdata');
            cd(assignedFile{2});
            assignedFileName = strrep(assignedFile{1},'.m','');
            
%             DataMode = get(handles.DataMode_rbtn,'Value');
%             CustomName = get(handles.DataCustomName_cbox,'Value');
%             ImgParentFolder = get(handles.DataParentFolder_etxt,'String');
%             ImgSetNum = get(handles.DataRunNum_etxt,'String');
%             FileName = get(handles.DataCustomName_etxt,'String');
%             
%             while 1
%                 if ls('I:\lock')
%                     continue
%                 end
%                 disp(1)
%                 save('I:\RunData.mat','DataMode','CustomName','ImgParentFolder','ImgSetNum','FileName','-append');
%                 break
%             end
            
            try
                eval(assignedFileName)
            catch err
                for i = 1:26
                    tempStr =  runEnabled{i};
                    set(handles.(['RunFile' num2str(i)]),'enable',tempStr)
                end
%                 set(handles.DataMode_rbtn,'enable','on')
%                 set(handles.NormalMode_rbtn,'enable','on')
                rethrow(err)
            end
        end
        set(handles.StatusState_txt,'String','Done!')
%         set(handles.RunStop_btn,'userdata',0)
%         set(handles.hardstop_btn,'userdata',0)
        
        
%     case 1
%         set(handles.DataParentFolder_etxt,'enable','off')
%         set(handles.DataRunNum_etxt,'enable','off')
%         set(handles.Reset_btn,'enable','off')
%         set(handles.DataCustomName_cbox,'enable','off')
%         set(handles.DataCustomName_etxt,'enable','off')
%         switch get(handles.(['RunFile' num2str(n)]),'userdata') %prompt for rerun only
%             case 1
%                 set(handles.RunStop_btn,'userdata',0) % make sure stop trigger is 0 when 'Run' is selected
%                 set(handles.hardstop_btn,'userdata',0)
%                 status_cells = get(handles.Status_txt,'userdata'); % load names of different files
%                 set(handles.Status_txt,'String',status_cells{n})
%                 set(handles.(['RunFile' num2str(n)]),'BackgroundColor','red','userdata',0)
%                 set(handles.TotalNumRuns_txt,'String',1)
%                 set(handles.CurrNumRuns_txt,'String',1)
%                 set(handles.StatusState_txt,'String','Running')
%                 drawnow
%                 clc
%                 assignedFile = get(handles.(['FileName' num2str(n)]),'userdata');
%                 cd(assignedFile{2});
%                 assignedFileName = strrep(assignedFile{1},'.m','');
%                 
%                 DataMode = get(handles.DataMode_rbtn,'Value');
%                 CustomName = get(handles.DataCustomName_cbox,'Value');
%                 ImgParentFolder = get(handles.DataParentFolder_etxt,'String');
%                 ImgSetNum = get(handles.DataRunNum_etxt,'String');
%                 FileName = get(handles.DataCustomName_etxt,'String');
%                 
%                 while 1
%                     if ls('I:\lock')
%                         continue
%                     end
%                     save('I:\RunData.mat','DataMode','CustomName','ImgParentFolder','ImgSetNum','FileName','-append');
%                     break
%                 end
%                 
%                 
%                 try
%                     eval(assignedFileName)
%                 catch err
%                     for i = 1:26
%                         tempStr =  runEnabled{i};
%                         set(handles.(['RunFile' num2str(i)]),'enable',tempStr)
%                     end
%                     set(handles.DataMode_rbtn,'enable','on')
%                     set(handles.NormalMode_rbtn,'enable','on')
%                     throw(err)
%                 end
%                 set(handles.StatusState_txt,'String','Done!')
%                 
%             case 0
%                 rerun_question = questdlg('Run this code again?','Rerun code...','Yes','No','No');
%                 switch rerun_question
%                     case 'Yes'
%                         set(handles.RunStop_btn,'userdata',0) % make sure stop trigger is 0 when 'Run' is selected
%                         set(handles.hardstop_btn,'userdata',0)
%                         status_cells = get(handles.Status_txt,'userdata'); % load names of different files
%                         set(handles.Status_txt,'String',status_cells{n})
%                         set(handles.TotalNumRuns_txt,'String',1)
%                         set(handles.CurrNumRuns_txt,'String',1)
%                         set(handles.StatusState_txt,'String','Running')
%                         drawnow
%                         clc
%                         assignedFile = get(handles.(['FileName' num2str(n)]),'userdata');
%                         cd(assignedFile{2});
%                         assignedFileName = strrep(assignedFile{1},'.m','');
%                         
%                         DataMode = get(handles.DataMode_rbtn,'Value');
%                         CustomName = get(handles.DataCustomName_cbox,'Value');
%                         ImgParentFolder = get(handles.DataParentFolder_etxt,'String');
%                         ImgSetNum = get(handles.DataRunNum_etxt,'String');
%                         FileName = get(handles.DataCustomName_etxt,'String');
%                         
%                         while 1
%                             if ls('I:\lock')
%                                 continue
%                             end
%                             save('I:\RunData.mat','DataMode','CustomName','ImgParentFolder','ImgSetNum','FileName','-append');
%                             break
%                         end
%                         
%                         
%                         try
%                             eval(assignedFileName)
%                         catch err
%                             for i = 1:26
%                                 tempStr =  runEnabled{i};
%                                 set(handles.(['RunFile' num2str(i)]),'enable',tempStr)
%                             end
%                             set(handles.DataMode_rbtn,'enable','on')
%                             set(handles.NormalMode_rbtn,'enable','on')
%                             throw(err)
%                         end
%                         set(handles.StatusState_txt,'String','Done!')
%                         
%                     case 'No'
%                 end
%                 
%                 
%         end
%         set(handles.DataParentFolder_etxt,'enable','on')
%         set(handles.DataRunNum_etxt,'enable','on')
%         set(handles.Reset_btn,'enable','on')
%         set(handles.DataCustomName_cbox,'enable','on')
%         if get(handles.DataCustomName_cbox,'Value')
%             set(handles.DataCustomName_etxt,'enable','on')
%         end
end
for i = 1:26
    tempStr =  runEnabled{i};
    set(handles.(['RunFile' num2str(i)]),'enable',tempStr)
end
<<<<<<< HEAD
% set(handles.DataMode_rbtn,'enable','on')
% set(handles.NormalMode_rbtn,'enable','on')
=======
set(handles.DataMode_rbtn,'enable','on')
set(handles.NormalMode_rbtn,'enable','on')
set(handles.randomrun_btn, 'enable', 'on')
>>>>>>> 4a1ccf7d7d3baea4d17d5e8ef44e2dbe07aa1f63

function FolderButtons(hObject, eventdata, handles, n)
cd(fileparts(mfilename('fullpath')))
cd('..\')
[setFile,setFolder] = uigetfile('.m','Choose Run File','OneRun.m');
if setFile ~= 0
    justname = strrep(setFile,'.m','');
    justname = strrep(justname,'GUIRun_','');
    justname = strrep(justname,'xo','.');
    justname = strrep(justname,'xn','-');
    if strcmp(justname,'VOID_0')
        bslash = find(setFolder=='\');
        justname = setFolder(bslash((end-1)):end-1);
    end
    assignedFile = {setFile setFolder};
    set(handles.(['FileName' num2str(n)]),'String',justname,'userdata',assignedFile)
    set(handles.(['RunFile' num2str(n)]),'enable','on')
    status_cells = get(handles.Status_txt,'userdata');
    status_cells{n} = justname;
    set(handles.Status_txt,'userdata',status_cells)
end

function RunStop_btn_Callback(hObject, eventdata, handles)
set(handles.RunStop_btn,'userdata',1)
set(handles.runall_btn,'userdata',1)
set(handles.randrunall_btn,'userdata',1)

% --- Outputs from this function are returned to the command line.
function varargout = ControllerGUI_OutputFcn(hObject, eventdata, handles)
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in ClearAll_btn.
function ClearAll_btn_Callback(hObject, eventdata, handles)
% hObject    handle to ClearAll_btn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
clearall_question = questdlg('Clear all file assignents?','Clear All...','Yes','No','No');
switch clearall_question
    case 'Yes'
        for n=1:26
            set(handles.(['RunFile' num2str(n)]),'enable','off')
            set(handles.(['FileName' num2str(n)]),'String','--')
            set(handles.(['NumOfRuns' num2str(n)]),'String','1')
        end
    case 'No'
end


% --- Executes on button press in LoadProfile_btn.
function LoadProfile_btn_Callback(hObject, eventdata, handles)
% hObject    handle to LoadProfile_btn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
cd('Z:\Controllor Code\ControllerCodeGUI Profiles')
[filename,pathname] = uigetfile('*.mat','Load Profile','default');
if pathname ~= 0
    profileFile = fullfile(pathname,filename);
    load(profileFile);
    for n = 1:26
        set(handles.(['FileName' num2str(n)]),'userdata',AssignedFiles{n},'String',FileNames{n});
        set(handles.(['RunFile' num2str(n)]),'enable',RunEnable{n});
        set(handles.Status_txt,'userdata',status_cells);
%         set(handles.DataParentFolder_etxt,'String',ImgParentFolder);
%         set(handles.DataRunNum_etxt,'String',ImgSetNum);
%         set(handles.DataCustomName_etxt,'String',CustFileName);
    end
end

% --- Executes on button press in SaveProfile_btn.
function SaveProfile_btn_Callback(hObject, eventdata, handles)
% hObject    handle to SaveProfile_btn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
cd('Z:\Controllor Code\ControllerCodeGUI Profiles')
[filename,pathname] = uiputfile('*.mat','Save Profile','default');
if path~= 0
    for n = 1:26
        AssignedFiles{n} = get(handles.(['FileName' num2str(n)]),'userdata');
        FileNames{n} = get(handles.(['FileName' num2str(n)]),'String');
        RunEnable{n} = get(handles.(['RunFile' num2str(n)]),'enable');
        status_cells = get(handles.Status_txt,'userdata');
    end
%     ImgParentFolder = get(handles.DataParentFolder_etxt,'String');
%     ImgSetNum = get(handles.DataRunNum_etxt,'String');
%     CustFileName = get(handles.DataCustomName_etxt,'String');
    profileFile = fullfile(pathname,filename);
    save(profileFile,'AssignedFiles','FileNames','RunEnable','status_cells');%,'ImgParentFolder','ImgSetNum','CustFileName');
end



% % --- Executes on button press in NormalMode_rbtn.
% function NormalMode_rbtn_Callback(hObject, eventdata, handles)
% % hObject    handle to NormalMode_rbtn (see GCBO)
% % eventdata  reserved - to be defined in a future version of MATLAB
% % handles    structure with handles and user data (see GUIDATA)
% if get(handles.DataMode_rbtn,'Value')
%     set(handles.DataMode_rbtn,'Value',0)
%     mode_question = questdlg('Exit data mode? (Run history will be lost...)','Change mode...','Yes','No','No');
% else
%     mode_question = 'Yes';
% end
% 
% switch mode_question
%     case 'Yes'
%         set(handles.DataMode_rbtn,'Value',0)
%         set(handles.DataParentFolder_etxt,'Enable','Off')
%         set(handles.DataRunNum_etxt,'Enable','Off')
%         set(handles.Reset_btn,'Enable','Off')
%         set(handles.DataCustomName_cbox,'Enable','Off','Value',0)
%         set(handles.DataCustomName_etxt,'Enable','Off')
%         defaultBackground = get(0,'defaultUicontrolBackgroundColor');
%         for n = 1:26
%             set(handles.(['RunFile' num2str(n)]),'BackgroundColor',defaultBackground,'userdata',1);
%             set(handles.(['NumOfRuns' num2str(n)]),'Enable','On')
%         end
%         set(handles.NormalMode_rbtn,'Value',1)
%         
%     case 'No'
%         set(handles.NormalMode_rbtn,'Value',0)
%         set(handles.DataMode_rbtn,'Value',1)
%     case ''
%         set(handles.NormalMode_rbtn,'Value',0)
%         set(handles.DataMode_rbtn,'Value',1)
% end
% % Hint: get(hObject,'Value') returns toggle state of NormalMode_rbtn


% % --- Executes on button press in DataMode_rbtn.
% function DataMode_rbtn_Callback(hObject, eventdata, handles)
% % hObject    handle to DataMode_rbtn (see GCBO)
% % eventdata  reserved - to be defined in a future version of MATLAB
% % handles    structure with handles and user data (see GUIDATA)
% 
% if get(handles.NormalMode_rbtn,'Value')
%     for n = 1:26
%         set(handles.(['RunFile' num2str(n)]),'BackgroundColor','g','userdata',1)
%         set(handles.(['NumOfRuns' num2str(n)]),'Enable','Off')
%     end
% end
% set(handles.NormalMode_rbtn,'Value',0)
% set(handles.DataParentFolder_etxt,'Enable','On')
% set(handles.DataRunNum_etxt,'Enable','On')
% set(handles.Reset_btn,'Enable','On')
% set(handles.DataCustomName_cbox,'Enable','On')
% set(handles.DataMode_rbtn,'Value',1)
% 
% % Hint: get(hObject,'Value') returns toggle state of DataMode_rbtn



% function DataParentFolder_etxt_Callback(hObject, eventdata, handles)
% % hObject    handle to DataParentFolder_etxt (see GCBO)
% % eventdata  reserved - to be defined in a future version of MATLAB
% % handles    structure with handles and user data (see GUIDATA)
% 
% % Hints: get(hObject,'String') returns contents of DataParentFolder_etxt as text
% %        str2double(get(hObject,'String')) returns contents of DataParentFolder_etxt as a double


% % --- Executes during object creation, after setting all properties.
% function DataParentFolder_etxt_CreateFcn(hObject, eventdata, handles)
% % hObject    handle to DataParentFolder_etxt (see GCBO)
% % eventdata  reserved - to be defined in a future version of MATLAB
% % handles    empty - handles not created until after all CreateFcns called
% 
% % Hint: edit controls usually have a white background on Windows.
% %       See ISPC and COMPUTER.
% if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
%     set(hObject,'BackgroundColor','white');
% end



% function DataRunNum_etxt_Callback(hObject, eventdata, handles)
% % hObject    handle to DataRunNum_etxt (see GCBO)
% % eventdata  reserved - to be defined in a future version of MATLAB
% % handles    structure with handles and user data (see GUIDATA)
% 
% % Hints: get(hObject,'String') returns contents of DataRunNum_etxt as text
% %        str2double(get(hObject,'String')) returns contents of DataRunNum_etxt as a double


% % --- Executes during object creation, after setting all properties.
% function DataRunNum_etxt_CreateFcn(hObject, eventdata, handles)
% % hObject    handle to DataRunNum_etxt (see GCBO)
% % eventdata  reserved - to be defined in a future version of MATLAB
% % handles    empty - handles not created until after all CreateFcns called
% 
% % Hint: edit controls usually have a white background on Windows.
% %       See ISPC and COMPUTER.
% if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
%     set(hObject,'BackgroundColor','white');
% end


% % --- Executes on button press in Reset_btn.
% function Reset_btn_Callback(hObject, eventdata, handles)
% % hObject    handle to Reset_btn (see GCBO)
% % eventdata  reserved - to be defined in a future version of MATLAB
% % handles    structure with handles and user data (see GUIDATA)
% reset_question = questdlg('Reset data run history?','Reset data run...','Yes','No','No');
% switch reset_question
%     case 'Yes'
%         for n=1:26
%             set(handles.(['RunFile' num2str(n)]),'userdata',1,'backgroundcolor','green')
%         end
%     case 'No'
% end

% --- Executes on button press in AutoLoad_btn.
function AutoLoad_btn_Callback(hObject, eventdata, handles)
% hObject    handle to AutoLoad_btn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
cd(fileparts(mfilename('fullpath')))
setFolder = uigetdir(pwd);
if setFolder ~= 0
    cd(setFolder);
    Files = dir('GUIRun_*.m');
    numFiles = size(Files,1);
    for n = 1:numFiles
        setFile = Files(n);
        justname = strrep(setFile.name,'.m','');
        justname = strrep(justname,'GUIRun_','');
        justname = strrep(justname,'xo','.');
        justname = strrep(justname,'xn','-');
        if strcmp(justname,'VOID_0')
            bslash = find(setFolder=='\');
            justname = setFolder(bslash((end-1)):end-1);
        end
        assignedFile = {setFile.name setFolder};
        set(handles.(['FileName' num2str(n)]),'String',justname,'userdata',assignedFile)
        set(handles.(['RunFile' num2str(n)]),'enable','on')
        
        status_cells = get(handles.Status_txt,'userdata');
        status_cells{n} = justname;
        set(handles.Status_txt,'userdata',status_cells)
    end
end


% --- Executes on key press with focus on mainfigure and none of its controls.
function mainfigure_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to mainfigure (see GCBO)
% eventdata  structure with the following fields (see FIGURE)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)
ctrl = 0;
for i=1:length(eventdata.Modifier)
    switch(eventdata.Modifier{i})
        case 'control'
            ctrl = 1;
    end
end

if (ctrl == 1 && strcmp(eventdata.Key,'s'))
    SaveProfile_btn_Callback(hObject,[],handles)
end
if (ctrl == 1 && strcmp(eventdata.Key,'l'))
    LoadProfile_btn_Callback(hObject,[],handles)
end

if (ctrl == 1 && strcmp(eventdata.Key,'1'))
    RunButtons(hObject,[],handles,1)
end
if (ctrl == 1 && strcmp(eventdata.Key,'2'))
    RunButtons(hObject,[],handles,2)
end
if (ctrl == 1 && strcmp(eventdata.Key,'3'))
    RunButtons(hObject,[],handles,3)
end
if (ctrl == 1 && strcmp(eventdata.Key,'4'))
    RunButtons(hObject,[],handles,4)
end
if (ctrl == 1 && strcmp(eventdata.Key,'5'))
    RunButtons(hObject,[],handles,5)
end
if (ctrl == 1 && strcmp(eventdata.Key,'6'))
    RunButtons(hObject,[],handles,6)
end
if (ctrl == 1 && strcmp(eventdata.Key,'7'))
    RunButtons(hObject,[],handles,7)
end
if (ctrl == 1 && strcmp(eventdata.Key,'8'))
    RunButtons(hObject,[],handles,8)
end
if (ctrl == 1 && strcmp(eventdata.Key,'9'))
    RunButtons(hObject,[],handles,9)
end
if strcmp(eventdata.Key,'escape')
    RunStop_btn_Callback(hObject,[],handles)
end


% --- Executes on button press in DataCustomName_cbox.
function DataCustomName_cbox_Callback(hObject, eventdata, handles)
% hObject    handle to DataCustomName_cbox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
switch get(handles.DataCustomName_cbox,'Value')
    case 1
        set(handles.DataCustomName_etxt,'Enable','On')
    case 0
        set(handles.DataCustomName_etxt,'Enable','Off')
end

% Hint: get(hObject,'Value') returns toggle state of DataCustomName_cbox

function DataCustomName_etxt_Callback(hObject, eventdata, handles)
% hObject    handle to DataCustomName_etxt (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of DataCustomName_etxt as text
%        str2double(get(hObject,'String')) returns contents of DataCustomName_etxt as a double


% --- Executes during object creation, after setting all properties.
function DataCustomName_etxt_CreateFcn(hObject, eventdata, handles)
% hObject    handle to DataCustomName_etxt (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function NumOfRuns1_Callback(hObject, eventdata, handles)
% hObject    handle to NumOfRuns1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of NumOfRuns1 as text
%        str2double(get(hObject,'String')) returns contents of NumOfRuns1 as a double


% --- Executes during object creation, after setting all properties.
function NumOfRuns1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to NumOfRuns1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function NumOfRuns2_Callback(hObject, eventdata, handles)
% hObject    handle to NumOfRuns2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of NumOfRuns2 as text
%        str2double(get(hObject,'String')) returns contents of NumOfRuns2 as a double


% --- Executes during object creation, after setting all properties.
function NumOfRuns2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to NumOfRuns2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function NumOfRuns3_Callback(hObject, eventdata, handles)
% hObject    handle to NumOfRuns3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of NumOfRuns3 as text
%        str2double(get(hObject,'String')) returns contents of NumOfRuns3 as a double


% --- Executes during object creation, after setting all properties.
function NumOfRuns3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to NumOfRuns3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function NumOfRuns4_Callback(hObject, eventdata, handles)
% hObject    handle to NumOfRuns4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of NumOfRuns4 as text
%        str2double(get(hObject,'String')) returns contents of NumOfRuns4 as a double


% --- Executes during object creation, after setting all properties.
function NumOfRuns4_CreateFcn(hObject, eventdata, handles)
% hObject    handle to NumOfRuns4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function NumOfRuns5_Callback(hObject, eventdata, handles)
% hObject    handle to NumOfRuns5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of NumOfRuns5 as text
%        str2double(get(hObject,'String')) returns contents of NumOfRuns5 as a double


% --- Executes during object creation, after setting all properties.
function NumOfRuns5_CreateFcn(hObject, eventdata, handles)
% hObject    handle to NumOfRuns5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function NumOfRuns6_Callback(hObject, eventdata, handles)
% hObject    handle to NumOfRuns6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of NumOfRuns6 as text
%        str2double(get(hObject,'String')) returns contents of NumOfRuns6 as a double


% --- Executes during object creation, after setting all properties.
function NumOfRuns6_CreateFcn(hObject, eventdata, handles)
% hObject    handle to NumOfRuns6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function NumOfRuns7_Callback(hObject, eventdata, handles)
% hObject    handle to NumOfRuns7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of NumOfRuns7 as text
%        str2double(get(hObject,'String')) returns contents of NumOfRuns7 as a double


% --- Executes during object creation, after setting all properties.
function NumOfRuns7_CreateFcn(hObject, eventdata, handles)
% hObject    handle to NumOfRuns7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function NumOfRuns8_Callback(hObject, eventdata, handles)
% hObject    handle to NumOfRuns8 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of NumOfRuns8 as text
%        str2double(get(hObject,'String')) returns contents of NumOfRuns8 as a double


% --- Executes during object creation, after setting all properties.
function NumOfRuns8_CreateFcn(hObject, eventdata, handles)
% hObject    handle to NumOfRuns8 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function NumOfRuns9_Callback(hObject, eventdata, handles)
% hObject    handle to NumOfRuns9 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of NumOfRuns9 as text
%        str2double(get(hObject,'String')) returns contents of NumOfRuns9 as a double


% --- Executes during object creation, after setting all properties.
function NumOfRuns9_CreateFcn(hObject, eventdata, handles)
% hObject    handle to NumOfRuns9 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function NumOfRuns10_Callback(hObject, eventdata, handles)
% hObject    handle to NumOfRuns10 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of NumOfRuns10 as text
%        str2double(get(hObject,'String')) returns contents of NumOfRuns10 as a double


% --- Executes during object creation, after setting all properties.
function NumOfRuns10_CreateFcn(hObject, eventdata, handles)
% hObject    handle to NumOfRuns10 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function NumOfRuns11_Callback(hObject, eventdata, handles)
% hObject    handle to NumOfRuns11 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of NumOfRuns11 as text
%        str2double(get(hObject,'String')) returns contents of NumOfRuns11 as a double


% --- Executes during object creation, after setting all properties.
function NumOfRuns11_CreateFcn(hObject, eventdata, handles)
% hObject    handle to NumOfRuns11 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function NumOfRuns12_Callback(hObject, eventdata, handles)
% hObject    handle to NumOfRuns12 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of NumOfRuns12 as text
%        str2double(get(hObject,'String')) returns contents of NumOfRuns12 as a double


% --- Executes during object creation, after setting all properties.
function NumOfRuns12_CreateFcn(hObject, eventdata, handles)
% hObject    handle to NumOfRuns12 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function NumOfRuns13_Callback(hObject, eventdata, handles)
% hObject    handle to NumOfRuns13 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of NumOfRuns13 as text
%        str2double(get(hObject,'String')) returns contents of NumOfRuns13 as a double


% --- Executes during object creation, after setting all properties.
function NumOfRuns13_CreateFcn(hObject, eventdata, handles)
% hObject    handle to NumOfRuns13 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function NumOfRuns14_Callback(hObject, eventdata, handles)
% hObject    handle to NumOfRuns14 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of NumOfRuns14 as text
%        str2double(get(hObject,'String')) returns contents of NumOfRuns14 as a double


% --- Executes during object creation, after setting all properties.
function NumOfRuns14_CreateFcn(hObject, eventdata, handles)
% hObject    handle to NumOfRuns14 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function NumOfRuns15_Callback(hObject, eventdata, handles)
% hObject    handle to NumOfRuns15 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of NumOfRuns15 as text
%        str2double(get(hObject,'String')) returns contents of NumOfRuns15 as a double


% --- Executes during object creation, after setting all properties.
function NumOfRuns15_CreateFcn(hObject, eventdata, handles)
% hObject    handle to NumOfRuns15 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function NumOfRuns16_Callback(hObject, eventdata, handles)
% hObject    handle to NumOfRuns16 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of NumOfRuns16 as text
%        str2double(get(hObject,'String')) returns contents of NumOfRuns16 as a double


% --- Executes during object creation, after setting all properties.
function NumOfRuns16_CreateFcn(hObject, eventdata, handles)
% hObject    handle to NumOfRuns16 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function NumOfRuns17_Callback(hObject, eventdata, handles)
% hObject    handle to NumOfRuns17 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of NumOfRuns17 as text
%        str2double(get(hObject,'String')) returns contents of NumOfRuns17 as a double


% --- Executes during object creation, after setting all properties.
function NumOfRuns17_CreateFcn(hObject, eventdata, handles)
% hObject    handle to NumOfRuns17 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function NumOfRuns18_Callback(hObject, eventdata, handles)
% hObject    handle to NumOfRuns18 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of NumOfRuns18 as text
%        str2double(get(hObject,'String')) returns contents of NumOfRuns18 as a double


% --- Executes during object creation, after setting all properties.
function NumOfRuns18_CreateFcn(hObject, eventdata, handles)
% hObject    handle to NumOfRuns18 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function NumOfRuns19_Callback(hObject, eventdata, handles)
% hObject    handle to NumOfRuns19 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of NumOfRuns19 as text
%        str2double(get(hObject,'String')) returns contents of NumOfRuns19 as a double


% --- Executes during object creation, after setting all properties.
function NumOfRuns19_CreateFcn(hObject, eventdata, handles)
% hObject    handle to NumOfRuns19 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function NumOfRuns20_Callback(hObject, eventdata, handles)
% hObject    handle to NumOfRuns20 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of NumOfRuns20 as text
%        str2double(get(hObject,'String')) returns contents of NumOfRuns20 as a double


% --- Executes during object creation, after setting all properties.
function NumOfRuns20_CreateFcn(hObject, eventdata, handles)
% hObject    handle to NumOfRuns20 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function NumOfRuns21_Callback(hObject, eventdata, handles)
% hObject    handle to NumOfRuns21 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of NumOfRuns21 as text
%        str2double(get(hObject,'String')) returns contents of NumOfRuns21 as a double


% --- Executes during object creation, after setting all properties.
function NumOfRuns21_CreateFcn(hObject, eventdata, handles)
% hObject    handle to NumOfRuns21 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function NumOfRuns22_Callback(hObject, eventdata, handles)
% hObject    handle to NumOfRuns22 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of NumOfRuns22 as text
%        str2double(get(hObject,'String')) returns contents of NumOfRuns22 as a double


% --- Executes during object creation, after setting all properties.
function NumOfRuns22_CreateFcn(hObject, eventdata, handles)
% hObject    handle to NumOfRuns22 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function NumOfRuns23_Callback(hObject, eventdata, handles)
% hObject    handle to NumOfRuns23 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of NumOfRuns23 as text
%        str2double(get(hObject,'String')) returns contents of NumOfRuns23 as a double


% --- Executes during object creation, after setting all properties.
function NumOfRuns23_CreateFcn(hObject, eventdata, handles)
% hObject    handle to NumOfRuns23 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function NumOfRuns24_Callback(hObject, eventdata, handles)
% hObject    handle to NumOfRuns24 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of NumOfRuns24 as text
%        str2double(get(hObject,'String')) returns contents of NumOfRuns24 as a double


% --- Executes during object creation, after setting all properties.
function NumOfRuns24_CreateFcn(hObject, eventdata, handles)
% hObject    handle to NumOfRuns24 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function NumOfRuns25_Callback(hObject, eventdata, handles)
% hObject    handle to NumOfRuns25 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of NumOfRuns25 as text
%        str2double(get(hObject,'String')) returns contents of NumOfRuns25 as a double


% --- Executes during object creation, after setting all properties.
function NumOfRuns25_CreateFcn(hObject, eventdata, handles)
% hObject    handle to NumOfRuns25 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function NumOfRuns26_Callback(hObject, eventdata, handles)
% hObject    handle to NumOfRuns26 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of NumOfRuns26 as text
%        str2double(get(hObject,'String')) returns contents of NumOfRuns26 as a double


% --- Executes during object creation, after setting all properties.
function NumOfRuns26_CreateFcn(hObject, eventdata, handles)
% hObject    handle to NumOfRuns26 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in hardstop_btn.
function hardstop_btn_Callback(hObject, eventdata, handles)
% hObject    handle to hardstop_btn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set(handles.hardstop_btn,'userdata',1)
set(handles.runall_btn,'userdata',1)
set(handles.randrunall_btn,'userdata',1)


% --- Executes on button press in loadlibrary_btn.
function loadlibrary_btn_Callback(hObject, eventdata, handles)
% hObject    handle to loadlibrary_btn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
run([fileparts(mfilename('fullpath')) '\Functions\LoadLibrary'])


% --- Executes on button press in cleardds_btn.
function cleardds_btn_Callback(hObject, eventdata, handles)
% hObject    handle to cleardds_btn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
run([fileparts(mfilename('fullpath')) '\Functions\resetArdDDS'])


<<<<<<< HEAD
% --- Executes on button press in runall_btn.
function runall_btn_Callback(hObject, eventdata, handles)
% hObject    handle to runall_btn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set(handles.RunStop_btn,'userdata',0) % make sure stop trigger is 0 when 'Run' is selected
set(handles.hardstop_btn,'userdata',0)
set(handles.runall_btn,'userdata',0)
for i=1:str2num(get(handles.runall_etxt,'String'))
    for j = 1:26
        if get(handles.RunStop_btn,'userdata') || get(handles.hardstop_btn,'userdata') || get(handles.runall_btn,'userdata')
            break
        end
        ControllerGUI('RunButtons',hObject,eventdata,guidata(hObject),j)
    end
    if get(handles.RunStop_btn,'userdata') || get(handles.hardstop_btn,'userdata') || get(handles.runall_btn,'userdata')
        break
    end
end

% --- Executes on button press in randrunall_btn.
function randrunall_btn_Callback(hObject, eventdata, handles)
% hObject    handle to randrunall_btn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set(handles.RunStop_btn,'userdata',0) % make sure stop trigger is 0 when 'Run' is selected
set(handles.hardstop_btn,'userdata',0)
set(handles.randrunall_btn,'userdata',0)
for i=1:str2num(get(handles.runall_etxt,'String'))
    runorder = randperm(26);
    for j = 1:26
        if get(handles.RunStop_btn,'userdata') || get(handles.hardstop_btn,'userdata') || get(handles.randrunall_btn,'userdata')
            break
        end
        ControllerGUI('RunButtons',hObject,eventdata,guidata(hObject),runorder(j))
    end
    if get(handles.RunStop_btn,'userdata') || get(handles.hardstop_btn,'userdata') || get(handles.randrunall_btn,'userdata')
        break
    end
end


function runall_etxt_Callback(hObject, eventdata, handles)
% hObject    handle to runall_etxt (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of runall_etxt as text
%        str2double(get(hObject,'String')) returns contents of runall_etxt as a double


% --- Executes during object creation, after setting all properties.
function runall_etxt_CreateFcn(hObject, eventdata, handles)
% hObject    handle to runall_etxt (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
=======
% --- Executes on button press in randomrun_btn.
function randomrun_btn_Callback(hObject, eventdata, handles)
% hObject    handle to randomrun_btn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
runorder = randperm(26);
for i = 1:26
    ControllerGUI('RunButtons',hObject,eventdata,guidata(hObject),runorder(i))
>>>>>>> 4a1ccf7d7d3baea4d17d5e8ef44e2dbe07aa1f63
end
