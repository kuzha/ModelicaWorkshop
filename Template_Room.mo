model Template_Room
  "This is a model of a room, implemented using component-based modeling"
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

annotation (
  Diagram(coordinateSystem(extent = {{-100, 100}, {60, 20}})),
  experiment(StartTime = 15552000, StopTime = 15638400, Interval = 180., Tolerance = 1e-06),
  Documentation(info = "<html><head></head><body>This is a 1R1C model.</body></html>"));
end Template_Room;
