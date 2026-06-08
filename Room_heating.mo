model Room_heating
  Buildings.Fluid.MixingVolumes.MixingVolume space(redeclare package Medium = Buildings.Media.Air "Moist air", V = 180, energyDynamics = Modelica.Fluid.Types.Dynamics.FixedInitial, mSenFac = 3, m_flow_nominal = 180*1.2*1/3600) annotation(
    Placement(transformation(origin = {70, 72}, extent = {{-10, -10}, {10, 10}})));
  Modelica.Thermal.HeatTransfer.Components.ThermalConductor thermalConductor(G = 10000/30) annotation(
    Placement(transformation(origin = {22, 40}, extent = {{-10, -10}, {10, 10}})));
  Modelica.Thermal.HeatTransfer.Sources.PrescribedTemperature TOut annotation(
    Placement(transformation(origin = {-16, 40}, extent = {{-10, -10}, {10, 10}})));
  Buildings.BoundaryConditions.WeatherData.Bus weaBus annotation(
    Placement(transformation(origin = {-48, 40}, extent = {{-10, -10}, {10, 10}}), iconTransformation(origin = {-48, 20}, extent = {{-10, -10}, {10, 10}})));
  Modelica.Thermal.HeatTransfer.Sources.FixedHeatFlow internalHeatGains(Q_flow = 1000) annotation(
    Placement(transformation(origin = {20, 72}, extent = {{-10, -10}, {10, 10}})));
  Buildings.BoundaryConditions.WeatherData.ReaderTMY3 weaDat(filNam = "C:/Users/kuzhang/Documents/modelica-buildings/Buildings/Resources/weatherdata/USA_IL_Chicago-OHare.Intl.AP.725300_TMY3.mos") annotation(
    Placement(transformation(origin = {-82, 40}, extent = {{-10, -10}, {10, 10}})));
  Buildings.Fluid.HeatExchangers.Radiators.RadiatorEN442_2 rad(redeclare package Medium = Buildings.Media.Water "Water", T_a_nominal = 333.15, T_b_nominal = 313.15, Q_flow_nominal = 40000, allowFlowReversal = false)  annotation(
    Placement(transformation(origin = {70, -20}, extent = {{-10, -10}, {10, 10}})));
  Buildings.Fluid.HeatExchangers.HeaterCooler_u hea(m_flow_nominal = 0.48, dp_nominal = 2000, Q_flow_nominal = 40000, redeclare package Medium = Buildings.Media.Water "Water", allowFlowReversal = false)  annotation(
    Placement(transformation(origin = {30, -20}, extent = {{-10, -10}, {10, 10}})));
  Buildings.Fluid.Movers.FlowControlled_m_flow pump(redeclare package Medium = Buildings.Media.Water "Water", m_flow_nominal = 0.48, energyDynamics = Modelica.Fluid.Types.Dynamics.FixedInitial, allowFlowReversal = false)  annotation(
    Placement(transformation(origin = {30, -60}, extent = {{10, -10}, {-10, 10}}, rotation = -0)));
  Buildings.Fluid.Sources.Boundary_pT bou(nPorts = 2, redeclare package Medium = Buildings.Media.Water "Water")  annotation(
    Placement(transformation(origin = {-30, -60}, extent = {{-10, -10}, {10, 10}})));
  Modelica.Blocks.Sources.Constant heaCon(k = 1)  annotation(
    Placement(transformation(origin = {-10, 0}, extent = {{-10, -10}, {10, 10}})));
  Modelica.Blocks.Sources.Constant watFlow(k = 0.48) annotation(
    Placement(transformation(origin = {106, -40}, extent = {{10, -10}, {-10, 10}}, rotation = -0)));
equation
  connect(TOut.port, thermalConductor.port_a) annotation(
    Line(points = {{-6, 40}, {12, 40}}, color = {191, 0, 0}));
  connect(weaDat.weaBus, weaBus) annotation(
    Line(points = {{-72, 40}, {-48, 40}}, color = {255, 204, 51}));
  connect(thermalConductor.port_b, space.heatPort) annotation(
    Line(points = {{32, 40}, {42, 40}, {42, 72}, {60, 72}}, color = {191, 0, 0}));
  connect(weaBus.TDryBul, TOut.T) annotation(
    Line(points = {{-48, 40}, {-28, 40}}, color = {0, 0, 127}));
  connect(space.heatPort, internalHeatGains.port) annotation(
    Line(points = {{60, 72}, {30, 72}}, color = {191, 0, 0}));
  connect(bou.ports[1], hea.port_a) annotation(
    Line(points = {{-20, -60}, {-8, -60}, {-8, -20}, {20, -20}}, color = {0, 127, 255}));
  connect(hea.port_b, rad.port_a) annotation(
    Line(points = {{40, -20}, {60, -20}}, color = {0, 127, 255}));
  connect(space.heatPort, rad.heatPortCon) annotation(
    Line(points = {{60, 72}, {58, 72}, {58, -12}, {68, -12}}, color = {191, 0, 0}));
  connect(rad.heatPortRad, space.heatPort) annotation(
    Line(points = {{72, -12.8}, {60, -12.8}, {60, 71.2}}, color = {191, 0, 0}));
  connect(heaCon.y, hea.u) annotation(
    Line(points = {{1, 0}, {8, 0}, {8, -14}, {18, -14}}, color = {0, 0, 127}));
  connect(watFlow.y, pump.m_flow_in) annotation(
    Line(points = {{95, -40}, {30, -40}, {30, -48}}, color = {0, 0, 127}));
  connect(rad.port_b, pump.port_a) annotation(
    Line(points = {{80, -20}, {86, -20}, {86, -60}, {40, -60}}, color = {0, 127, 255}));
  connect(pump.port_b, bou.ports[2]) annotation(
    Line(points = {{20, -60}, {-20, -60}}, color = {0, 127, 255}));
  annotation(
    uses(Buildings(version = "13.0.0"), Modelica(version = "4.1.0")),
  Diagram(coordinateSystem(extent = {{-120, -100}, {120, 100}})),
  version = "",
  experiment(StartTime = 0, StopTime = 86400, Tolerance = 1e-6, Interval = 172.8),
  Icon(graphics = {Ellipse(lineColor = {75, 138, 73}, fillColor = {255, 255, 255}, fillPattern = FillPattern.Solid, extent = {{-100, -100}, {100, 100}}), Polygon(lineColor = {0, 0, 255}, fillColor = {75, 138, 73}, pattern = LinePattern.None, fillPattern = FillPattern.Solid, points = {{-36, 60}, {64, 0}, {-36, -60}, {-36, 60}})}));end Room_heating;
end Room_heating;