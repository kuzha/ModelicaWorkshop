model Room
  Buildings.Fluid.MixingVolumes.MixingVolume zon(redeclare package Medium = Buildings.Media.Air "Moist air", m_flow_nominal = 0.646, V = 180, mSenFac = 3)  annotation(
    Placement(transformation(origin = {50, 70}, extent = {{-10, -10}, {10, 10}})));
  Modelica.Thermal.HeatTransfer.Components.ThermalConductor theCon(G = 10000/30)  annotation(
    Placement(transformation(origin = {10, 70}, extent = {{-10, -10}, {10, 10}})));
  Modelica.Thermal.HeatTransfer.Sources.PrescribedTemperature preTem annotation(
    Placement(transformation(origin = {-30, 70}, extent = {{-10, -10}, {10, 10}})));
  Buildings.BoundaryConditions.WeatherData.ReaderTMY3 weaDat(filNam = "/home/kun/Documents/modelica-buildings/Buildings/Resources/weatherdata/USA_IL_Chicago-OHare.Intl.AP.725300_TMY3.mos")  annotation(
    Placement(transformation(origin = {-90, 70}, extent = {{-10, -10}, {10, 10}})));
  Buildings.BoundaryConditions.WeatherData.Bus weaBus annotation(
    Placement(transformation(origin = {-62, 70}, extent = {{-10, -10}, {10, 10}}), iconTransformation(origin = {-28, 36}, extent = {{-10, -10}, {10, 10}})));
  Modelica.Thermal.HeatTransfer.Sources.FixedHeatFlow fixHeaFlo(Q_flow = 1000)  annotation(
    Placement(transformation(origin = {10, 36}, extent = {{-10, -10}, {10, 10}})));
equation
  connect(weaDat.weaBus, weaBus) annotation(
    Line(points = {{-80, 70}, {-62, 70}}, color = {255, 204, 51}, thickness = 0.5));
  connect(weaBus.TDryBul, preTem.T) annotation(
    Line(points = {{-62, 70}, {-42, 70}}, color = {0, 0, 127}));
  connect(preTem.port, theCon.port_a) annotation(
    Line(points = {{-20, 70}, {0, 70}}, color = {191, 0, 0}));
  connect(theCon.port_b, zon.heatPort) annotation(
    Line(points = {{20, 70}, {40, 70}}, color = {191, 0, 0}));
  connect(fixHeaFlo.port, zon.heatPort) annotation(
    Line(points = {{20, 36}, {28, 36}, {28, 70}, {40, 70}}, color = {191, 0, 0}));

annotation(
    uses(Buildings(version = "13.0.0"), Modelica(version = "4.1.0")),
  Diagram(coordinateSystem(extent = {{-100, 100}, {60, 20}})),
  version = "",
  experiment(StartTime = 15552000, StopTime = 15638400, Tolerance = 1e-06, Interval = 172.8),
  Documentation(info = "<html><head></head><body>This is a 1R1C model.</body></html>"));
end Room;
