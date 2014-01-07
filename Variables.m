ms = 1e-3;
us = 1e-6;

MHz=1e6;

% TOFs = [3 5 7 9 11 13 15 17]*1*ms;
% TOFs = 1*ms*linspace(5,15,10);
TOFs =[2]*ms;
% TOFs =[5 7 9]*ms;
numTOFs = length(TOFs);
NumOfTOF = length(TOFs);

% dt = 100*us; %sec, .1ms time step
dt = 100e-6;
M = 53; %Number of columns in the sequence
SAMPLE_RATE = 1/dt; %Hz, 10 kHz sample rate

%% Sequence logics
SUBDOP =1;
OPTPUMP =1;
HYBRID =1;
RFEVAP =1;
DIPOLE =1;
OPTEVAP =0;
MOVEDIPOLE =1; % imaging line 2 = round trip
MACROCAPTURE =1;
MACROCOMPRESS =0;
MICROCAPTURE =0;

SIGPLUS = 1;
SIGMINUS = 0;

ODTIMAGE = 0;

DIGILOCK = 0; %Use TTL to control Beat Note Lock

%% Current Calibrations

ProdXCal = -0.479; %Vset / A
ProdYCal = -0.479; %Vset / A
ProdZCal = -1.0/6.0; %Vset / A

MacroBiasCal = 5.6; %A/Vset
MacroCentralCal = -38.59; %A/Vset %Stanford
MacroAxialCal = -10; %A/Vset
MagXCal = 0.5;
MagYCal = 5.6;
MagZCal = 0.5;
MacroDimpleCal = 0.4; %A/Vset
CompCoilCal = -44.04;

CentralMicroCal = 0.4; %A/Vset
ArmsMicroCal = 0.4; %A/Vset
DimpleMicroCal = 0.4;

%% For Imaging
IMAGING =4; %Imaging line switch; 2 is along x axis in octagon, 3 odt axis, 4 is horizontal in Magellan
switch IMAGING
    case 4
        disp('Imaging in Magellan')
%         ImageFreq = 64.91e6; %
%         ImageFreq = linspace(64.88e6,64.98e6,10);
%           ImageFreq = [64.88e6,64.90e6,64.92e6];
%          ImageFreq = 64.92e6; %test
        ImageFreq = 64.89e6; %best
%         ImagingVVA =2;
         ImagingVVA =1.6;

        if MACROCOMPRESS
            XBias = 0;
            YBias = 0;
            ZBias = 0;
            MacroImgBias = 2/ MacroBiasCal;
        else
            XBias = 0;
            YBias = .7143;
            ZBias = 0;
            MacroImgBias = 0 / MacroBiasCal;

        end
%         magOnTime = .3*ms; %best
        magOnTime = .3*ms; %test
        
        CameraLine = 'MagellanCameraTrigger';
    case 2
        disp('Imaging in Octagon')
%         ImageFreq= 64.95e6; % 5 MHz detuned? Yes
        ImageDetuning =0*MHz;
        ImageFreq= 64.90e6 + .01*ImageDetuning; %best
%         ImageFreq = linspace(64.86e6,64.96e6,10);
%             ImageFreq= 64.94e6; %test
%         ImagingVVA =2; 
        ImagingVVA = 6;
%         XBias =-.4;
%         YBias =0;
%         ZBias = 0;
%         XBias =0;
%         XBias = [-0.7 -0.6 -0.5 -0.4, -0.3, -0.2];

          %normal as of 11/17/13
        XBias = -0.4;
        YBias =0;
        ZBias = 0;  

%         XBias = 2.5 * ProdXCal; %A
%         YBias = 2.0 * ProdYCal; %A
%         ZBias = 0 * ProdZCal; %A
        
        % Zero Fields
%         XBias = 0;
%         YBias = 0;
%         ZBias = 0;
        
        MacroImgBias = 0 / MacroBiasCal;
        magOnTime = 1*ms; %test
        
        CameraLine = 'CameraTrigger';
    case 3
        disp('ODT Imaging')
        ImageFreq = 64.94e6;
%         ImageFreq = 64.9e6;
        ImagingVVA = 7;
        XBias = 1; %-.21
        YBias = 0; %-.21
        ZBias = 0; %-.8
        
        magOnTime = .3*ms; %best
        MacroImgBias = 0 / MacroBiasCal;
        
        CameraLine = 'MagellanCameraTrigger';
end

if isempty(ImageFreq)
    disp('You forgot to set your ImageFreq');
end

cameraPulse = .5*ms;

ImageSweepTime = 2*ms; %sec, time to sweep
% ImageSweepTime = .2*ms; %sec, time to sweep
ImOnTime = 5*ms; %sec, lead time for opening imaging shutter
CamShutterTime = 1*ms; %sec, Shutter time set in camera configuration
% ExposeTime = 10*ms; %Time to leave Img AOM on test
ExposeTime = .2*ms; %Time to leave Img AOM on
DummyTime = 195*ms;%sec, cleaning image time before end of MOT load
% WaitTime = .5; %sec (Frame Rate of camera suggests this could be as low as 140 ms) %Best
WaitTime = .2; %sec (Frame Rate of camera suggests this could be as low as 140 ms) %Test
% REPUMPTIME = .1*ms; %Best
REPUMPTIME = .3*ms;
ImgRepumpVVA =10; %best
% ImgRepumpVVA =0; %best

ImagingTime = 2*WaitTime + 100*ms;
%% For LoadMOT
% QuadSet = -.2; %best
QuadSet = -.2; %test
% QuadSet = linspace(-0.2,-0.1,5);
% test (normal as of 8/22/13)
% XLoad = linspace(0,10,11);

%normal as of 11/17/13; voltage, not current
XLoad = 0;
YLoad =0;
ZLoad =-0.3;

% XLoad = 0 * ProdXCal; %A
% YLoad = [0,1,2,3] * ProdYCal; %A
% ZLoad = 0 * ProdZCal; %A

% Zero Fields
% XLoad = 0;
% YLoad = 0;
% ZLoad = 0;

% BiasCurrent = [0,0.3, 0.6, 0.9, 1.2];
% BiasCurrent = 0.0;

% ZLoad = 0 * ProdZCal;

% best
% XLoad = 0;
% YLoad = -.5;
% ZLoad = -.3;

