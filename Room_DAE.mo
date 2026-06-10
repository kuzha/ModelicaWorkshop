within ;
model Room_DAE "This is a model of a room, implemented using equation-based modeling"
  extends Modelica.Icons.Example;

  // Parameters (Paramètres)
  parameter Modelica.Units.SI.Area A_floor = 60 "Floor area of the room (Surface de plancher de la pièce)";
  parameter Modelica.Units.SI.Height h = 3 "Height of the room (Hauteur de la pièce)";
  parameter Modelica.Units.SI.ThermalConductance UA = 10000/30 "Overall heat loss coefficient (Coefficient de déperditions thermiques)";
  parameter Modelica.Units.SI.HeatFlowRate Q_ig = 1000 "Internal heat gains (Gains thermiques internes)";
  parameter Modelica.Units.SI.Temperature T_oa(displayUnit = "degC") = 30 + 273.15 "Outdoor air temperature (Température extérieure)";
  parameter Modelica.Units.SI.Density rho_air = 1.2 "Air density (Densité de l'air)";
  parameter Modelica.Units.SI.SpecificHeatCapacity cp_air = 1000 "Specific heat of air (Chaleur spécifique de l'air)";
  parameter Modelica.Units.SI.Temperature T_ia0(displayUnit = "degC") = 20 + 273.15 "Initial temperature (Température initiale)";

  // Lumped parameters (Paramètres intermédiaires)
  final parameter Modelica.Units.SI.HeatCapacity C = A_floor * h * rho_air * cp_air
    "Lumped capacitance of the room (Capacité thermique de la pièce)";
  final parameter Modelica.Units.SI.ThermalResistance R = 1 / UA
    "Thermal resistance to the outdoor (Résistance thermique vers l'extérieur)";

  // Variables
  Modelica.Units.SI.Temperature T_ia(displayUnit = "degC") "Temperature of the indoor air (Température intérieure)";

initial equation
  T_ia = T_ia0;

equation
  C * der(T_ia) = Q_ig + (T_oa - T_ia) / R;

annotation (
  experiment(StartTime = 0, StopTime = 10800, Interval = 20., Tolerance = 1e-06));
end Room_DAE;
