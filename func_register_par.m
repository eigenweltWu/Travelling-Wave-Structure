function check = func_register_par(mws,parname, parvalue)
    check = 0;
    if endsWith(parname,'!')
        invoke(mws,'StoreParameter',num2str(parname(1:end-1)),num2str(parvalue));
    else
        check = invoke(mws, 'DoesParameterExist', num2str(parname));
        if ~check
            invoke(mws,'StoreParameter',num2str(parname),num2str(parvalue));
        end
    end
end