UniblitzTime = 0; %sec, extra time at start to open uniblitz
% LoadTime =3; %sec
% LoadTime = linspace(1,7,7);
LoadTime = 7; %sec
MOTFreq = 64.35e6; %best
% MOTFreq = 64.33e6; %test
% MOTFreq = linspace(64.30e6,64.40e6,11);
% MOTRVVALoadMOT = 10;
% MOTRVVALoadMOT = linspace(0,5,6);
MOTRVVALoadMOT = 10;

MOTQuadOffDelay = 1*ms; %time for the MOT coils to shut off.

MOTTime = UniblitzTime + LoadTime;

%% For SubDoppler Cooling
% CoolTime =19*ms; % Best
% SubDopSweepTime = 19*ms; %Best
CoolTime =19*ms; % test
SubDopSweepTime = CoolTime; %test
% MOTRVVASub = 6; %Best2
MOTRVVASub = 2; %test
% SubDopFreq = 65.8e6;
% MC laser for subdopler cooling (LIN)
SubDopFreq = 65.5e6; % Best
% SubDopFreq = 65.8e6; % test

% %Best
% ZeroXBias =0
% ZeroYBias =-.1;
% ZeroZBias =0;

%Test
ZeroXBias =0;
ZeroYBias =-0.1;
ZeroZBias =0;

%% Optical Pumping
pumpFreq = 65.93e6; %Test
% pumpFreq = 65.90e6; %Best
% pumpFreq = linspace(65.8e6,66e6,21);
% pumpFreq = 65.35e6; %Works
% pumpFreq = 66.45e6; %Works
% PumpSweepTime = 1*ms; %Test
PumpSweepTime = .1*ms; %Best
MINUSREPUMPTIME = 1*ms; 
% pumpVVA =3; %Best
pumpVVA=2.15; %test

% MOTRVVApump = 10; %Best

% pumpVVA = 0;
MOTRVVApump = 3;
QuadPump = 0;

if SIGPLUS
%     pumpTime = 2*ms; 
    pumpTime = 1.5*ms; 
%     pumpTime = 3*ms; %  Best
    XPump = 0;
    YPump = -.3;
    ZPump = -2;
%Best
%     XPump = 0;
%     YPump =-.3;
%     ZPump = -2;
end
if SIGMINUS
    pumpTime = 3*ms;
%     XPump = 0;
%     YPump = 0;
%     ZPump = 0;
    XPump = -2;
    YPump = -1;
    ZPump = -2;
end

%% ODT Servo Calibration
%These parameters are associated with the linear fit between Vset and 
%ODT power. These values are only good when the IPG is set to output 10 W.
% P_out (W) = m * V_set (V) + b
ODT_Servo_m = 2.5; %W/V, slope
ODT_Servo_b = -2.06; %W , y-intercept
ODT_Servo_max = 7.25; %W, linearity is poor past this power.

%% For Reloading
ReLoadTime = 200*ms;
ReLoadMag = -.45;

%% Hybrid trap transfer
HybridSweepTime =.3; %seconds, tEST
% HybridSweepTime =.1; %seconds, tEST
% HybridSweepTime =2; %seconds, Best
% HybridTrapHoldTime =[2,4,6,8,10,14,18,22];
HybridTrapHoldTime = 1*ms;
StartODTPwr = 0;
MaxODTPwr = 10; %best
% MaxODTPwr = 5; %test

if SIGMINUS
    PURIFYGRAD = -.4; %Best
%     PURIFYOFFSET = 4e-3; %Best for PURIFYGRAD = -.4
    PURIFYOFFSET = 6e-3; %Best for PURIFYGRAD = -.4
    PURIFYERFTIME = .015; %Best for PURIFYGRAD = -.4;
    PURIFYTIME = .5; %Best
    HybridStartBGrad = PURIFYGRAD;
    HybridMaxBGrad = -1.8;  %Best     
    
    XHybrid = 0;
    YHybrid = 0;
    ZHybrid = -1.5;
    
    XHybridMax = 0;
    YHybridMax = -.2;
    ZHybridMax = -3;
end
if SIGPLUS
    PURIFYGRAD = -.2; %Best
%     PURIFYGRAD = -.105;
    PURIFYOFFSET = 6e-3; %Best for PURIFYGRAD = -.2
    PURIFYERFTIME = .015; %Best for PURIFYGRAD = -.2;
    PURIFYTIME = .5; %Best
%     PURIFYTIME = 2; %Test
    
    
    %%TEST
%     PURIFYGRAD = -.15; %Test
%     PURIFYOFFSET = 6e-3; %Test for PURIFYGRAD = -.4
%     PURIFYERFTIME = .015; %Test for PURIFYGRAD = -.4;
%     PURIFYTIME = .5; %Test
    
    
    HybridStartBGrad = PURIFYGRAD;
    HybridMaxBGrad = -1.8;  %best
%     HybridMaxBGrad = -0.2;
%     HybridMaxBGrad = PURIFYGRAD - .01;  %test
    
% % %Best
%     XHybrid = 0;
%     YHybrid = -0.5;
%     ZHybrid = -.2;


% % % 12/22/13
%     XHybrid =-1.75;
%     YHybrid =-1.2;
%     ZHybrid = -.8;

    XHybrid =-1.75;
    YHybrid =-1.2;
    ZHybrid = -.8;

       %%Best
%     XHybridMax = -1;
%     YHybridMax = -.2;
%     ZHybridMax = -3;
%     
       %%Test
    XHybridMax =-1;
    YHybridMax = -.5;
    ZHybridMax = -3;
 
%     XHybridMax = XHybrid;
%     YHybridMax = YHybrid;
%     ZHybridMax = ZHybrid;

end                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                               ; %best
HybridTime = PURIFYERFTIME-PURIFYOFFSET+HybridSweepTime+ PURIFYTIME + HybridTrapHoldTime;
%% Hybrid RF Evaporation
HybridHoldTime =0; 
HybridRampEndB = 0;
% HybridEvapRampTime = 20e-3;
ZRampEndB = 0;
% RFVVASet =0;
RFVVASet =3.5;
RF_PWR = -8; %test;
% RF_PWR = -40; % shutoff RF
% disp('RF OFF in Parameters')

XRFEvap = XHybridMax;
YRFEvap = YHybridMax;
ZRFEvap = ZHybridMax;

