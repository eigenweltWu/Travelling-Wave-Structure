function func_initialization(mws,par_list)
    % Define Parameter
    keys = par_list.keys();
    values = par_list.values();
    for i = 1:length(keys)
        func_register_par(mws,keys{i},values{i});
    end
    
    % Define Material
    sCommand = '';
    sCommand = 'With Material';
    sCommand = func_create_sCommand(sCommand, '.Reset');
    sCommand = func_create_sCommand(sCommand, '.Name "%s"', 'felt');
    sCommand = func_create_sCommand(sCommand, '.Folder "%s"', '');
    sCommand = func_create_sCommand(sCommand, '.Rho "%s"', '0');
    sCommand = func_create_sCommand(sCommand, '.ThermalType "%s"', 'Normal');
    sCommand = func_create_sCommand(sCommand, '.ThermalConductivity "%s"', '0');
    sCommand = func_create_sCommand(sCommand, '.SpecificHeat "%s", "%s"', '0', 'J/K/kg');
    sCommand = func_create_sCommand(sCommand, '.DynamicViscosity "%s"', '0');
    sCommand = func_create_sCommand(sCommand, '.UseEmissivity "%s"', 'True');
    sCommand = func_create_sCommand(sCommand, '.Emissivity "%s"', '0');
    sCommand = func_create_sCommand(sCommand, '.MetabolicRate "%s"', '0.0');
    sCommand = func_create_sCommand(sCommand, '.VoxelConvection "%s"', '0.0');
    sCommand = func_create_sCommand(sCommand, '.BloodFlow "%s"', '0');
    sCommand = func_create_sCommand(sCommand, '.Absorptance "%s"', '0');
    sCommand = func_create_sCommand(sCommand, '.MechanicsType "%s"', 'Unused');
    sCommand = func_create_sCommand(sCommand, '.IntrinsicCarrierDensity "%s"', '0');
    sCommand = func_create_sCommand(sCommand, '.FrqType "%s"', 'all');
    sCommand = func_create_sCommand(sCommand, '.Type "%s"', 'Normal');
    sCommand = func_create_sCommand(sCommand, '.MaterialUnit "%s", "%s"', 'Frequency', 'GHz');
    sCommand = func_create_sCommand(sCommand, '.MaterialUnit "%s", "%s"', 'Geometry', 'mm');
    sCommand = func_create_sCommand(sCommand, '.MaterialUnit "%s", "%s"', 'Time', 'ns');
    sCommand = func_create_sCommand(sCommand, '.MaterialUnit "%s", "%s"', 'Temperature', 'K');
    sCommand = func_create_sCommand(sCommand, '.Epsilon "%s"', '1.2');
    sCommand = func_create_sCommand(sCommand, '.Mu "%s"', '1');
    sCommand = func_create_sCommand(sCommand, '.Sigma "%s"', '0');
    sCommand = func_create_sCommand(sCommand, '.TanD "%s"', '0.0');
    sCommand = func_create_sCommand(sCommand, '.TanDFreq "%s"', '0.0');
    sCommand = func_create_sCommand(sCommand, '.TanDGiven "%s"', 'False');
    sCommand = func_create_sCommand(sCommand, '.TanDModel "%s"', 'ConstTanD');
    sCommand = func_create_sCommand(sCommand, '.SetConstTanDStrategyEps "%s"', 'AutomaticOrder');
    sCommand = func_create_sCommand(sCommand, '.ConstTanDModelOrderEps "%s"', '3');
    sCommand = func_create_sCommand(sCommand, '.DjordjevicSarkarUpperFreqEps "%s"', '0');
    sCommand = func_create_sCommand(sCommand, '.SetElParametricConductivity "%s"', 'False');
    sCommand = func_create_sCommand(sCommand, '.ReferenceCoordSystem "%s"', 'Global');
    sCommand = func_create_sCommand(sCommand, '.CoordSystemType "%s"', 'Cartesian');
    sCommand = func_create_sCommand(sCommand, '.SigmaM "%s"', '0');
    sCommand = func_create_sCommand(sCommand, '.TanDM "%s"', '0.0');
    sCommand = func_create_sCommand(sCommand, '.TanDMFreq "%s"', '0.0');
    sCommand = func_create_sCommand(sCommand, '.TanDMGiven "%s"', 'False');
    sCommand = func_create_sCommand(sCommand, '.TanDMModel "%s"', 'ConstTanD');
    sCommand = func_create_sCommand(sCommand, '.SetConstTanDStrategyMu "%s"', 'AutomaticOrder');
    sCommand = func_create_sCommand(sCommand, '.ConstTanDModelOrderMu "%s"', '3');
    sCommand = func_create_sCommand(sCommand, '.DjordjevicSarkarUpperFreqMu "%s"', '0');
    sCommand = func_create_sCommand(sCommand, '.SetMagParametricConductivity "%s"', 'False');
    sCommand = func_create_sCommand(sCommand, '.DispModelEps "%s"', 'None');
    sCommand = func_create_sCommand(sCommand, '.DispModelMu "%s"', 'None');
    sCommand = func_create_sCommand(sCommand, '.DispersiveFittingSchemeEps "%s"', 'Nth Order');
    sCommand = func_create_sCommand(sCommand, '.MaximalOrderNthModelFitEps "%s"', '10');
    sCommand = func_create_sCommand(sCommand, '.ErrorLimitNthModelFitEps "%s"', '0.1');
    sCommand = func_create_sCommand(sCommand, '.DispersiveFittingSchemeMu "%s"', 'Nth Order');
    sCommand = func_create_sCommand(sCommand, '.MaximalOrderNthModelFitMu "%s"', '10');
    sCommand = func_create_sCommand(sCommand, '.ErrorLimitNthModelFitMu "%s"', '0.1');
    sCommand = func_create_sCommand(sCommand, '.UseGeneralDispersionEps "%s"', 'False');
    sCommand = func_create_sCommand(sCommand, '.UseGeneralDispersionMu "%s"', 'False');
    sCommand = func_create_sCommand(sCommand, '.NLAnisotropy "%s"', 'False');
    sCommand = func_create_sCommand(sCommand, '.NLAStackingFactor "%s"', '1');
    sCommand = func_create_sCommand(sCommand, '.NLADirectionX "%s"', '1');
    sCommand = func_create_sCommand(sCommand, '.NLADirectionY "%s"', '0');
    sCommand = func_create_sCommand(sCommand, '.NLADirectionZ "%s"', '0');
    sCommand = func_create_sCommand(sCommand, '.Colour "%s", "%s", "%s"', '1', '0.501961', '0');
    sCommand = func_create_sCommand(sCommand, '.Wireframe "%s"', 'False');
    sCommand = func_create_sCommand(sCommand, '.Reflection "%s"', 'False');
    sCommand = func_create_sCommand(sCommand, '.Allowoutline "%s"', 'True');
    sCommand = func_create_sCommand(sCommand, '.Transparentoutline "%s"', 'False');
    sCommand = func_create_sCommand(sCommand, '.Transparency "%s"', '0');
    sCommand = func_create_sCommand(sCommand, '.Create');
    sCommand = func_create_sCommand(sCommand, 'End With');
    invoke(mws, 'AddToHistory', 'define material: felt', sCommand);

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

end