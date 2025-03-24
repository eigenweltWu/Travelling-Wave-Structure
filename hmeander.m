function hmeander(idx, idy, compname, mws, paras)

    nr_meanders = str2double(paras('nr_hmeander'));
    ymin = [''];
    ymax = [''];
    xmin = ['-lx/2+x_strip-w_strip/2+w_meander+p_meander*',num2str(idx-1)];
    xmax = ['-lx/2+x_strip-w_strip/2+p_meander*',num2str(idx)];
    if mod(idx,2) == 1
        ymin = ['(y_strip+l_max/2+ly/2)/2-((l_vmeander_max-l_vmeander_min)/',num2str(nr_meanders-1),...
            '*',num2str(idx-1),'+l_vmeander_min)/2'];
        ymax = ['(y_strip+l_max/2+ly/2)/2-((l_vmeander_max-l_vmeander_min)/',num2str(nr_meanders-1),...
            '*',num2str(idx-1),'+l_vmeander_min)/2+w_meander'];
    else
        ymin = ['(y_strip+l_max/2+ly/2)/2+((l_vmeander_max-l_vmeander_min)/',num2str(nr_meanders-1),...
            '*',num2str(idx-1),'+l_vmeander_min)/2-w_meander'];
        ymax = ['(y_strip+l_max/2+ly/2)/2+((l_vmeander_max-l_vmeander_min)/',num2str(nr_meanders-1),...
            '*',num2str(idx-1),'+l_vmeander_min)/2'];
    end
    sCommand = '';
    sCommand = 'With Brick';
    sCommand = func_create_sCommand(sCommand, '.Reset');
    sCommand = func_create_sCommand(sCommand, '.Name "%s"', ['hmeander',num2str(idx)]);
    sCommand = func_create_sCommand(sCommand, '.Component "%s"', compname);
    sCommand = func_create_sCommand(sCommand, '.Material "%s"', 'PEC');
    sCommand = func_create_sCommand(sCommand, '.Xrange "%s", "%s"', xmin, xmax);
    sCommand = func_create_sCommand(sCommand, '.Yrange "%s", "%s"', ymax, ymin);
    sCommand = func_create_sCommand(sCommand, '.Zrange "%s", "%s"', 'ts', 'ts+tp');
    sCommand = func_create_sCommand(sCommand, '.Create');
    sCommand = func_create_sCommand(sCommand, 'End With');
    invoke(mws, 'AddToHistory', ['define h_meander_',num2str(idx)], sCommand);

end