if SIGPLUS
%     Evap1HighFreq =35*MHz; %Hz, best
%     Evap1LowFreq =8*MHz; %Hz, best
%     RampRate = 5e6; %Hz^2 best
    Evap1HighFreq =35e6; %Hz, test
    Evap1LowFreq = 8e6; %Hz, test
    RampRate =5e6; %Hz^2 test

    Evap1SweepTime = (Evap1HighFreq-Evap1LowFreq)/RampRate;
    
    TwoSlopeEvap =0;
    Evap3HighFreq = Evap1LowFreq+.001*MHz;
    Evap3LowFreq = 3.75e6;
    RampRate3 = 1e6;
    Evap3SweepTime = (Evap3HighFreq-Evap3LowFreq)/RampRate3;

    ThreeSlopeEvap = 0;
    Evap4HighFreq = Evap3LowFreq;
    Evap4LowFreq = 6e6;
    RampRate4 = 3e6;
    Evap4SweepTime = (Evap4HighFreq-Evap4LowFreq)/RampRate4;
end
if SIGMINUS
    Evap1HighFreq =35e6; %Hz, best
    Evap1LowFreq = 9e6; %Hz, test
    RampRate = 2.25e6; %Hz^2 best
    Evap1SweepTime = (Evap1HighFreq-Evap1LowFreq)/RampRate;

    TwoSlopeEvap =0;
    Evap3HighFreq = Evap1LowFreq;
    Evap3LowFreq = 20e6;
    RampRate3 = 12e6;
    Evap3SweepTime = (Evap3HighFreq-Evap3LowFreq)/RampRate3;

    ThreeSlopeEvap = 0;
    Evap4HighFreq = Evap3LowFreq;
    Evap4LowFreq = 6e6;
    RampRate4 = 3e6;
    Evap4SweepTime = (Evap4HighFreq-Evap4LowFreq)/RampRate4;
end

if ThreeSlopeEvap
    HybridEvapTime = Evap1SweepTime +Evap3SweepTime +Evap4SweepTime + HybridHoldTime;
elseif TwoSlopeEvap
    HybridEvapTime = Evap1SweepTime +Evap3SweepTime + HybridHoldTime;
else
    HybridEvapTime = Evap1SweepTime+HybridHoldTime+100e-6;
end



%% Transfer to Dipole Trap

DipoleStartBGrad = HybridMaxBGrad;

if SIGMINUS
    DipoleEndBGrad = -.2; %Best
    DipoleBSweepTime = 2; %Best
    DipoleLoadHoldTime =0*ms;
    DipoleBOffSweep = 100e-3;
    Evap2SweepTime = DipoleBSweepTime; %seconds, test
    
    ByRates = 0;
    if ThreeSlopeEvap
        Evap2HighFreq = Evap4LowFreq; %Hz
        Evap2LowFreq =Evap4LowFreq-1e6; %Hz
%         Evap2LowFreq =Evap4LowFreq-.1e6; %Hz
    elseif TwoSlopeEvap
        Evap2HighFreq = Evap3LowFreq; %Hz
        Evap2LowFreq =Evap3LowFreq-1e6; %Hz
    else
        Evap2HighFreq = Evap1LowFreq; %Hz
        Evap2LowFreq =Evap1LowFreq-1e6; %Hz
    end
        
    if ByRates
        XDipole = 0; 
        YDipole = 0; 
        ZDipole = -1;
    else
        XDipole = 0; 
        YDipole = 0; 
        ZDipole = -1;
    end
    XSweepRate = 5;
    YSweepRate = 5;
    ZSweepRate = 5; 

    DipoleBiasSweep = 1;
end

% ODTHoldTime = [1*ms, 0];
% DipoleLoadHoldTime = 1*ms;

if SIGPLUS
    DipoleEndBGrad = -.05; %Best
%     DipoleEndBGrad = -.12; %Test
    DipoleBSweepTime = 2; %Best
%     DipoleBSweepTime = 2*.01; %Test
    Evap2SweepTime = DipoleBSweepTime-dt; %seconds
    DipoleLoadHoldTime =2001*ms; % why is this the default?
%     DipoleLoadHoldTime = [1*ms, 5, 10, 15, 20, 25, 30, 35, 40];
    
    DipoleBOffSweep = 100e-3; %Best
%     DipoleBOffSweep = 1e-3; %Test
%     DipoleParaFreq =linspace(2500,3500,20);
    DipoleParaFreq =800;
    DipoleParaAmp = 0;
    
    ByRates = 0;
    
    if ThreeSlopeEvap
        Evap2HighFreq = Evap4LowFreq; %Hz
        Evap2LowFreq =Evap4LowFreq-1e6; %Hz
    elseif TwoSlopeEvap
        Evap2HighFreq = Evap3LowFreq; %Hz
        Evap2LowFreq =Evap3LowFreq-1e6; %Hz
    else
        Evap2HighFreq = Evap1LowFreq; %Hz
%         Evap2LowFreq =Evap1LowFreq-4e6; %test
%         Evap2LowFreq =Evap1LowFreq-.1e6; %test
        Evap2LowFreq =Evap1LowFreq-1.75e6; %Hz %best
    end
    
    if ByRates
        XDipole = 0; 
        YDipole = 0; 
        ZDipole = -.8;
    else
        XDipole = 0; 
        YDipole = 0; 
        ZDipole = -.4;

%         XDipole = XRFEvap; 
%         YDipole = YRFEvap; 
%         ZDipole = -.575; %Overrrrrr riddern
    end
    XSweepRate = 5;
    YSweepRate = 5;
    ZSweepRate = 3; 
    
    %%Best for HybridGrad = -1.8 ZHybridMax = -3
    DipoleBiasSweepTimes = [0 .2625 .4375 .6125 .7875 1.05 1.1375 1.3125 1.4875 2];
    DipoleBiasSweepValues = -1*[3 2.3 2.1 1.8 1.5 1.2 .95 .675 .575 .575]; %Best

	%Test for HybridGrad = -1.8 ZHybridMax = -2.32
%     DipoleBiasSweepTimes = [0 .25 .5 .75 1 1.25 1.5 1.75 2];
%     DipoleBiasSweepValues = -1*[2.32 2.1 1.7 1.45 1.2 .975 .74 .51 .375];
%     ZDipoleTest = -.4;
%     DipoleBiasSweepValues = ZDipoleTest
    DipoleBiasSweep =1;  %UIUC Set
end

XStart = XRFEvap;
YStart = YRFEvap;
ZStart = ZRFEvap;

XEnd = XDipole;
YEnd = YDipole;
ZEnd = ZDipole;

