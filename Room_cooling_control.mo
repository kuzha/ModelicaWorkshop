model Room_cooling_control
  Buildings.Fluid.MixingVolumes.MixingVolume space(redeclare package Medium = Buildings.Media.Air "Moist air", V = 180, energyDynamics = Modelica.Fluid.Types.Dynamics.FixedInitial, nPorts = 2, m_flow_nominal = 0.646, mSenFac = 3) annotation(
    Placement(transformation(origin = {90, 80}, extent = {{-10, -10}, {10, 10}})));
  Modelica.Thermal.HeatTransfer.Sources.FixedHeatFlow internalHeatGains(Q_flow = 1000) annotation(
    Placement(transformation(origin = {30, 80}, extent = {{-10, -10}, {10, 10}})));
  Modelica.Thermal.HeatTransfer.Components.ThermalConductor thermalConductor(G = 10000/30) annotation(
    Placement(transformation(origin = {30, 50}, extent = {{-10, -10}, {10, 10}})));
  Buildings.BoundaryConditions.WeatherData.ReaderTMY3 weaDat(filNam = Modelica.Utilities.Files.loadResource("modelica://Buildings/Resources/weatherdata/USA_IL_Chicago-OHare.Intl.AP.725300_TMY3.mos")) annotation(
    Placement(transformation(origin = {-150, 50}, extent = {{-10, -10}, {10, 10}})));
  Buildings.BoundaryConditions.WeatherData.Bus weaBus annotation(
    Placement(transformation(origin = {-90, 50}, extent = {{-10, -10}, {10, 10}}), iconTransformation(origin = {-158, 36}, extent = {{-10, -10}, {10, 10}})));
  Modelica.Thermal.HeatTransfer.Sources.PrescribedTemperature TOut annotation(
    Placement(transformation(origin = {-10, 50}, extent = {{-10, -10}, {10, 10}})));
  Buildings.Fluid.HeatExchangers.ConstantEffectiveness hex(redeclare package Medium1 = Buildings.Media.Air "Moist air", redeclare package Medium2 = Buildings.Media.Air "Moist air", m1_flow_nominal = 0.646, m2_flow_nominal = 0.646, dp1_nominal = 200, dp2_nominal = 200) annotation(
    Placement(transformation(origin = {-90, 2}, extent = {{-10, -10}, {10, 10}})));
  Buildings.Fluid.Sensors.TemperatureTwoPort senTem(redeclare package Medium = Buildings.Media.Air "Moist air", m_flow_nominal = 0.646) annotation(
    Placement(transformation(origin = {-50, 8}, extent = {{-10, -10}, {10, 10}})));
  Buildings.Fluid.HeatExchangers.WetCoilEffectivenessNTU cooCoi(redeclare package Medium1 = Buildings.Media.Water "Water", redeclare package Medium2 = Buildings.Media.Air "Moist air", dp1_nominal = 6000, dp2_nominal = 200, m1_flow_nominal = 0.498, m2_flow_nominal = 0.646, use_Q_flow_nominal = true, Q_flow_nominal = -8362, T_a1_nominal = 285.15, T_a2_nominal = 298.35, w_a2_nominal = 0.0135, energyDynamics = Modelica.Fluid.Types.Dynamics.FixedInitial, show_T = true) annotation(
    Placement(transformation(origin = {-10, 2}, extent = {{10, 10}, {-10, -10}})));
  Buildings.Fluid.Sensors.TemperatureTwoPort senTem2(redeclare package Medium = Buildings.Media.Air "Moist air", m_flow_nominal = 0.646) "Temperature sensor after cooling coil" annotation(
    Placement(transformation(origin = {30, 8}, extent = {{-10, -10}, {10, 10}})));
  Buildings.Fluid.Movers.FlowControlled_m_flow fan(redeclare package Medium = Buildings.Media.Air "Moist air", m_flow_nominal = 0.646, energyDynamics = Modelica.Fluid.Types.Dynamics.SteadyState) annotation(
    Placement(transformation(origin = {70, 8}, extent = {{-10, -10}, {10, 10}})));
  Buildings.Fluid.Sources.Boundary_pT bou(nPorts = 1, redeclare package Medium = Buildings.Media.Water "Water") annotation(
    Placement(transformation(origin = {-70, -40}, extent = {{-10, -10}, {10, 10}})));
  Buildings.Fluid.Sources.MassFlowSource_T souWat(nPorts = 1, redeclare package Medium = Buildings.Media.Water "Water", m_flow = 0.498, T = 285.15, use_m_flow_in = true) annotation(
    Placement(transformation(origin = {-2, -44}, extent = {{-10, -10}, {10, 10}})));
  Buildings.Controls.OBC.CDL.Reals.Sources.Constant mAir_flow(k = 0.646) annotation(
    Placement(transformation(origin = {128, 26}, extent = {{0, 0}, {-20, 20}})));
  Modelica.Thermal.HeatTransfer.Sensors.TemperatureSensor senTemRoo annotation(
    Placement(transformation(origin = {142, 80}, extent = {{-10, -10}, {10, 10}})));
  Buildings.Controls.OBC.CDL.Reals.Hysteresis con(uLow = 273.15 + 23.5, uHigh = 273.15 + 24.5)  annotation(
    Placement(transformation(origin = {-90, -70}, extent = {{-10, -10}, {10, 10}})));
  Buildings.Controls.OBC.CDL.Conversions.BooleanToReal mWatFlo(realTrue = 0.498)  annotation(
    Placement(transformation(origin = {-50, -70}, extent = {{-10, -10}, {10, 10}})));
  Buildings.Fluid.Sources.Boundary_pT out(use_T_in = true, redeclare package Medium = Buildings.Media.Air "Moist air", nPorts = 2)  annotation(
    Placement(transformation(origin = {-132, 0}, extent = {{-10, -10}, {10, 10}})));
