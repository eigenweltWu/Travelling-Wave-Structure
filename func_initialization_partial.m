function func_initialization_partial(mws,par_list)
    % Define Parameter
    keys = par_list.keys();
    values = par_list.values();
    for i = 1:length(keys)
        func_register_par(mws,keys{i},values{i});
    end
    
    func_register_par(mws,'w_meander','0.5');
    sCommand = '';
    sCommand = 'With Brick';
    sCommand = func_create_sCommand(sCommand, '.Reset');
    sCommand = func_create_sCommand(sCommand, '.Name "%s"', 'left_strip');
    sCommand = func_create_sCommand(sCommand, '.Component "%s"', 'component1');
    sCommand = func_create_sCommand(sCommand, '.Material "%s"', 'PEC');
    sCommand = func_create_sCommand(sCommand, '.Xrange "%s", "%s"', '-lx/2', '-lx/2+x_strip-w_strip/2');
    sCommand = func_create_sCommand(sCommand, '.Yrange "%s", "%s"', ...
        '(y_strip+l_max/2+ly/2)/2-w_meander/2', '(y_strip+l_max/2+ly/2)/2+w_meander/2');
    sCommand = func_create_sCommand(sCommand, '.Zrange "%s", "%s"', 'ts', 'ts+tp');
    sCommand = func_create_sCommand(sCommand, '.Create');
    sCommand = func_create_sCommand(sCommand, 'End With');
    invoke(mws, 'AddToHistory', 'define left_strip', sCommand);

    sCommand = '';
    sCommand = 'With Brick';
    sCommand = func_create_sCommand(sCommand, '.Reset');
    sCommand = func_create_sCommand(sCommand, '.Name "%s"', 'right_strip');
    sCommand = func_create_sCommand(sCommand, '.Component "%s"', 'component1');
    sCommand = func_create_sCommand(sCommand, '.Material "%s"', 'PEC');
    sCommand = func_create_sCommand(sCommand, '.Xrange "%s", "%s"', 'lx/2', ...
        '-lx/2+x_strip-w_strip/2+p_meander*(nr_vmeander-1)+w_meander');
    sCommand = func_create_sCommand(sCommand, '.Yrange "%s", "%s"', ...
        '(y_strip+l_max/2+ly/2)/2-w_meander/2', '(y_strip+l_max/2+ly/2)/2+w_meander/2');
    sCommand = func_create_sCommand(sCommand, '.Zrange "%s", "%s"', 'ts', 'ts+tp');
    sCommand = func_create_sCommand(sCommand, '.Create');
    sCommand = func_create_sCommand(sCommand, 'End With');
    invoke(mws, 'AddToHistory', 'define right_strip', sCommand);
end