XSweepStep = sign(XEnd-XStart)*XSweepRate * dt;
XSweep = [XStart:XSweepStep:XEnd];
YSweepStep = sign(YEnd-YStart)*YSweepRate * dt;
YSweep = [YStart:YSweepStep:YEnd];
ZSweepStep = sign(ZEnd-ZStart)*ZSweepRate * dt;
ZSweep = [ZStart:ZSweepStep:ZEnd];
maxVal = max([size(XSweep,2),size(YSweep,2),size(ZSweep,2)]);
if ByRates
    if maxVal > DipoleSweepTime
        DipoleTime = DipoleLoadHoldTime + maxVal;
    else
        DipoleTime = DipoleLoadHoldTime+DipoleBSweepTime;
    end
else
    DipoleTime = DipoleLoadHoldTime+DipoleBSweepTime+DipoleBOffSweep;
end

%% Optical Evaporation

XOptEvap =XDipole;
YOptEvap =YDipole;
ZOptEvap =ZDipole;

QuadSweepAlpha = 1;

OptEvapSweepTime =4; %Best
% OptEvapSweepTime =5; %Test

OptEvapStartBGrad = DipoleEndBGrad; % test
% OptEvapEndBGrad = -.06; %0.3 Tesla/m, Best
OptEvapEndBGrad = -.1; %Test
OptEvapStartPwr = MaxODTPwr; %Lin value
% OptEvapEndPwr = 2.3; %vary to control condensate fraction
OptEvapEndPwr = 3.0;

% HoldBGrad = -.1;
HoldBGrad = 0;
XOptEvapHold = 0;
YOptEvapHold = 0;
ZOptEvapHold = 0;
% XOptEvapHold =XOptEvap;
% YOptEvapHold =YOptEvap;
% ZOptEvapHold =ZOptEvap;

% MagHoldTime = .1*ms;
MagHoldTime = 1*ms;
MagSweepTime = 100*ms;

RECOMPRESSODT = 1;
RecompressTime = 1;
RecompressValue =5;

OptEvapSweepTimeTrunc = 4;
a2 = -(OptEvapEndPwr - OptEvapStartPwr)/(OptEvapSweepTimeTrunc^2);
a1 = -2*(OptEvapStartPwr - OptEvapEndPwr)/(OptEvapSweepTimeTrunc);
a0 = OptEvapStartPwr;

OptEvapODTVVAEnd = OptEvapSweepTime*a1 + OptEvapSweepTime^2*a2 + a0;

if RECOMPRESSODT
    OptEvapTime = OptEvapSweepTime + RecompressTime + MagHoldTime + MagSweepTime;
else
    OptEvapTime = OptEvapSweepTime + MagHoldTime + MagSweepTime;
end

%% Move Dipole
% MacroBiasCal = 5.6; %A/Vset
% MacroCentralCal = -38.59; %A/Vset %Stanford
% MacroAxialCal = -10; %A/Vset
% MagXCal = 0.5;
% MagYCal = 5.6;
% MagZCal = 0.5;
% MacroDimpleCal = 0.4; %A/Vset
% CompCoilCal = -44.04;
% 
% CentralMicroCal = 0.4; %A/Vset
% ArmsMicroCal = 0.4; %A/Vset
% DimpleMicroCal = 0.4;


% Best 2013-3-13
% pos = [148,463];
% spd = [200 200];
% acc = [150,75];

% Best 2013-8-11
% pos = [128,464];
% spd = [200, 200];
% acc = [150,75];

%%Best 2013-11-20
% pos = [133,466];
% spd = [200, 200];
% acc = [150,75];

pos = [134,466];
spd = [200, 200];
acc = [150,75];


% pos = [145,477];
% spd = [200, 200];
% acc = [150,75];
% pos = [145,486];
% spd = [200, 200];
% acc = [150,75];

MotionProfile = [pos;spd;acc];
speed1 = MotionProfile(2,2);
distance = abs(MotionProfile(1,1) - MotionProfile(1,2));
acc1 = MotionProfile(3,2);
speed2 = MotionProfile(2,1);
acc2 = MotionProfile(3,1);

MagXMoveDipole =0 / MagXCal;
CompCoilMoveDipole =0/CompCoilCal;

% MoveHoldTime =8; %test
MoveHoldTime =1; %best

MoveParaTime = 0;
ODTParaAmp = 0;
ODTParaFreq = 1050;
% ODTParaFreq = linspace(1400,2400,20);
% MoveHoldTime=linspace(0,300e-3,10);
TransitTime = (distance-(speed1^2/acc1))/speed1 + 2*speed1/acc1;

if IMAGING ~= 2
    MoveDipoleTime = MoveHoldTime + (distance-(speed1^2/acc1))/speed1 + 2*speed1/acc1;
else
    MoveDipoleTime = MoveHoldTime + (distance-(speed1^2/acc1))/speed1 + 2*speed1/acc1 + (distance-(speed2^2/acc2))/speed2 + 2*speed2/acc2;
%     MoveDipoleTime = MoveParaTime + MoveHoldTime + (distance-(speed1^2/acc1))/speed1 + 2*speed1/acc1 + (distance-(speed2^2/acc2))/speed2 + 2*speed2/acc2;

end

FinalMoveODT = 7;
MoveSweepTime = 0;
MoveSweep = [FinalMoveODT, MoveSweepTime];

%% Macro Wire Capture

% MacroRampTime = 35*ms; %sec %best prior 12/1/11
% ODTWaitTime = 0.1*ms; % Time after the start oframping macro wires that ODT starts ramping Best

% CompressUpRampTime=200*ms;
% CompressDownRampTime=10*ms;
% AxialMacRampTime=10*ms;
% ODTMacroTime=0;
% ODTWaitTime=CompressUpRampTime+max([CompressDownRampTime AxialMacRampTime])+ODTMacroTime;

MacroRampTime = 100*ms; %test
% MacroRampTime = 35*ms; %test
% MacroRampTime =500*ms; %best
ODTWaitTime = MacroRampTime;


% ODTWaitTime = 35*ms; % Time after the start oframping macro wires that ODT starts ramping Test
ODTRampTime = 40*ms; %ODT ramp time is now independent from macrowire  best
% ODTRampTime = 1*ms; %ODT ramp time is now independent from macrowire test



ODTEndVoltage = 0; %Best
MacCapHoldTime =1*ms; %sec 
MacCapODTDropTime = 0*ms; %se

