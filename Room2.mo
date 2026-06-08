model Room2 "This is a model of a room"
  parameter Real A_floor(unit = "m2") = 60 "Floor area of the room";
  parameter Real h(unit = "m") = 3 "Height of the room";
  parameter Real UA(unit = "W/K") = 10000/30 "Overall heat loss coefficient";
  parameter Real Q_ig(unit = "W") = 1000 "internal heat gains";
  parameter Real T_oa(unit = "K") = 30 + 273.15 "outdoor air temperature";
  parameter Real rho(unit = "kg/m3") = 1.2 "air density";
  parameter Real cp(unit = "J/(kg.K)") = 1000 "specific heat of air";
  parameter Real T_0(unit = "K") = 20 + 273.15 "initial temperature";
  Real T_ia(unit = "K", start = T_0, fixed = true) "Temperature of the indoor air";
equation
  rho*A_floor*h*cp*der(T_ia) = UA*(T_oa - T_ia) + Q_ig;
  annotation(
    experiment(StartTime = 0, StopTime = 10800, Tolerance = 1e-06, Interval = 21.6433));
end Room2;