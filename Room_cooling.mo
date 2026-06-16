model Room_cooling
  extends Modelica.Icons.Example;
  Buildings.Fluid.MixingVolumes.MixingVolume zon(redeclare package Medium = Buildings.Media.Air "Moist air", m_flow_nominal = 0.646, V = 180, mSenFac = 3, nPorts = 2) annotation(
    Placement(transformation(origin = {110, 48}, extent = {{-10, -10}, {10, 10}})));
  Modelica.Thermal.HeatTransfer.Components.ThermalConductor thermalConductor(G = 10000/30) annotation(
    Placement(transformation(origin = {50, 48}, extent = {{-10, -10}, {10, 10}})));
  Modelica.Thermal.HeatTransfer.Sources.PrescribedTemperature TOut annotation(
    Placement(transformation(origin = {10, 70}, extent = {{-10, -10}, {10, 10}})));
  Buildings.BoundaryConditions.WeatherData.ReaderTMY3 weaDat(filNam = Modelica.Utilities.Files.loadResource("modelica://Buildings/Resources/weatherdata/USA_IL_Chicago-OHare.Intl.AP.725300_TMY3.mos"), TDryBul(displayUnit = "K"), TDryBulSou = Buildings.BoundaryConditions.Types.DataSource.File) annotation(
    Placement(transformation(origin = {-50, 70}, extent = {{-10, -10}, {10, 10}})));
  Buildings.BoundaryConditions.WeatherData.Bus weaBus annotation(
    Placement(transformation(origin = {-20, 70}, extent = {{-10, -10}, {10, 10}}), iconTransformation(origin = {-48, -40}, extent = {{-10, -10}, {10, 10}})));
  Modelica.Thermal.HeatTransfer.Sources.FixedHeatFlow intGains(Q_flow = 1000) annotation(
    Placement(transformation(origin = {50, 90}, extent = {{-10, -10}, {10, 10}})));
  Buildings.Fluid.Sources.Boundary_pT outAir(nPorts = 2, use_T_in = true, redeclare package Medium = Buildings.Media.Air "Moist air") annotation(
    Placement(transformation(origin = {-132, -4}, extent = {{-10, -10}, {10, 10}})));
  Buildings.Fluid.HeatExchangers.ConstantEffectiveness hex(redeclare package Medium1 = Buildings.Media.Air "Moist air", redeclare package Medium2 = Buildings.Media.Air "Moist air", m1_flow_nominal = 0.646, m2_flow_nominal = 0.646, dp1_nominal = 200, dp2_nominal = 200) annotation(
    Placement(transformation(origin = {-92, -6}, extent = {{-10, -10}, {10, 10}})));
  Buildings.Fluid.Sensors.TemperatureTwoPort senTem(m_flow_nominal = 0.646, redeclare package Medium = Buildings.Media.Air "Moist air") annotation(
    Placement(transformation(origin = {-52, 0}, extent = {{-10, -10}, {10, 10}})));
  Buildings.Fluid.Sensors.TemperatureTwoPort senTem1(m_flow_nominal = 0.646, redeclare package Medium = Buildings.Media.Air "Moist air") annotation(
    Placement(transformation(origin = {28, 0}, extent = {{-10, -10}, {10, 10}})));
  Buildings.Fluid.HeatExchangers.WetCoilEffectivenessNTU cooCoil(redeclare package Medium1 = Buildings.Media.Water "Water", redeclare package Medium2 = Buildings.Media.Air "Moist air", m1_flow_nominal = 0.496, m2_flow_nominal = 0.646, dp1_nominal = 6000, dp2_nominal = 200, use_Q_flow_nominal = true, Q_flow_nominal = -8362, T_a1_nominal = 285.15, T_a2_nominal = 298.35, w_a2_nominal = 0.0135, energyDynamics = Modelica.Fluid.Types.Dynamics.FixedInitial) annotation(
    Placement(transformation(origin = {-10, -6}, extent = {{-10, 10}, {10, -10}})));
  Buildings.Fluid.Movers.FlowControlled_m_flow fan(redeclare package Medium = Buildings.Media.Air "Moist air", m_flow_nominal = 0.646, energyDynamics = Modelica.Fluid.Types.Dynamics.SteadyState) annotation(
    Placement(transformation(origin = {70, 0}, extent = {{-10, -10}, {10, 10}})));
  Buildings.Controls.OBC.CDL.Reals.Sources.Constant flowCtrl(k = 0.646) annotation(
    Placement(transformation(origin = {144, 30}, extent = {{10, -10}, {-10, 10}})));
  Buildings.Fluid.Sources.MassFlowSource_T chiWatSource(nPorts = 1, redeclare package Medium = Buildings.Media.Water "Water", m_flow = 0.498, T = 285.15) annotation(
    Placement(transformation(origin = {8, -62}, extent = {{-10, -10}, {10, 10}}, rotation = 90)));
  Buildings.Fluid.Sources.Boundary_pT chiWatSink(nPorts = 1, redeclare package Medium = Buildings.Media.Water "Water") annotation(
    Placement(transformation(origin = {-34, -62}, extent = {{-10, -10}, {10, 10}}, rotation = 90)));
