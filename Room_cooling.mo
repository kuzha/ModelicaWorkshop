model Room_cooling
  extends Modelica.Icons.Example;
  Buildings.Fluid.MixingVolumes.MixingVolume zon(redeclare package Medium = Buildings.Media.Air "Moist air", V = 180, mSenFac = 3, m_flow_nominal = 0.646, nPorts = 2, energyDynamics = Modelica.Fluid.Types.Dynamics.FixedInitial, T_start = 293.15) annotation(
    Placement(transformation(origin = {116, 92}, extent = {{-10, -10}, {10, 10}})));
  Modelica.Thermal.HeatTransfer.Components.ThermalConductor theCon(G = 10000/30) annotation(
    Placement(transformation(origin = {10, 92}, extent = {{-10, -10}, {10, 10}})));
  Modelica.Thermal.HeatTransfer.Sources.PrescribedTemperature preTem annotation(
    Placement(transformation(origin = {-30, 92}, extent = {{-10, -10}, {10, 10}})));
  Buildings.BoundaryConditions.WeatherData.ReaderTMY3 weaDat(filNam = "/home/kun/Documents/modelica-buildings/Buildings/Resources/weatherdata/USA_IL_Chicago-OHare.Intl.AP.725300_TMY3.mos") annotation(
    Placement(transformation(origin = {-90, 92}, extent = {{-10, -10}, {10, 10}})));
  Buildings.BoundaryConditions.WeatherData.Bus weaBus annotation(
    Placement(transformation(origin = {-62, 92}, extent = {{-10, -10}, {10, 10}}), iconTransformation(origin = {-28, 36}, extent = {{-10, -10}, {10, 10}})));
  Modelica.Thermal.HeatTransfer.Sources.FixedHeatFlow fixHeaFlo(Q_flow = 1000) annotation(
    Placement(transformation(origin = {10, 58}, extent = {{-10, -10}, {10, 10}})));
  Buildings.Fluid.Sources.Boundary_pT outAir(nPorts = 2, redeclare package Medium = Buildings.Media.Air "Moist air", use_T_in = true) annotation(
    Placement(transformation(origin = {-110, 14}, extent = {{-10, -10}, {10, 10}})));
  Buildings.Fluid.HeatExchangers.ConstantEffectiveness hex(allowFlowReversal1 = false, allowFlowReversal2 = false, redeclare package Medium1 = Buildings.Media.Air "Moist air", redeclare package Medium2 = Buildings.Media.Air "Moist air", m1_flow_nominal = 0.646, m2_flow_nominal = 0.646, dp1_nominal = 200, dp2_nominal = 200) annotation(
    Placement(transformation(origin = {-70, 16}, extent = {{-10, -10}, {10, 10}})));
  Buildings.Fluid.Sensors.TemperatureTwoPort senTem(redeclare package Medium = Buildings.Media.Air "Moist air", m_flow_nominal = 0.646) annotation(
    Placement(transformation(origin = {-32, 22}, extent = {{-10, -10}, {10, 10}})));
  Buildings.Fluid.Sensors.TemperatureTwoPort senTem1(redeclare package Medium = Buildings.Media.Air "Moist air", m_flow_nominal = 0.646) annotation(
    Placement(transformation(origin = {50, 22}, extent = {{-10, -10}, {10, 10}})));
  Buildings.Fluid.HeatExchangers.WetCoilEffectivenessNTU cooCoi(allowFlowReversal1 = false, allowFlowReversal2 = false, m1_flow_nominal = 0.498, m2_flow_nominal = 0.646, dp1_nominal = 6000, dp2_nominal = 200, use_Q_flow_nominal = true, Q_flow_nominal = -8362, T_a1_nominal = 285.15, T_a2_nominal = 298.35, w_a2_nominal = 0.0135, energyDynamics = Modelica.Fluid.Types.Dynamics.FixedInitial, redeclare package Medium1 = Buildings.Media.Water "Water", redeclare package Medium2 = Buildings.Media.Air "Moist air") annotation(
    Placement(transformation(origin = {10, 16}, extent = {{10, 10}, {-10, -10}})));
  Buildings.Fluid.Movers.FlowControlled_m_flow fan(redeclare package Medium = Buildings.Media.Air "Moist air", m_flow_nominal = 0.646, energyDynamics = Modelica.Fluid.Types.Dynamics.FixedInitial) annotation(
    Placement(transformation(origin = {90, 22}, extent = {{-10, -10}, {10, 10}})));
  Buildings.Controls.OBC.CDL.Reals.Sources.Constant airFlo(k = 0.646) annotation(
    Placement(transformation(origin = {50, 62}, extent = {{-10, -10}, {10, 10}})));
  Buildings.Fluid.Sources.MassFlowSource_T chiWatSup(nPorts = 1, redeclare package Medium = Buildings.Media.Water "Water", m_flow = 0.498, T = 285.15, use_m_flow_in = true) annotation(
    Placement(transformation(origin = {18, -46}, extent = {{-10, -10}, {10, 10}})));
  Buildings.Fluid.Sources.Boundary_pT chiWatSin(nPorts = 1, redeclare package Medium = Buildings.Media.Water "Water") annotation(
    Placement(transformation(origin = {-50, -46}, extent = {{-10, -10}, {10, 10}})));
  Modelica.Thermal.HeatTransfer.Sensors.TemperatureSensor temSenZon annotation(
    Placement(transformation(origin = {162, 92}, extent = {{-10, -10}, {10, 10}})));
  Buildings.Controls.OBC.CDL.Reals.Hysteresis con(uLow = 273.15 + 23.5, uHigh = 273.15 + 24.5)  annotation(
    Placement(transformation(origin = {-50, -80}, extent = {{-10, -10}, {10, 10}})));
  Buildings.Controls.OBC.CDL.Conversions.BooleanToReal booToRea(realTrue = 0.498)  annotation(
    Placement(transformation(origin = {-16, -80}, extent = {{-10, -10}, {10, 10}})));
