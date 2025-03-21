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

nr_strip = 10;

par_list('tp')='0.035';
par_list('ts')='3';
par_list('lx')='22';
par_list('ly')='16';
par_list('nr_strip')=num2str(nr_strip);
par_list('x_strip')='3';
par_list('y_strip')='0';
par_list('p_strip')='1.8';
par_list('w_strip')='1.2';
par_list('l_max')='12';
par_list('l_min')='15'; % will be changed in customized script
par_list('w_slot')='0.75*w_strip';
par_list('ls_max')='0.75*l_max';
par_list('ls_min')='0.75*l_min';

%记录导入变量
par_metal = dictionary('operation','metal'); % operation = metal
par_slot = dictionary('operation','slot'); % operation = slot
par_slot('metal_compname')='grating1';

%生成周期结构
func_generate_grating('x',str2num(par_list('nr_strip')),'sample_rectstrip_generation','par_metal');
func_generate_grating('x',str2num(par_list('nr_strip')),'sample_rectstrip_generation','par_slot');


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
            if ~isempty(item('par'))
                feval(item('func'), j, -1, compname, mws, eval(item('par')));
            else
                dtemp = dictionary();
                feval(item('func'), j, -1, compname, mws, dtemp);
            end
        end
    elseif strcmp(item('direction'), 'y')
        for j = 1:str2num(item('nr'))
            if ~isempty(item('par'))
                feval(item('func'), -1, j, compname, mws, eval(item('par')));
            else
                dtemp = dictionary();
                feval(item('func'), -1, j, compname, mws, dtemp);
            end
        end
    elseif strcmp(item('direction'),'xy')
        for xx = 1:str2num(item('nr'))
            for yy = 1:str2double(item('nr'))
                if ~isempty(item('par'))
                    feval(item('func'), xx, yy, compname, mws, eval(item('par')));
                else
                    dtemp = dictionary();
                    feval(item('func'), xx, yy, compname, mws, dtemp);
                end
            end
        end
    end
end
