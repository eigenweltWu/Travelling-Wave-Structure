%%%Initializing(Don't Change!)
clear;
global grating;
cst = actxserver('CSTStudio.application');
mws = invoke(cst, 'FileNew');
grating = [];
par_list = dictionary('tp','0.035'); % 定义类型为str->str
%%%---------------------------------------------------------
%一次性结构的生成请在func_initialization中完成
%设置参数 可从CST导出后使用read_par_list生成
par_list('lx')='2*x_port+p_tooth*(nr_strip-1)+w_tooth';
par_list('ly')='36';
par_list('ts')='3';
par_list('tp')='0.035';
par_list('x_port')='1';
par_list('w_tooth')='1';
par_list('l_max')='15';
par_list('l_min')='8';

par_list('x_teeth')='1';
par_list('y_teeth')='0'; 
par_list('p_tooth')='2.2';
par_list('x_teeth2')='x_port+p_tooth/2';
par_list('p_tooth2')='2.2';
par_list('w_tooth2')='p_tooth-w_tooth';
par_list('l_max2')='6';
par_list('l_min2')='12';

par_list('nr_strip')='10';
par_list('nr_teeth2')='9';

par_list('y_teeth2')='11.5';
par_list('x_teeth3')='x_teeth2';
par_list('p_tooth3')='p_tooth2';
par_list('w_tooth3')='w_tooth2';
par_list('y_teeth3')='-y_teeth2';
par_list('l_max3')='l_max2';
par_list('l_min3')='l_min2';
par_list('nr_teeth3')='nr_teeth2';
%生成周期结构
func_generate_grating('x',str2num(par_list('nr_strip')),'slot1');
func_generate_grating('x',str2num(par_list('nr_teeth2')),'slot2');

% Define Material
sCommand = '';
sCommand = 'With Material';
sCommand = func_create_sCommand(sCommand, '.Reset');
sCommand = func_create_sCommand(sCommand, '.Name "%s"', 'felt');
sCommand = func_create_sCommand(sCommand, '.Folder "%s"', '');
sCommand = func_create_sCommand(sCommand, '.Rho "%s"', '0');
sCommand = func_create_sCommand(sCommand, '.ThermalType "%s"', 'Normal');
sCommand = func_create_sCommand(sCommand, '.ThermalConductivity "%s"', '0');
sCommand = func_create_sCommand(sCommand, '.SpecificHeat "%s", "%s"', '0', 'J/K/kg');
sCommand = func_create_sCommand(sCommand, '.DynamicViscosity "%s"', '0');
sCommand = func_create_sCommand(sCommand, '.UseEmissivity "%s"', 'True');
sCommand = func_create_sCommand(sCommand, '.Emissivity "%s"', '0');
sCommand = func_create_sCommand(sCommand, '.MetabolicRate "%s"', '0.0');
sCommand = func_create_sCommand(sCommand, '.VoxelConvection "%s"', '0.0');
sCommand = func_create_sCommand(sCommand, '.BloodFlow "%s"', '0');
sCommand = func_create_sCommand(sCommand, '.Absorptance "%s"', '0');
sCommand = func_create_sCommand(sCommand, '.MechanicsType "%s"', 'Unused');
sCommand = func_create_sCommand(sCommand, '.IntrinsicCarrierDensity "%s"', '0');
sCommand = func_create_sCommand(sCommand, '.FrqType "%s"', 'all');
sCommand = func_create_sCommand(sCommand, '.Type "%s"', 'Normal');
sCommand = func_create_sCommand(sCommand, '.MaterialUnit "%s", "%s"', 'Frequency', 'GHz');
sCommand = func_create_sCommand(sCommand, '.MaterialUnit "%s", "%s"', 'Geometry', 'mm');
sCommand = func_create_sCommand(sCommand, '.MaterialUnit "%s", "%s"', 'Time', 'ns');
sCommand = func_create_sCommand(sCommand, '.MaterialUnit "%s", "%s"', 'Temperature', 'K');
sCommand = func_create_sCommand(sCommand, '.Epsilon "%s"', '1.2');
sCommand = func_create_sCommand(sCommand, '.Mu "%s"', '1');
sCommand = func_create_sCommand(sCommand, '.Sigma "%s"', '0');
sCommand = func_create_sCommand(sCommand, '.TanD "%s"', '0.0');
sCommand = func_create_sCommand(sCommand, '.TanDFreq "%s"', '0.0');
sCommand = func_create_sCommand(sCommand, '.TanDGiven "%s"', 'False');
sCommand = func_create_sCommand(sCommand, '.TanDModel "%s"', 'ConstTanD');
sCommand = func_create_sCommand(sCommand, '.SetConstTanDStrategyEps "%s"', 'AutomaticOrder');
sCommand = func_create_sCommand(sCommand, '.ConstTanDModelOrderEps "%s"', '3');
sCommand = func_create_sCommand(sCommand, '.DjordjevicSarkarUpperFreqEps "%s"', '0');
sCommand = func_create_sCommand(sCommand, '.SetElParametricConductivity "%s"', 'False');
sCommand = func_create_sCommand(sCommand, '.ReferenceCoordSystem "%s"', 'Global');
sCommand = func_create_sCommand(sCommand, '.CoordSystemType "%s"', 'Cartesian');
sCommand = func_create_sCommand(sCommand, '.SigmaM "%s"', '0');
sCommand = func_create_sCommand(sCommand, '.TanDM "%s"', '0.0');
sCommand = func_create_sCommand(sCommand, '.TanDMFreq "%s"', '0.0');
sCommand = func_create_sCommand(sCommand, '.TanDMGiven "%s"', 'False');
sCommand = func_create_sCommand(sCommand, '.TanDMModel "%s"', 'ConstTanD');
sCommand = func_create_sCommand(sCommand, '.SetConstTanDStrategyMu "%s"', 'AutomaticOrder');
sCommand = func_create_sCommand(sCommand, '.ConstTanDModelOrderMu "%s"', '3');
sCommand = func_create_sCommand(sCommand, '.DjordjevicSarkarUpperFreqMu "%s"', '0');
sCommand = func_create_sCommand(sCommand, '.SetMagParametricConductivity "%s"', 'False');
sCommand = func_create_sCommand(sCommand, '.DispModelEps "%s"', 'None');
sCommand = func_create_sCommand(sCommand, '.DispModelMu "%s"', 'None');
sCommand = func_create_sCommand(sCommand, '.DispersiveFittingSchemeEps "%s"', 'Nth Order');
sCommand = func_create_sCommand(sCommand, '.MaximalOrderNthModelFitEps "%s"', '10');
sCommand = func_create_sCommand(sCommand, '.ErrorLimitNthModelFitEps "%s"', '0.1');
sCommand = func_create_sCommand(sCommand, '.DispersiveFittingSchemeMu "%s"', 'Nth Order');
sCommand = func_create_sCommand(sCommand, '.MaximalOrderNthModelFitMu "%s"', '10');
sCommand = func_create_sCommand(sCommand, '.ErrorLimitNthModelFitMu "%s"', '0.1');
sCommand = func_create_sCommand(sCommand, '.UseGeneralDispersionEps "%s"', 'False');
sCommand = func_create_sCommand(sCommand, '.UseGeneralDispersionMu "%s"', 'False');
sCommand = func_create_sCommand(sCommand, '.NLAnisotropy "%s"', 'False');
sCommand = func_create_sCommand(sCommand, '.NLAStackingFactor "%s"', '1');
sCommand = func_create_sCommand(sCommand, '.NLADirectionX "%s"', '1');
sCommand = func_create_sCommand(sCommand, '.NLADirectionY "%s"', '0');
sCommand = func_create_sCommand(sCommand, '.NLADirectionZ "%s"', '0');
sCommand = func_create_sCommand(sCommand, '.Colour "%s", "%s", "%s"', '1', '0.501961', '0');
sCommand = func_create_sCommand(sCommand, '.Wireframe "%s"', 'False');
sCommand = func_create_sCommand(sCommand, '.Reflection "%s"', 'False');
sCommand = func_create_sCommand(sCommand, '.Allowoutline "%s"', 'True');
sCommand = func_create_sCommand(sCommand, '.Transparentoutline "%s"', 'False');
sCommand = func_create_sCommand(sCommand, '.Transparency "%s"', '0');
sCommand = func_create_sCommand(sCommand, '.Create');
sCommand = func_create_sCommand(sCommand, 'End With');
invoke(mws, 'AddToHistory', 'define material: felt', sCommand);


%%%============================================================

func_initialization(mws,par_list);

for i = 1:length(grating)
    compname = ['grating',num2str(i)];
    sCommand = func_create_sCommand('', 'Component.New "%s"', compname);
    invoke(mws, 'AddToHistory', ['define component: ', compname], sCommand);
    item = grating(i);
    item = item{1};
    if strcmp(item('direction'), 'x')
        for j = 1:str2num(item('nr'))
            feval(item('func'), j, -1, compname, mws);
        end
    elseif strcmp(item('direction'), 'y')
        for j = 1:str2num(item('nr'))
            feval(item('func'), -1, j, compname, mws);
        end
    elseif strcmp(item('direction'),'xy')
        for xx = 1:str2num(item('nr'))
            for yy = 1:str2double(item('nr'))
                feval(item('func'), xx, yy, compname, mws);
            end
        end
    end
end