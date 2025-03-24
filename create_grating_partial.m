%%%Initializing(Don't Change!)
clear;
global grating;
grating = [];
par_list = dictionary('tp','0.035'); % 定义类型为str->str
%%%---------------------------------------------------------
%一次性结构的生成请在func_initialization中完成
%设置参数 可从CST导出后使用read_par_list生成
newflname = [pwd,'\sample_partial.cst']; % 需要为完整路径
originalflname = 'sample.cst'; % 可以为相对路径
nr_vmeander = 10;
par_list('p_meander') = '1.8';
par_list('l_vmeander_max') = '8';
par_list('l_vmeander_min') = '1.5';
par_list('ly!') = '28'; %修改ly=28
par_list('nr_vmeander') = nr_vmeander;
par_hmeander = dictionary('nr_hmeander',num2str(nr_vmeander-1));
par_vmeander = dictionary('nr_vmeander',num2str(nr_vmeander));

func_generate_grating('x',0,'',''); %占位符，防止comp:grating1被重新使用
func_generate_grating('x',nr_vmeander-1,'hmeander','par_hmeander');
func_generate_grating('x',nr_vmeander,'vmeander','par_vmeander');

%%%============================================================
if ~isSameFile(newflname,originalflname)
    cstfolder = split(newflname,'.cst');
    if exist(cstfolder{1},'dir')
        rmdir(cstfolder{1},'s');
    end
    copyfile(originalflname,newflname);
end
cst = actxserver('CSTStudio.application');
mws = invoke(cst, 'OpenFile', newflname);%
func_initialization_partial(mws,par_list);

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
            end
        end
    elseif strcmp(item('direction'), 'y')
        for j = 1:str2num(item('nr'))
            if ~isempty(item('par'))
                feval(item('func'), -1, j, compname, mws, eval(item('par')));
            end
        end
    elseif strcmp(item('direction'),'xy')
        for xx = 1:str2num(item('nr'))
            for yy = 1:str2double(item('nr'))
                if ~isempty(item('par'))
                    feval(item('func'), xx, yy, compname, mws, eval(item('par')));
                end
            end
        end
    end
end