% MacroParaAmp = 0.2 / MacroCentralCal;
MacroParaFreq = 10;
% MacroParaFreq = linspace(5,60,25);

MacroCaptureTime = max(MacroRampTime,(ODTRampTime + ODTWaitTime)) +MacCapHoldTime;

% Original Trap Trajectory
% BiasMacCap = 19.4; %Amperes
% CentralMacCap = 45;
% AxialMacCap = 3;
% XMacCap = 0;
% YMacCap = 25;
% ZMacCap = 0;

% % TRAP
% BiasMacCap = 0 / MacroBiasCal; %Amperes
% CentralMacCap = 19.4 / MacroCentralCal;
% AxialMacCap = 4 / MacroAxialCal;
% XMacCap =0 / MagXCal;
% YMacCap =45 / MagYCal;
% ZMacCap = 0 / MagZCal;
% DimpleMacroCap = 0;
% CompressMacCap = 0 / CompCoilCal;

% % Best Chipv1
% BiasMacCap = 0 / MacroBiasCal; %Amperes
% % CentralMacCap = 0 / MacroCentralCal; %For CentralMicroCap = -1.95
% % CentralMacCap =18 / MacroCentralCal; %For CentralMicroCap = -1
% CentralMacCap =19.7 / MacroCentralCal; %For CentralMicroCap = 0
% AxialMacCap = 4 / MacroAxialCal; %Best
% XMacCap =0 / MagXCal; %Best
% YMacCap = 45/ MagYCal; %No Bias Wire
% ZMacCap = 0 / MagZCal;
% DimpleMacroCap = 0/MacroDimpleCal;
% CompressMacCap = 0 / CompCoilCal;

% % BestChip v2
% BiasMacCap = 0 / MacroBiasCal; %Amperes
% % CentralMacCap = 20.5 / MacroCentralCal; %For CentralMicroCap = -2
% CentralMacCap =23.2 / MacroCentralCal; %For CentralMicroCap = 0 2
% % CentralMacCap =23 / MacroCentralCal; %For CentralMicroCap = 0 4
% AxialMacCap = 2 / MacroAxialCal; %Best
% XMacCap =0 / MagXCal; %Best
% YMacCap = 45/ MagYCal; %No Bias Wire
% ZMacCap = 0 / MagZCal;
% DimpleMacroCap = 0/MacroDimpleCal;
% CompressMacCap = 0 / CompCoilCal;

% Test
BiasMacCap = 4 / MacroBiasCal; %Amperes
% BiasMacCap =0 / MacroBiasCal; %Amperes
CentralMacCap = 26.35/ MacroCentralCal; %For CentralMicroCap = -2
% CentralMacCap =25.3 / MacroCentralCal; %For CentralMicroCap = 0 AxialMacCap = 2
% CentralMacCap =20.8 / MacroCentralCal; %For CentralMicroCap = 0 AxialMacCap = 4
% AxialMacCap = 2 / MacroAxialCal; %Best
AxialMacCap = 4 / MacroAxialCal;

XMacCap =0 / MagXCal; %Best
% XMacCap =5 / MagXCal; %Test
YMacCap = 42/ MagYCal; %No Bias Wire
ZMacCap = 0 / MagZCal;
DimpleMacroCap = 0/MacroDimpleCal;
CompressMacCap = 0 / CompCoilCal;

% BiasMacCap = 0 / MacroBiasCal; %Amperes
% CentralMacCap = 0 / MacroCentralCal;
% AxialMacCap =0 / MacroAxialCal;
% XMacCap =0 / MagXCal;
% YMacCap =0 / MagYCal;
% ZMacCap = 0 / MagZCal;
% DimpleMacroCap = 0;
% CompressMacCap = 50 / CompCoilCal;

%% Macro Wire Compress

%%Chip Test 6/9/2013
ArmsMacComp = 0;

% % Old Best w/o microwires
% % BiasMacComp = 0/ MacroBiasCal; %Amperes
% BiasMacComp = 40/ MacroBiasCal; %Amperes
% CentralMacComp = 35 / MacroCentralCal;
% % CentralMacComp = 45 / MacroCentralCal;
% % AxialMacComp = 0 / MacroAxialCal;
% % AxialMacComp = 35 / MacroAxialCal;
% AxialMacComp = 20 / MacroAxialCal;
% % XMacComp = 3 / MagXCal; %Best
% XMacComp = 0 / MagXCal; %Test
% % YMacComp = 35 / MagYCal; %Best
% YMacComp = YBias; %Test
% ZMacComp = 0 / MagZCal;
% 
% DimpleMacroComp =0/MacroDimpleCal;
% CompressMacroComp = 0;


% % Best w/o microwires
% BiasMacComp = 40/ MacroBiasCal; %Amperes
% CentralMacComp = 31 / MacroCentralCal;
% AxialMacComp =12 / MacroAxialCal;
% XMacComp = 3 / MagXCal; %Best
% YMacComp = YBias; %Test
% ZMacComp = 0 / MagZCal;
% 
% DimpleMacroComp =0/MacroDimpleCal;
% CompressMacroComp = 0;

% Best 10/22/2013
% BiasMacComp = 21/ MacroBiasCal; %Amperes
% CentralMacComp = 14 / MacroCentralCal;
% AxialMacComp =8 / MacroAxialCal;
% % AxialMacComp =20 / MacroAxialCal;
% % XMacComp = 4.9 / MagXCal; %Best
% XMacComp = 0/ MagXCal; %Test
% YMacComp = 0; %Test
% ZMacComp = 0 / MagZCal;
% 
% DimpleMacroComp =0/MacroDimpleCal;
% CompressMacroComp = 0;

% Test
% BiasMacComp = 23/ MacroBiasCal; %Amperes %Best
BiasMacComp = 27/ MacroBiasCal; %Amperes
CentralMacComp = 14 / MacroCentralCal; %best
% CentralMacComp = 9.5 / MacroCentralCal; %Test
AxialMacComp =8 / MacroAxialCal;
% AxialMacComp =16 / MacroAxialCal;
XMacComp =2.2 / MagXCal; %Best
% XMacComp =0 / MagXCal; %Best
YMacComp = 0; %Best
% YMacComp = 42/MagYCal; %Test
ZMacComp = 0 / MagZCal;

DimpleMacroComp =0/MacroDimpleCal;
CompressMacroComp = 0;

