% direction_xy: x y
% period_d, begining_x, begining_y, grating_nr: a number
% generate_func: string, generation function in the same folder
function func_generate_grating(direction_xy, grating_nr, generate_func, input_par)
    global grating;
    d = dictionary();
    d('direction') = direction_xy;
    d('nr') = grating_nr;
    d('func') = generate_func;
    d('par') = input_par;
    grating = [grating,{d}];
end