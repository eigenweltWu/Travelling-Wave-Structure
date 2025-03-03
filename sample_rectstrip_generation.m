function sample_rectstrip_generation(idx, idy, compname, mws)

% Register Parameters
% lx,ly,ts,tp,nr_strip should be pre-defined in the main context.

func_register_par(mws,'x_strip',3);
func_register_par(mws,'y_strip',0);
func_register_par(mws,'p_strip',1.8);
func_register_par(mws,'w_strip',1.2);
func_register_par(mws,'l_max',12);
func_register_par(mws,'l_min',4);


% Define Rules
xsmin = ['-lx/2+x_strip-w_strip/2+p_strip*',num2str(idx-1)];
xsmax = ['-lx/2+x_strip+w_strip/2+p_strip*',num2str(idx-1)];
ysmin = ['y_strip+(l_max-(l_max-l_min)/(nr_strip-1)*',num2str(idx-1),')/2'];
ysmax = ['y_strip-(l_max-(l_max-l_min)/(nr_strip-1)*',num2str(idx-1),')/2'];
zsmin = 'ts';
zsmax = 'ts+tp';


% First define a strip
sCommand = 'With Brick';
sCommand = func_create_sCommand(sCommand, '.Reset');
sCommand = func_create_sCommand(sCommand, '.Name "%s"', ['strip',num2str(idx)]);
sCommand = func_create_sCommand(sCommand, '.Component "%s"', compname);
sCommand = func_create_sCommand(sCommand, '.Material "%s"', 'PEC');
sCommand = func_create_sCommand(sCommand, '.Xrange "%s", "%s"', xsmin, xsmax);
sCommand = func_create_sCommand(sCommand, '.Yrange "%s", "%s"', ysmin, ysmax);
sCommand = func_create_sCommand(sCommand, '.Zrange "%s", "%s"', zsmin, zsmax);
sCommand = func_create_sCommand(sCommand, '.Create');
sCommand = func_create_sCommand(sCommand, 'End With');
invoke(mws, 'AddToHistory', ['define brick: ',compname,':','strip',num2str(idx)], sCommand);

% You can also define slots to make boolean
func_register_par(mws,'w_slot','0.75*w_strip'); % it could also be an expression
func_register_par(mws,'ls_max','0.75*l_max');
func_register_par(mws,'ls_min','0.75*l_min');
xcmin = ['-lx/2+x_strip-w_slot/2+p_strip*',num2str(idx-1)];
xcmax = ['-lx/2+x_strip+w_slot/2+p_strip*',num2str(idx-1)];
ycmin = ['y_strip+(ls_max-(ls_max-ls_min)/(nr_strip-1)*',num2str(idx-1),')/2'];
ycmax = ['y_strip-(ls_max-(ls_max-ls_min)/(nr_strip-1)*',num2str(idx-1),')/2'];

sCommand = 'With Brick';
sCommand = func_create_sCommand(sCommand, '.Reset');
sCommand = func_create_sCommand(sCommand, '.Name "%s"', ['slot',num2str(idx)]);
sCommand = func_create_sCommand(sCommand, '.Component "%s"', compname);
sCommand = func_create_sCommand(sCommand, '.Material "%s"', 'PEC');
sCommand = func_create_sCommand(sCommand, '.Xrange "%s", "%s"', xcmin, xcmax);
sCommand = func_create_sCommand(sCommand, '.Yrange "%s", "%s"', ycmin, ycmax);
sCommand = func_create_sCommand(sCommand, '.Zrange "%s", "%s"', zsmin, zsmax);
sCommand = func_create_sCommand(sCommand, '.Create');
sCommand = func_create_sCommand(sCommand, 'End With');
invoke(mws, 'AddToHistory', ['define brick: ',compname,':','slot',num2str(idx)], sCommand);

sCommand = '';
sCommand = func_create_sCommand(sCommand, 'Solid.Subtract "%s", "%s"',...
    [compname,':','strip',num2str(idx)],[compname,':','slot',num2str(idx)]);
invoke(mws, 'AddToHistory', ['boolean subtract shapes:',...
    compname,':','strip',num2str(idx),', ',compname,':','slot',num2str(idx)], sCommand);
end