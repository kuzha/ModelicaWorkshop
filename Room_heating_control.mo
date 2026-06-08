model Room_heating_control
  Buildings.Controls.OBC.CDL.Reals.Hysteresis con(uHigh = 273.15 + 22, uLow = 273.15 + 20) annotation(
    Placement(transformation(origin = {-84, 0}, extent = {{-10, -10}, {10, 10}})));
  Buildings.Fluid.HeatExchangers.HeaterCooler_u hea(redeclare package Medium = Buildings.Media.Water "Water", Q_flow_nominal = 40000, allowFlowReversal = false, dp_nominal = 2000, m_flow_nominal = 40000/4200/20) annotation(
    Placement(transformation(origin = {40, -20}, extent = {{-10, -10}, {10, 10}})));
  Modelica.Thermal.HeatTransfer.Sources.PrescribedTemperature TOut annotation(
    Placement(transformation(origin = {-16, 40}, extent = {{-10, -10}, {10, 10}})));
  Modelica.Thermal.HeatTransfer.Sources.FixedHeatFlow internalHeatGains(Q_flow = 1000) annotation(
    Placement(transformation(origin = {20, 72}, extent = {{-10, -10}, {10, 10}})));
  Buildings.Fluid.Movers.FlowControlled_m_flow pump(redeclare package Medium = Buildings.Media.Water "Water", allowFlowReversal = false, energyDynamics = Modelica.Fluid.Types.Dynamics.FixedInitial, m_flow_nominal = 40000/4200/20) annotation(
    Placement(transformation(origin = {40, -60}, extent = {{10, -10}, {-10, 10}})));
  Buildings.BoundaryConditions.WeatherData.Bus weaBus annotation(
    Placement(transformation(origin = {-48, 40}, extent = {{-10, -10}, {10, 10}}), iconTransformation(origin = {-48, 40}, extent = {{-10, -10}, {10, 10}})));
  Buildings.Fluid.MixingVolumes.MixingVolume space(redeclare package Medium = Buildings.Media.Air "Moist air", V = 180, energyDynamics = Modelica.Fluid.Types.Dynamics.FixedInitial, mSenFac = 3, m_flow_nominal = 180*1.2*1/3600) annotation(
    Placement(transformation(origin = {100, 72}, extent = {{-10, -10}, {10, 10}})));
  Modelica.Thermal.HeatTransfer.Components.ThermalConductor thermalConductor(G = 10000/30) annotation(
    Placement(transformation(origin = {22, 40}, extent = {{-10, -10}, {10, 10}})));
  Buildings.Fluid.HeatExchangers.Radiators.RadiatorEN442_2 rad(redeclare package Medium = Buildings.Media.Water "Water", Q_flow_nominal = 40000, T_a_nominal = 333.15, T_b_nominal = 313.15, allowFlowReversal = false) annotation(
    Placement(transformation(origin = {80, -20}, extent = {{-10, -10}, {10, 10}})));
  Buildings.BoundaryConditions.WeatherData.ReaderTMY3 weaDat(filNam = "C:/Users/kuzhang/Documents/modelica-buildings/Buildings/Resources/weatherdata/USA_IL_Chicago-OHare.Intl.AP.725300_TMY3.mos") annotation(
    Placement(transformation(origin = {-82, 40}, extent = {{-10, -10}, {10, 10}})));
  Buildings.Fluid.Sources.Boundary_pT bou(redeclare package Medium = Buildings.Media.Water "Water", nPorts = 2) annotation(
    Placement(transformation(origin = {-20, -60}, extent = {{-10, -10}, {10, 10}})));
  Modelica.Thermal.HeatTransfer.Sensors.TemperatureSensor temperatureSensor annotation(
    Placement(transformation(origin = {-112, 0}, extent = {{-10, -10}, {10, 10}})));
  Buildings.Controls.OBC.CDL.Logical.Not not1 annotation(
    Placement(transformation(origin = {-54, 0}, extent = {{-10, -10}, {10, 10}})));
  Buildings.Controls.OBC.CDL.Conversions.BooleanToReal HeatCon annotation(
    Placement(transformation(origin = {-10, 0}, extent = {{-10, -10}, {10, 10}})));
  Buildings.Controls.OBC.CDL.Conversions.BooleanToReal pumCon(realTrue = 40000/4200/20)  annotation(
    Placement(transformation(origin = {-10, -30}, extent = {{-10, -10}, {10, 10}})));
