function vmeander(idx, idy, compname, mws, paras)
    nr_meanders = str2double(paras('nr_vmeander'));
    ymin = [''];
    ymax = [''];
    xmin = ['-lx/2+x_strip-w_strip/2+p_meander*',num2str(idx-1)];
    xmax = ['-lx/2+x_strip-w_strip/2+w_meander+p_meander*',num2str(idx-1)];
    if idx == 1
        ymin = '(y_strip+l_max/2+ly/2)/2-l_vmeander_min/2';
        ymax = '(y_strip+l_max/2+ly/2)/2+w_meander/2';
    elseif idx == nr_meanders
        if mod(idx,2)==1
            ymin = '(y_strip+l_max/2+ly/2)/2+l_vmeander_max/2';
            ymax = '(y_strip+l_max/2+ly/2)/2-w_meander/2';
        else
            ymin = '(y_strip+l_max/2+ly/2)/2-l_vmeander_max/2';
            ymax = '(y_strip+l_max/2+ly/2)/2+w_meander/2';
        end
    else
        if mod(idx,2) == 1
            ymin = ['(y_strip+l_max/2+ly/2)/2-((l_vmeander_max-l_vmeander_min)/',num2str(nr_meanders-2),...
                '*',num2str(idx-1),'+l_vmeander_min)/2'];
            ymax = ['(y_strip+l_max/2+ly/2)/2+((l_vmeander_max-l_vmeander_min)/',num2str(nr_meanders-2),...
                '*',num2str(idx-2),'+l_vmeander_min)/2'];
        else
            ymin = ['(y_strip+l_max/2+ly/2)/2-((l_vmeander_max-l_vmeander_min)/',num2str(nr_meanders-2),...
                '*',num2str(idx-2),'+l_vmeander_min)/2'];
            ymax = ['(y_strip+l_max/2+ly/2)/2+((l_vmeander_max-l_vmeander_min)/',num2str(nr_meanders-2),...
                '*',num2str(idx-1),'+l_vmeander_min)/2'];
        end
    end
    sCommand = '';
    sCommand = 'With Brick';
    sCommand = func_create_sCommand(sCommand, '.Reset');
    sCommand = func_create_sCommand(sCommand, '.Name "%s"', ['vmeander',num2str(idx)]);
    sCommand = func_create_sCommand(sCommand, '.Component "%s"', compname);
    sCommand = func_create_sCommand(sCommand, '.Material "%s"', 'PEC');
    sCommand = func_create_sCommand(sCommand, '.Xrange "%s", "%s"', xmin, xmax);
    sCommand = func_create_sCommand(sCommand, '.Yrange "%s", "%s"', ymax, ymin);
    sCommand = func_create_sCommand(sCommand, '.Zrange "%s", "%s"', 'ts', 'ts+tp');
    sCommand = func_create_sCommand(sCommand, '.Create');
    sCommand = func_create_sCommand(sCommand, 'End With');
    invoke(mws, 'AddToHistory', ['define v_meander_',num2str(idx)], sCommand);
end