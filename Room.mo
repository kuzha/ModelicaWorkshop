model Room "This is a model of a room, implemented using component-based modeling"
  extends Modelica.Icons.Example;

// Parameters (Paramètres)
  parameter Modelica.Units.SI.Area A_floor = 60 "Floor area of the room (Surface de plancher de la pièce)";
  parameter Modelica.Units.SI.Height h = 3 "Height of the room (Hauteur de la pièce)";
  parameter Modelica.Units.SI.ThermalConductance UA = 10000/30 "Overall heat loss coefficient (Coefficient de déperditions thermiques)";
  parameter Modelica.Units.SI.HeatFlowRate Q_ig = 1000 "Internal heat gains (Gains thermiques internes)";
  parameter Modelica.Units.SI.Temperature T_ia0(displayUnit = "degC") = 20 + 273.15 "Initial temperature (Température initiale)";

// Lumped parameters (Paramètres intermédiaires)
  final parameter Modelica.Units.SI.Volume V = A_floor * h
    "Room volume (Volume de la pièce)";

// Components (Composantes)
  Buildings.Fluid.MixingVolumes.MixingVolume zon(redeclare package Medium =
        Buildings.Media.Air "Moist air",
    energyDynamics=Modelica.Fluid.Types.Dynamics.FixedInitial,
    T_start=T_ia0,                       m_flow_nominal = 0.646, V = V, mSenFac = 3)  annotation (
    Placement(transformation(origin = {50, 70}, extent = {{-10, -10}, {10, 10}})));
  Modelica.Thermal.HeatTransfer.Components.ThermalConductor theCon(G=UA)          annotation (
    Placement(transformation(origin = {10, 70}, extent = {{-10, -10}, {10, 10}})));
  Modelica.Thermal.HeatTransfer.Sources.PrescribedTemperature preTem annotation (
    Placement(transformation(origin = {-30, 70}, extent = {{-10, -10}, {10, 10}})));
  Buildings.BoundaryConditions.WeatherData.ReaderTMY3 weaDat(filNam=".\\Resources\\weatherdata\\USA_IL_Chicago-OHare.Intl.AP.725300_TMY3.mos")                                                                           annotation (
    Placement(transformation(origin = {-90, 70}, extent = {{-10, -10}, {10, 10}})));
  Buildings.BoundaryConditions.WeatherData.Bus weaBus annotation (
    Placement(transformation(origin = {-62, 70}, extent = {{-10, -10}, {10, 10}}), iconTransformation(origin = {-28, 36}, extent = {{-10, -10}, {10, 10}})));
  Modelica.Thermal.HeatTransfer.Sources.FixedHeatFlow intGains(Q_flow=Q_ig)    annotation (
    Placement(transformation(origin = {10, 36}, extent = {{-10, -10}, {10, 10}})));

equation
  connect(weaDat.weaBus, weaBus) annotation (
    Line(points = {{-80, 70}, {-62, 70}}, color = {255, 204, 51}, thickness = 0.5));
  connect(weaBus.TDryBul, preTem.T) annotation (
    Line(points={{-61.95,70.05},{-52,70.05},{-52,70},{-42,70}},
                                          color = {0, 0, 127}));
  connect(preTem.port, theCon.port_a) annotation (
    Line(points = {{-20, 70}, {0, 70}}, color = {191, 0, 0}));
  connect(theCon.port_b, zon.heatPort) annotation (
    Line(points = {{20, 70}, {40, 70}}, color = {191, 0, 0}));
  connect(intGains.port, zon.heatPort) annotation (
    Line(points = {{20, 36}, {28, 36}, {28, 70}, {40, 70}}, color = {191, 0, 0}));

annotation (
  Diagram(coordinateSystem(extent = {{-100, 100}, {60, 20}})),
  version = "",
  experiment(StartTime = 15552000, StopTime = 15638400, Interval = 180., Tolerance = 1e-06),
  Documentation(info = "<html><head></head><body>This is a 1R1C model.</body></html>"));
end Room;