equation
  connect(space.heatPort, internalHeatGains.port) annotation(
    Line(points = {{80, 80}, {40, 80}}, color = {191, 0, 0}));
  connect(thermalConductor.port_b, space.heatPort) annotation(
    Line(points = {{40, 50}, {60, 50}, {60, 80}, {80, 80}}, color = {191, 0, 0}));
  connect(TOut.port, thermalConductor.port_a) annotation(
    Line(points = {{0, 50}, {20, 50}}, color = {191, 0, 0}));
  connect(hex.port_b1, senTem.port_a) annotation(
    Line(points = {{-80, 8}, {-60, 8}}, color = {0, 127, 255}));
  connect(senTem2.port_b, fan.port_a) annotation(
    Line(points = {{40, 8}, {60, 8}}, color = {0, 127, 255}));
  connect(fan.port_b, space.ports[1]) annotation(
    Line(points = {{80, 8}, {90, 8}, {90, 70}}, color = {0, 127, 255}));
  connect(space.ports[2], hex.port_a2) annotation(
    Line(points = {{90, 70}, {100, 70}, {100, -14}, {-80, -14}, {-80, -4}}, color = {0, 127, 255}));
  connect(weaDat.weaBus, weaBus) annotation(
    Line(points = {{-140, 50}, {-90, 50}}, color = {255, 204, 51}, thickness = 0.5));
  connect(mAir_flow.y, fan.m_flow_in) annotation(
    Line(points = {{106, 36}, {70, 36}, {70, 20}}, color = {0, 0, 127}));
  connect(weaBus.TDryBul, TOut.T) annotation(
    Line(points = {{-90, 50}, {-22, 50}}, color = {0, 0, 127}));
  connect(senTem.port_b, cooCoi.port_a2) annotation(
    Line(points = {{-40, 8}, {-20, 8}}, color = {0, 127, 255}));
  connect(cooCoi.port_b2, senTem2.port_a) annotation(
    Line(points = {{0, 8}, {20, 8}}, color = {0, 127, 255}));
  connect(bou.ports[1], cooCoi.port_b1) annotation(
    Line(points = {{-60, -40}, {-40, -40}, {-40, -4}, {-20, -4}}, color = {0, 127, 255}));
  connect(souWat.ports[1], cooCoi.port_a1) annotation(
    Line(points = {{8, -44}, {16, -44}, {16, -4}, {0, -4}}, color = {0, 127, 255}));
  connect(senTemRoo.port, space.heatPort) annotation(
    Line(points = {{132, 80}, {120, 80}, {120, 100}, {60, 100}, {60, 80}, {80, 80}}, color = {191, 0, 0}));
  connect(con.y, mWatFlo.u) annotation(
    Line(points = {{-78, -70}, {-62, -70}}, color = {255, 0, 255}));
  connect(mWatFlo.y, souWat.m_flow_in) annotation(
    Line(points = {{-38, -70}, {-26, -70}, {-26, -36}, {-14, -36}}, color = {0, 0, 127}));
  connect(weaBus.TDryBul, out.T_in) annotation(
    Line(points = {{-90, 50}, {-90, 32}, {-150, 32}, {-150, 4}, {-144, 4}}, color = {0, 0, 127}));
  connect(out.ports[1], hex.port_a1) annotation(
    Line(points = {{-122, 0}, {-118, 0}, {-118, 8}, {-100, 8}}, color = {0, 127, 255}));
  connect(out.ports[2], hex.port_b2) annotation(
    Line(points = {{-122, 0}, {-118, 0}, {-118, -4}, {-100, -4}}, color = {0, 127, 255}));
  connect(senTemRoo.T, con.u) annotation(
    Line(points = {{154, 80}, {158, 80}, {158, -90}, {-120, -90}, {-120, -70}, {-102, -70}}, color = {0, 0, 127}));
protected
  annotation(
    uses(Buildings(version = "13.0.0"), Modelica(version = "4.1.0")),
    Diagram(coordinateSystem(extent = {{-160, 120}, {160, -100}})),
    Icon(coordinateSystem(extent = {{-100, -100}, {100, 100}}), graphics = {Ellipse(lineColor = {75, 138, 73}, fillColor = {255, 255, 255}, fillPattern = FillPattern.Solid, extent = {{-100, -100}, {100, 100}}), Polygon(lineColor = {0, 0, 255}, fillColor = {75, 138, 73}, pattern = LinePattern.None, fillPattern = FillPattern.Solid, points = {{-36, 60}, {64, 0}, {-36, -60}, {-36, 60}})}),
    version = "",
    __OpenModelica_simulationFlags(lv = "LOG_STDOUT,LOG_ASSERT,LOG_STATS", s = "dassl", variableFilter = ".*"),
    experiment(StartTime = 1.5552e+07, StopTime = 1.56384e+07, Tolerance = 1e-06, Interval = 173.146));
end Room_cooling_control;