equation
  connect(weaDat.weaBus, weaBus) annotation(
    Line(points = {{-40, 70}, {-20, 70}}, color = {255, 204, 51}, thickness = 0.5));
  connect(weaBus.TDryBul, TOut.T) annotation(
    Line(points = {{-20, 70}, {-2, 70}}, color = {0, 0, 127}));
  connect(TOut.port, thermalConductor.port_a) annotation(
    Line(points = {{20, 70}, {30, 70}, {30, 48}, {40, 48}}, color = {191, 0, 0}));
  connect(thermalConductor.port_b, zon.heatPort) annotation(
    Line(points = {{60, 48}, {100, 48}}, color = {191, 0, 0}));
  connect(intGains.port, zon.heatPort) annotation(
    Line(points = {{60, 90}, {80, 90}, {80, 48}, {100, 48}}, color = {191, 0, 0}));
  connect(senTem1.port_b, fan.port_a) annotation(
    Line(points = {{38, 0}, {60, 0}}, color = {0, 127, 255}));
  connect(hex.port_b1, senTem.port_a) annotation(
    Line(points = {{-82, 0}, {-62, 0}}, color = {0, 127, 255}));
  connect(zon.ports[1], hex.port_a2) annotation(
    Line(points = {{110, 38}, {114, 38}, {114, -34}, {-76, -34}, {-76, -12}, {-82, -12}}, color = {0, 127, 255}));
  connect(outAir.ports[1], hex.port_a1) annotation(
    Line(points = {{-122, -4}, {-112, -4}, {-112, 0}, {-102, 0}}, color = {0, 127, 255}));
  connect(flowCtrl.y, fan.m_flow_in) annotation(
    Line(points = {{132, 30}, {70, 30}, {70, 12}}, color = {0, 0, 127}));
  connect(weaBus.TDryBul, outAir.T_in) annotation(
    Line(points = {{-20, 70}, {-20, 40}, {-152, 40}, {-152, 0}, {-144, 0}}, color = {0, 0, 127}));
  connect(hex.port_b2, outAir.ports[2]) annotation(
    Line(points = {{-102, -12}, {-122, -12}, {-122, -4}}, color = {0, 127, 255}));
  connect(senTem.port_b, cooCoil.port_b2) annotation(
    Line(points = {{-42, 0}, {-20, 0}}, color = {0, 127, 255}));
  connect(cooCoil.port_a2, senTem1.port_a) annotation(
    Line(points = {{0, 0}, {18, 0}}, color = {0, 127, 255}));
  connect(chiWatSink.ports[1], cooCoil.port_a1) annotation(
    Line(points = {{-34, -52}, {-34, -12}, {-20, -12}}, color = {0, 127, 255}));
  connect(cooCoil.port_b1, chiWatSource.ports[1]) annotation(
    Line(points = {{0, -12}, {8, -12}, {8, -52}}, color = {0, 127, 255}));
  connect(fan.port_b, zon.ports[2]) annotation(
    Line(points = {{80, 0}, {110, 0}, {110, 38}}, color = {0, 127, 255}));
  annotation(
    uses(Buildings(version = "13.0.0"), Modelica(version = "4.1.0")),
  Diagram(coordinateSystem(extent = {{-160, -100}, {160, 100}})),
    version = "",
  Icon(coordinateSystem(extent = {{-100, -100}, {100, 100}})),
  experiment(StartTime = 15552000, StopTime = 15638400, Tolerance = 1e-06, Interval = 172.8));
end Room_cooling;
