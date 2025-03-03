function check = func_register_par(mws,parname, parvalue)
    check = invoke(mws, 'DoesParameterExist', num2str(parname));
    invoke(mws,'StoreParameter',num2str(parname),num2str(parvalue));
end