%Best w/ microwires
% BiasMacComp =0 / MacroBiasCal; %Amperes
% CentralMacComp = 0 / MacroCentralCal;
% % CentralMacComp = 10 / MacroCentralCal;
% % AxialMacComp = 12 / MacroAxialCal;
% AxialMacComp = 8 / MacroAxialCal;
% % AxialMacComp = 30 / MacroAxialCal;
% % XMacComp = 1 / MagXCal; %Best
% XMacComp = 3 / MagXCal; %Test
% % YMacComp = 35 / MagYCal; %Best
% YMacComp = 45 / MagYCal; %Test
% ZMacComp = 0 / MagZCal;
% 
% DimpleMacroComp =0/MacroDimpleCal;
% CompressMacroComp = 0;
% % to trap in 700ms
% BiasMacComp = 37.37; %Amperes
% CentralMacComp = 25.4;
% % AxialMacComp = 35;
% AxialMacComp = 40;
% XMacComp = 0;
% YMacComp = 7.5;
% ZMacComp = 0;

%Calculated close trap
% BiasMacComp = 44; %Amperes
% CentralMacComp = 17;
% AxialMacComp = 15;
% XMacComp = 0;
% YMacComp = 0;
% ZMacComp = 0;


% MacroCompRampTimeTemp = 400*ms;
MacroCompRampTime = 800*ms; %Test
% MacroCompRampTime = 800*ms; %Best
DimpleRampTime = 1*ms;
% MacroCompRampTime = MacroCompRampTimeTemp;
MacCompHoldTime =1*ms;

MacroCompRFHigh = 15e6;
MacroCompRFLow = 2.8e6;
MacroCompRFSweepTime = MacCompHoldTime-dt;
MacroCompRFVVA =0;

MacroCompRFVVAMax = 0;
MacroCompRFVVAMin = 0;
% 
% BiasMacComp  = BiasMacCap + (BiasMacComp-BiasMacCap) * (MacroCompRampTimeTemp/MacroCompRampTime);
% CentralMacComp  = CentralMacCap + (CentralMacComp-CentralMacCap) * (MacroCompRampTimeTemp/MacroCompRampTime);
% AxialMacComp  = AxialMacCap + (AxialMacComp-AxialMacCap) * (MacroCompRampTimeTemp/MacroCompRampTime);
% XMacComp  = XMacCap + (XMacComp-XMacCap) * (MacroCompRampTimeTemp/MacroCompRampTime);
% YMacComp  = YMacCap + (YMacComp-YMacCap) * (MacroCompRampTimeTemp/MacroCompRampTime);
% ZMacComp  = ZMacCap + (ZMacComp-ZMacCap) * (MacroCompRampTimeTemp/MacroCompRampTime);
% MacroCompRampTime = MacroCompRampTimeTemp;

% MacroCompParaAmp = 0.8/ MacroCentralCal; %Amperes
% MacroCompParaFreq = 190;
% MacroCompParaFreq = linspace(150,230,8);

MacroCompressTime = MacroCompRampTime + MacCompHoldTime;


% % DimpleMacroComp  = DimpleMacroCap + (DimpleMacroComp-DimpleMacroCap) * (MacroCompRampTimeTemp/MacroCompRampTime);
% MACRORF = 0;
% MACRORFPWR = -13;
% % MacroEvapLowFreq = 1.45e6;
% % MacroEvapHighFreq = 3e6;
% % MacroEvapSweepTime = 1000*ms;
% % MacroEvapLowFreq = 1.3702e6;
% MacroEvapLowFreq = 4.59e6;
% MacroEvapHighFreq =6e6;
% MacroEvapSweepTime = DimpleRampTime;
    

%% Micro Wire Capture

%predicted
% CentralMicroCap = 2;
% ArmsMicroCap = 2;
% BiasMicroCap = 30;
% XBiasMicroCap = 3;

%best
% CentralMicroCap = -1.95/ CentralMicroCal; %best
% % CentralMicroCap = 0/ CentralMicroCal; %test
% ArmsMicroCap = 0 / ArmsMicroCal;
% % ArmsMicroCap = 1 / ArmsMicroCal; %best
% BiasMacroMicro = 20 / MacroBiasCal; %best
% % BiasMacroMicro = 40 / MacroBiasCal; %test
% % XMicroCap = 0.5 / MagXCal; %best
% XMicroCap = 5 / MagXCal; %test
% % YMicroCap = 0 / MagYCal;
% YMicroCap = YBias;
% ZMicroCap = 0 / MagZCal;

ArmTrap =1;
DimpleTrap = 0;
DimpleToArmTrap = 0;

EvapThenTranslate = 0;

if ArmTrap

%%Chip V2
    CentralMicroCap =-2.5/ CentralMicroCal;  
%     CentralMicroCap =0/ CentralMicroCal;  
%     ArmsMicroCap = -.5/ ArmsMicroCal; 
    ArmsMicroCap = 0/ ArmsMicroCal;
%     ArmsMicroCap = 0/ ArmsMicroCal;
%     BiasMacroMicro = 12.8 / MacroBiasCal; 
%     BiasMacroMicro = 25/ MacroBiasCal; 
    BiasMacroMicro = 23 / MacroBiasCal; 
    XMicroCap =0.0/ MagXCal;
    YMicroCap = 0;
    ZMicroCap = 0 / MagZCal;

    CentralMacroMicro =0 / MacroCentralCal;
    DimpleMicroCap=0/DimpleMicroCal;
    AxialMacroMicro =0/MacroAxialCal;
    CompressMacroMicro = 0;
    
%     MicroRampTime = 100*ms; %Best %Time to ramp up microwires

    MicroRampTime = 100*ms; %Test %Time to ramp up microwires
    MacroMicroWaitTime = 1*ms;
%      MacroMicroWaitTime = MicroRampTime;
    MacroMicroRampTime = MicroRampTime; %Time to ramp down macro wires best
    MicroCapHoldTime =[1];
    
    MicroCapRelaxTime = 1*ms;
    AxialMacroRelax = AxialMacroMicro;
    ArmsMicroRelax = ArmsMicroCap;
    DimpleMicroRelax = DimpleMicroCap;

    
%     MicroCapParaAmp = 0.07 / CentralMicroCal;
%     MicroCompParaFreq = linspace(10,210,25);
%     MicroCompParaFreq = 600;
    
%     MicroCapKickAmp = 0.05 / CentralMicroCal;