equation
  connect(weaDat.weaBus, weaBus) annotation(
    Line(points = {{-80, 92}, {-62, 92}}, color = {255, 204, 51}, thickness = 0.5));
  connect(weaBus.TDryBul, preTem.T) annotation(
    Line(points = {{-62, 92}, {-42, 92}}, color = {0, 0, 127}));
  connect(preTem.port, theCon.port_a) annotation(
    Line(points = {{-20, 92}, {0, 92}}, color = {191, 0, 0}));
  connect(theCon.port_b, zon.heatPort) annotation(
    Line(points = {{20, 92}, {106, 92}}, color = {191, 0, 0}));
  connect(fixHeaFlo.port, zon.heatPort) annotation(
    Line(points = {{20, 58}, {28, 58}, {28, 92}, {106, 92}}, color = {191, 0, 0}));
  connect(outAir.ports[1], hex.port_a1) annotation(
    Line(points = {{-100, 14}, {-92, 14}, {-92, 22}, {-80, 22}}, color = {0, 127, 255}));
  connect(hex.port_b1, senTem.port_a) annotation(
    Line(points = {{-60, 22}, {-42, 22}}, color = {0, 127, 255}));
  connect(senTem.port_b, cooCoi.port_a2) annotation(
    Line(points = {{-22, 22}, {-2, 22}, {-2, 20}, {0, 20}, {0, 22}}, color = {0, 127, 255}));
  connect(cooCoi.port_b2, senTem1.port_a) annotation(
    Line(points = {{20, 22}, {40, 22}}, color = {0, 127, 255}));
  connect(senTem1.port_b, fan.port_a) annotation(
    Line(points = {{60, 22}, {80, 22}}, color = {0, 127, 255}));
  connect(fan.port_b, zon.ports[1]) annotation(
    Line(points = {{100, 22}, {116, 22}, {116, 82}}, color = {0, 127, 255}));
  connect(zon.ports[2], hex.port_a2) annotation(
    Line(points = {{116, 82}, {124, 82}, {124, -6}, {-52, -6}, {-52, 10}, {-60, 10}}, color = {0, 127, 255}));
  connect(hex.port_b2, outAir.ports[2]) annotation(
    Line(points = {{-80, 10}, {-100, 10}, {-100, 14}}, color = {0, 127, 255}));
  connect(chiWatSup.ports[1], cooCoi.port_a1) annotation(
    Line(points = {{28, -46}, {34, -46}, {34, 10}, {20, 10}}, color = {0, 127, 255}));
  connect(chiWatSin.ports[1], cooCoi.port_b1) annotation(
    Line(points = {{-40, -46}, {-25, -46}, {-25, -48}, {-24, -48}, {-24, 10}, {0, 10}}, color = {0, 127, 255}));
  connect(airFlo.y, fan.m_flow_in) annotation(
    Line(points = {{62, 62}, {90, 62}, {90, 34}}, color = {0, 0, 127}));
  connect(weaBus.TDryBul, outAir.T_in) annotation(
    Line(points = {{-62, 92}, {-62, 38}, {-130, 38}, {-130, 18}, {-122, 18}}, color = {0, 0, 127}));
  connect(zon.heatPort, temSenZon.port) annotation(
    Line(points = {{106, 92}, {106, 112}, {142, 112}, {142, 92}, {152, 92}}, color = {191, 0, 0}));
  connect(temSenZon.T, con.u) annotation(
    Line(points = {{174, 92}, {184, 92}, {184, -102}, {-76, -102}, {-76, -80}, {-62, -80}}, color = {0, 0, 127}));
  connect(con.y, booToRea.u) annotation(
    Line(points = {{-38, -80}, {-28, -80}}, color = {255, 0, 255}));
  connect(booToRea.y, chiWatSup.m_flow_in) annotation(
    Line(points = {{-4, -80}, {0, -80}, {0, -40}, {6, -40}, {6, -38}}, color = {0, 0, 127}));
  annotation(
    Diagram(coordinateSystem(extent = {{-150, -120}, {150, 120}})),
    version = "",
    uses(Buildings(version = "13.0.0"), Modelica(version = "4.1.0")),
    experiment(StartTime = 15552000, StopTime = 15638400, Tolerance = 1e-06, Interval = 172.8));
end Room_cooling;