equation
  connect(weaBus.TDryBul, TOut.T) annotation(
    Line(points = {{-48, 40}, {-28, 40}}, color = {0, 0, 127}));
  connect(space.heatPort, rad.heatPortCon) annotation(
    Line(points = {{90, 72}, {58, 72}, {58, -13}, {78, -13}}, color = {191, 0, 0}));
  connect(pump.port_b, bou.ports[2]) annotation(
    Line(points = {{30, -60}, {-10, -60}}, color = {0, 127, 255}));
  connect(rad.port_b, pump.port_a) annotation(
    Line(points = {{90, -20}, {96, -20}, {96, -60}, {50, -60}}, color = {0, 127, 255}));
  connect(bou.ports[1], hea.port_a) annotation(
    Line(points = {{-10, -60}, {20, -60}, {20, -20}, {30, -20}}, color = {0, 127, 255}));
  connect(TOut.port, thermalConductor.port_a) annotation(
    Line(points = {{-6, 40}, {12, 40}}, color = {191, 0, 0}));
  connect(space.heatPort, internalHeatGains.port) annotation(
    Line(points = {{90, 72}, {30, 72}}, color = {191, 0, 0}));
  connect(rad.heatPortRad, space.heatPort) annotation(
    Line(points = {{82, -13}, {82, 72.75}, {84, 72.75}, {84, 72.375}, {90, 72.375}, {90, 72}}, color = {191, 0, 0}));
  connect(weaDat.weaBus, weaBus) annotation(
    Line(points = {{-72, 40}, {-48, 40}}, color = {255, 204, 51}));
  connect(thermalConductor.port_b, space.heatPort) annotation(
    Line(points = {{32, 40}, {42, 40}, {42, 72}, {90, 72}}, color = {191, 0, 0}));
  connect(hea.port_b, rad.port_a) annotation(
    Line(points = {{50, -20}, {70, -20}}, color = {0, 127, 255}));
  connect(temperatureSensor.T, con.u) annotation(
    Line(points = {{-101, 0}, {-97, 0}}, color = {0, 0, 127}));
  connect(internalHeatGains.port, temperatureSensor.port) annotation(
    Line(points = {{30, 72}, {42, 72}, {42, 86}, {-140, 86}, {-140, 0}, {-122, 0}}, color = {191, 0, 0}));
  connect(con.y, not1.u) annotation(
    Line(points = {{-72, 0}, {-66, 0}}, color = {255, 0, 255}));
  connect(not1.y, HeatCon.u) annotation(
    Line(points = {{-42, 0}, {-22, 0}}, color = {255, 0, 255}));
  connect(HeatCon.y, hea.u) annotation(
    Line(points = {{2, 0}, {10, 0}, {10, -12}, {28, -12}, {28, -14}}, color = {0, 0, 127}));
  connect(not1.y, pumCon.u) annotation(
    Line(points = {{-42, 0}, {-34, 0}, {-34, -30}, {-22, -30}}, color = {255, 0, 255}));
  connect(pumCon.y, pump.m_flow_in) annotation(
    Line(points = {{2, -30}, {14, -30}, {14, -40}, {40, -40}, {40, -48}}, color = {0, 0, 127}));
  annotation(
    Diagram(coordinateSystem(extent = {{-150, -100}, {150, 100}})),
    version = "",
    uses(Buildings(version = "13.0.0"), Modelica(version = "4.1.0")),
    Icon(coordinateSystem(extent = {{-100, -100}, {100, 100}}), graphics = {Ellipse(lineColor = {75, 138, 73}, fillColor = {255, 255, 255}, fillPattern = FillPattern.Solid, extent = {{-100, -100}, {100, 100}}), Polygon(lineColor = {0, 0, 255}, fillColor = {75, 138, 73}, pattern = LinePattern.None, fillPattern = FillPattern.Solid, points = {{-36, 60}, {64, 0}, {-36, -60}, {-36, 60}})}),
  experiment(StartTime = 0, StopTime = 86400, Tolerance = 1e-6, Interval = 172.8));
end Room_heating_control;
