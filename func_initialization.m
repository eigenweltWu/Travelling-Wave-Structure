function func_initialization(mws,par_list)
    % Define Parameter
    keys = par_list.keys();
    values = par_list.values();
    for i = 1:length(keys)
        func_register_par(mws,keys{i},values{i});
    end
    
    % Define substrate and gnd
    sCommand = ['Component.New "component1"'];
    invoke(mws,'AddToHistory', ['new component: component1'], sCommand);
    
    sCommand = 'With Brick';
    sCommand = func_create_sCommand(sCommand, '.Reset');
    sCommand = func_create_sCommand(sCommand, '.Name "%s"', 'substrate');
    sCommand = func_create_sCommand(sCommand, '.Component "%s"', 'component1');
    sCommand = func_create_sCommand(sCommand, '.Material "%s"', 'felt');
    sCommand = func_create_sCommand(sCommand, '.Xrange "%s", "%s"','-lx/2','lx/2');
    sCommand = func_create_sCommand(sCommand, '.Yrange "%s", "%s"','-ly/2','ly/2');
    sCommand = func_create_sCommand(sCommand, '.Zrange "%s","%s"', '0', 'ts');
    sCommand = func_create_sCommand(sCommand, '.Create');
    sCommand = func_create_sCommand(sCommand, 'End With');
    invoke(mws,'AddToHistory', ['define brick: component1:substrate'],sCommand);
    
    sCommand = 'With Brick';
    sCommand = func_create_sCommand(sCommand, '.Reset');
    sCommand = func_create_sCommand(sCommand, '.Name "%s"', 'gnd');
    sCommand = func_create_sCommand(sCommand, '.Component "%s"', 'component1');
    sCommand = func_create_sCommand(sCommand, '.Material "%s"', 'PEC');
    sCommand = func_create_sCommand(sCommand, '.Xrange "%s", "%s"','-lx/2','lx/2');
    sCommand = func_create_sCommand(sCommand, '.Yrange "%s", "%s"','-ly/2','ly/2');
    sCommand = func_create_sCommand(sCommand, '.Zrange "%s","%s"', '-tp', '0');
    sCommand = func_create_sCommand(sCommand, '.Create');
    sCommand = func_create_sCommand(sCommand, 'End With');
    invoke(mws,'AddToHistory', ['define brick: component1:gnd'],sCommand);

    sCommand = '';
    sCommand = 'With Brick';
    sCommand = func_create_sCommand(sCommand, '.Reset');
    sCommand = func_create_sCommand(sCommand, '.Name "%s"', 'patch');
    sCommand = func_create_sCommand(sCommand, '.Component "%s"', 'component1');
    sCommand = func_create_sCommand(sCommand, '.Material "%s"', 'PEC');
    sCommand = func_create_sCommand(sCommand, '.Xrange "%s", "%s"', '-lx/2', 'lx/2');
    sCommand = func_create_sCommand(sCommand, '.Yrange "%s", "%s"', '-ly/2', 'ly/2');
    sCommand = func_create_sCommand(sCommand, '.Zrange "%s", "%s"', 'ts', 'ts+tp');
    sCommand = func_create_sCommand(sCommand, '.Create');
    sCommand = func_create_sCommand(sCommand, 'End With');
    invoke(mws, 'AddToHistory', 'define brick: component1:patch', sCommand);

    sCommand = '';
    sCommand = 'With Brick';
    sCommand = func_create_sCommand(sCommand, '.Reset');
    sCommand = func_create_sCommand(sCommand, '.Name "%s"', 'wall1');
    sCommand = func_create_sCommand(sCommand, '.Component "%s"', 'component1');
    sCommand = func_create_sCommand(sCommand, '.Material "%s"', 'PEC');
    sCommand = func_create_sCommand(sCommand, '.Xrange "%s", "%s"', '-lx/2', 'lx/2');
    sCommand = func_create_sCommand(sCommand, '.Yrange "%s", "%s"', '-ly/2-tp', '-ly/2');
    sCommand = func_create_sCommand(sCommand, '.Zrange "%s", "%s"', '-tp', 'ts+tp');
    sCommand = func_create_sCommand(sCommand, '.Create');
    sCommand = func_create_sCommand(sCommand, 'End With');
    invoke(mws, 'AddToHistory', 'define brick: component1:wall1', sCommand);
    sCommand = '';
    sCommand = 'With Brick';
    
    sCommand = func_create_sCommand(sCommand, '.Reset');
    sCommand = func_create_sCommand(sCommand, '.Name "%s"', 'wall2');
    sCommand = func_create_sCommand(sCommand, '.Component "%s"', 'component1');
    sCommand = func_create_sCommand(sCommand, '.Material "%s"', 'PEC');
    sCommand = func_create_sCommand(sCommand, '.Xrange "%s", "%s"', '-lx/2', 'lx/2');
    sCommand = func_create_sCommand(sCommand, '.Yrange "%s", "%s"', 'ly/2', 'ly/2+tp');
    sCommand = func_create_sCommand(sCommand, '.Zrange "%s", "%s"', '-tp', 'ts+tp');
    sCommand = func_create_sCommand(sCommand, '.Create');
    sCommand = func_create_sCommand(sCommand, 'End With');
    invoke(mws, 'AddToHistory', 'define brick: component1:wall2', sCommand);
end