end
if DimpleTrap
%     CentralMicroCap = -1.95/ CentralMicroCal;
    CentralMicroCap = 0/ CentralMicroCal;
    ArmsMicroCap = 0 / ArmsMicroCal;
    BiasMacroMicro = 20 / MacroBiasCal;
%     BiasMacroMicro = 35 / MacroBiasCal;
    XMicroCap = 5 / MagXCal;
%     XMicroCap = 0 / MagXCal;
    YMicroCap = YBias;
    ZMicroCap = 0 / MagZCal;

    CentralMacroMicro = 0;
    AxialMacroMicro = 8 / MacroAxialCal;
    DimpleMicroCap = -1.5/ DimpleMicroCal;
    CompressMacroMicro = 0;
    
    MicroRampTime = 400*ms; %Time to ramp up microwires
    CentralRampTime = 2*ms; % Time to ramp off central macrowire
    MacroMicroWaitTime = 0*ms;
    MacroMicroRampTime = MicroRampTime; %Time to ramp down macro wires best
    MicroCapHoldTime = 10*ms; %sec 
    
    MicroCapRelaxTime = 1*ms;
    AxialMacroRelax = 8/ MacroAxialCal;
    ArmsMicroRelax = 0/ArmsMicroCal;
    DimpleMicroRelax = DimpleMicroCap;
end
if DimpleToArmTrap
    CentralMicroCap = -1.95/ CentralMicroCal;
    ArmsMicroCap = 0 / ArmsMicroCal;
    BiasMacroMicro = 20 / MacroBiasCal;
    XMicroCap = 5 / MagXCal;
    YMicroCap = YBias;
    ZMicroCap = 0 / MagZCal;

    CentralMacroMicro = 0;
    AxialMacroMicro = 8 / MacroAxialCal;
    DimpleMicroCap = -1.5/ DimpleMicroCal;
    CompressMacroMicro = 0;
    
    MicroRampTime = 400*ms; %Time to ramp up microwires
    CentralRampTime = 2*ms; % Time to ramp off central macrowire
    MacroMicroWaitTime = 0*ms;
    MacroMicroRampTime = MicroRampTime; %Time to ramp down macro wires best
    MicroCapHoldTime = 1*ms; %sec 
    
    DimpleArmTransferTime = 500*ms;
    AxialMacroRelax = 0/ MacroAxialCal;
    ArmsMicroRelax = 1/ArmsMicroCal;
    DimpleMicroRelax = 0/ DimpleMicroCal;
end

if DimpleToArmTrap
    MicroCapRFVVA =10;
    
    DimpleEvapHigh = MacroCompRFLow;
    DimpleEvapLow = 3e6;
    DimpleEvapSweepTime = 1500*ms;

    ArmEvapHigh =15e6;
    ArmEvapLow = 4.4e6;
    ArmEvapSweepTime = 2500*ms;

    MicroCaptureTime =  MicroCapHoldTime + max(MicroRampTime,MacroMicroWaitTime + MacroMicroRampTime) + DimpleEvapSweepTime + ArmEvapSweepTime + DimpleArmTransferTime;  
else    
%     RateScaling = 1;
%     MicroCapRFHigh =10e6;
%     MicroCapRFLow = 2e6;
%     MicroCapRFRate =5e6 * RateScaling;

    RateScaling = 1;
%     Best
    MicroCapRFHigh =10e6;
    MicroCapRFLow = 2.5e6;
    MicroCapRFRate =5e6 * RateScaling;

%     Test
%     MicroCapRFHigh =10e6;
%     MicroCapRFLow = 3e6;
%     MicroCapRFRate =5e6 * RateScaling;
    
%     MicroCapRFSweepTime = (MicroCapRFHigh-MicroCapRFLow)/MicroCapRFRate;
    MicroCapRFSweepTime = 1*ms;
    MicroCapRFVVA =0;
    
    TWOSTEPMICROEVAP =0;
    THREESTEPMICROEVAP =0;   
     
    if TWOSTEPMICROEVAP
        MicroCapRFHigh2 = MicroCapRFLow + 1e3;
        MicroCapRFLow2 =2.0e6;
        MicroCapRFRate2 = 1e6 * RateScaling;
        MicroCapRFSweepTime2 = (MicroCapRFHigh2-MicroCapRFLow2)/MicroCapRFRate2;
%         MicroCapRFSweepTime2 = 1000*ms;
        EvapDelayTime = 10*ms;
        
        
%         MicroCapRFHigh2 = MicroCapRFLow + 1e3;
%         MicroCapRFLow2 = .5e6;
%         MicroCapRFRate2 = .5e6 * RateScaling;
%         MicroCapRFSweepTime2 = (MicroCapRFHigh2-MicroCapRFLow2)/MicroCapRFRate2;
% %         MicroCapRFSweepTime2 = 1000*ms;
%         EvapDelayTime = 10*ms;
    end
    if THREESTEPMICROEVAP
        MicroCapRFHigh3 = MicroCapRFLow2 + 1e3;
        MicroCapRFLow3 = 1.3e6;
        MicroCapRFRate3 = .1e6 * RateScaling;
        MicroCapRFSweepTime3 = (MicroCapRFHigh3-MicroCapRFLow3)/MicroCapRFRate3;
%         MicroCapRFSweepTime2 = 1000*ms;
        EvapDelayTime3 = 10*ms;
    end


    if TWOSTEPMICROEVAP && THREESTEPMICROEVAP
        MicroCaptureTime = EvapDelayTime+EvapDelayTime3+MicroCapHoldTime + MicroCapRFSweepTime + MicroCapRFSweepTime3+MicroCapRFSweepTime2 + max(MicroRampTime,MacroMicroWaitTime + MacroMicroRampTime);
    elseif TWOSTEPMICROEVAP
        MicroCaptureTime = EvapDelayTime+MicroCapHoldTime + MicroCapRFSweepTime + MicroCapRFSweepTime2 + max(MicroRampTime,MacroMicroWaitTime + MacroMicroRampTime);
    else
        MicroCaptureTime = MicroCapHoldTime + MicroCapRFSweepTime + max(MicroRampTime,MacroMicroWaitTime + MacroMicroRampTime);
    end
end

if EvapThenTranslate
    MicroTransTime = 100*ms;
    
    CentralMicroTrans =-2.5/ CentralMicroCal;  
    ArmsMicroTrans = -.5/ ArmsMicroCal; 
    BiasMacroMicroTrans = 28 / MacroBiasCal; 
    XMicroTrans =3/ MagXCal;
    YMicroTrans = 0;
    ZMicroTrans = 0 / MagZCal;

    CentralMacroMicroTrans =0 / MacroCentralCal;
    DimpleMicroTrans=0/DimpleMicroCal;
    AxialMacroMicroTrans =0/MacroAxialCal;
    CompressMacroMicroTrans = 0;
    
    MicroCaptureTime = MicroCaptureTime + MicroTransTime;
end

%%%%%% Two StepEvap %%%%%%%%%%
% DimpleEvapHigh = MacroCompRFLow;
% DimpleEvapLow = 2.5e6;
% DimpleEvapSweepTime = 2000*ms;
% 
% ArmEvapHigh =10e6;
% ArmEvapLow = 8e6;
% ArmEvapSweepTime = 2000*ms;
% 
% MicroCaptureTime =  MicroCapHoldTime + max(MicroRampTime,MacroMicroWaitTime + MacroMicroRampTime) + DimpleEvapSweepTime + ArmEvapSweepTime + DimpleArmTransferTime;
%%%%------------------%%%%%

% MicroCapRFHigh =15e6;
% MicroCapRFLow = 2e6;
% MicroCapRFSweepTime = MicroCapHoldTime-MicroCapRelaxTime;
% MicroCapRFVVA =0;

%%% for parametric heating trap frequency measurement
% MicroParaAmp = 0*CentralMicroCap / CentralMicroCal;
% MicroParaFreq=0;
%%%


%% For Off
OffTime=3; %sec, Amount of time keep the machine off

%% Logics
CAMERASHUTOPEN = 1;
CAMERASHUTCLOSE = 0;
MOTPON = 1;
MOTPOFF = 0;
MOTRON = 1;
MOTROFF = 0;
ZEEMANPON = 1;
ZEEMANPOFF = 0;
ZEEMANRON = 1;
ZEEMANROFF = 0;
ZAOMON = 0;
ZAOMOFF = 1;
CAMERATRIG = 1;
CAMERAOFF = 0;
UNION = 1;
UNIOFF = 0;
IMAGING1ON = 1;
IMAGING1OFF = 0;
IMGAOMON = 1;
IMGAOMOFF = 0;
IMG1SHUTON = 1;
IMG1SHUTOFF = 0;
IMG2SHUTON = 0;
IMG2SHUTOFF = 1;
IMAGING4OFF=0;
IMAGING4ON=1;
MOTRSHUTON = 1;
MOTRSHUTOFF = 0;
ODTAOMON =1;
ODTAOMOFF = 0;
RFON = 2;
RFOFF = 0;
SIGPLUSSHUTON = 1;
SIGPLUSSHUTOFF = 0;
ACRON = 1;
ACROFF = 0;
SIGMINUSSHUTON = 0;
SIGMINUSSHUTOFF = 1;
VERTSHUTON = 1;
VERTSHUTOFF = 0;
PUMPON =1;
PUMPOFF = 0;


RFOCTOGON = 0;
RFMAGELLAN = 1;

SOLOISTTRIG = 1;

MAGTRIGOFF = 7.5;
MAGTRIGON = 0;

%% For Shutters
% CAMERAONTIME = 13*ms; %best
CAMERAONTIME = 18*ms;
CAMERAOFFTIME = 0;

IMAGING1ONS = 1000e-6;%sec, from calibration in sequence
IMAGING1OFFS = 1200e-6;%sec, from calibration in sequence

IMAGING1OND = 50*ms; %sec, test, works better
IMAGING1OFFD = 10*ms;%sec, from calibration in sequence

IMAGING4ONTIME = 23*ms; %Guess
IMAGING4OFFTIME = 0;

ZRSHUTOFFTIME = 13*ms;
ZRSHUTONTIME = 26.2*ms;

SIGMINUSSHUTONTIME = 26*ms;
% SIGMINUSSHUTOFFTIME = 31.8*ms;
SIGMINUSSHUTOFFTIME = 0;

OPIMG1OPEN =18.2*ms;
OPIMG2OPEN =18.2*ms;

%% Calibrated 3-27-12
MOTPSHUTTERON = 29.6*ms;
MOTPSHUTTEROFF = 15.4*ms; %real
% MOTPSHUTTEROFF = 16*ms; %test
% 
MOTRSHUTONTIME = 26*ms;
MOTRSHUTOFFTIME = 13*ms;
% MOTRSHUTOFFTIME = 0*ms;

ZPSHUTONTIME = 30*ms;
% ZPSHUTOFFTIME = 12.8*ms; %real
% ZPSHUTOFFTIME = 20*ms; %real2
ZPSHUTOFFTIME = 100*ms; %test

IMG2SHUTONTIME = 30.8*ms; %Best
% IMG2SHUTONTIME = 50*ms;
IMG2SHUTOFFTIME = 11.6*ms; %Best
% IMG2SHUTOFFTIME = 0*ms;

VERTSHUTONTIME = 50*ms; %38
VERTSHUTOFFTIME = 11.8*ms;

% SIGPLUSSHUTOFFTIME = 11.8*ms;
SIGPLUSSHUTOFFTIME = 0;
% SIGPLUSSHUTONTIME = 29.6*ms; %real
SIGPLUSSHUTONTIME = 37*ms; %best
% SIGPLUSSHUTONTIME = 39*ms; %test

IMG1SHUTONTIME = 32*ms;
IMG1SHUTOFFTIME = 11.8*ms;

ACRONTIME = 29.2*ms; %test
% ACRONTIME = 27.2*ms; %Best
ACROFFTIME = 14.4*ms;

ODTIMGSHUTTERONTIME =500*ms;


%% XPS

XPS_IP = '171.64.84.123';
XPS_Port = 5001;

% DDS Test Parameters
% 
% ********************** GENERAL *******************************

REF_FREQ = 10e6; %10 MHz reference clock
SYS_FREQ = 200e6; %200 MHz system clock
NUM_PINS = 6; %number of pins in use
TTL_HIGH = 1; %1 for digital, 3.3 for analog simulation
TTL_LOW = 0;
MSB = 1;

% ********************** DDS Initialization *********************
PLL_Multiplier = 20;

InitParameters = [PLL_Multiplier];

%% Soloist
soloistPort = 5555;
soloistHostName = '171.64.84.169';
