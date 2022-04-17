within WalkingInWorldOfThermoFluid.Normal;

model R134vaporCondenser_ex01 "Complete drum boiler model, including evaporator and supplementary components"
  extends Modelica.Icons.Example;
  parameter Boolean use_inputs = false "use external inputs instead of test data contained internally";
  Modelica.Fluid.Examples.DrumBoiler.BaseClasses.EquilibriumDrumBoiler condenser(redeclare package Medium = Modelica.Media.R134a.R134a_ph, V_l(fixed = true), V_l_start = 0.49, V_t = 1, cp_D = 500, m_D = 1e-9, p(fixed = false, start = 101.325 * 1000), p_start = 1 * 101.325 * 1000) annotation(
    Placement(visible = true, transformation(origin = {0, 10}, extent = {{10, -10}, {-10, 10}}, rotation = 0)));
  Modelica.Thermal.HeatTransfer.Sources.PrescribedHeatFlow furnace annotation(
    Placement(visible = true, transformation(origin = {0, -23}, extent = {{-10, -10}, {10, 10}}, rotation = 90)));
  Modelica.Fluid.Sensors.MassFlowRate massFlowVapor(redeclare package Medium = Modelica.Media.R134a.R134a_ph) annotation(
    Placement(visible = true, transformation(origin = {-40, 10}, extent = {{10, 10}, {-10, -10}}, rotation = 180)));
  Modelica.Fluid.Sensors.Temperature temperatureVapor(redeclare package Medium = Modelica.Media.R134a.R134a_ph) annotation(
    Placement(visible = true, transformation(origin = {-70, -20}, extent = {{10, -10}, {-10, 10}}, rotation = 180)));
  Modelica.Fluid.Sensors.Pressure pressureVapor(redeclare package Medium = Modelica.Media.R134a.R134a_ph) annotation(
    Placement(visible = true, transformation(extent = {{-80, 24}, {-60, 44}}, rotation = 0)));
  Modelica.Fluid.Valves.ValveLinear VaporValve(redeclare package Medium = Modelica.Media.R134a.R134a_ph, dp_nominal = 100 * 1000, m_flow_nominal = 1) annotation(
    Placement(visible = true, transformation(extent = {{-100, 20}, {-80, 0}}, rotation = 0)));
  inner Modelica.Fluid.System system(T_ambient = 0 + 273.15) annotation(
    Placement(visible = true, transformation(extent = {{-120, 80}, {-100, 100}}, rotation = 0)));
  Modelica.Blocks.Sources.Ramp ramp_Q_flow_in(duration = 5, height = -5000.0, offset = -100000.0, startTime = 200) annotation(
    Placement(visible = true, transformation(origin = {-30, -50}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Sources.Ramp ramp_valveopen(duration = 100, height = 0, offset = 1, startTime = 300) annotation(
    Placement(visible = true, transformation(origin = {-110, -30}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Fluid.Sources.MassFlowSource_T scavengePump(redeclare package Medium = Modelica.Media.R134a.R134a_ph, T = (-40) + 273.15, m_flow = 1, nPorts = 2, use_m_flow_in = true) annotation(
    Placement(visible = true, transformation(origin = {70, 10}, extent = {{10, -10}, {-10, 10}}, rotation = 0)));
  Modelica.Fluid.Sources.Boundary_pT boudaryVaporSupply(redeclare package Medium = Modelica.Media.R134a.R134a_ph, T = 0 + 273.15, nPorts = 1, p = 3 * 101.325 * 1000) annotation(
    Placement(visible = true, transformation(origin = {-130, 10}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Math.Gain fracLiquid(k = 1 / condenser.V_t) annotation(
    Placement(visible = true, transformation(origin = {-4, 35}, extent = {{-5, -5}, {5, 5}}, rotation = 90)));
  Modelica.Blocks.Sources.Ramp ramp_r_liquidLevel(duration = 100, height = 0, offset = 0.5, startTime = 100) annotation(
    Placement(visible = true, transformation(origin = {-50, 90}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Continuous.PI pi(T = 2, k = 200) annotation(
    Placement(visible = true, transformation(origin = {80, 90}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Math.Feedback feedback annotation(
    Placement(visible = true, transformation(origin = {-4, 90}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Fluid.Sensors.Temperature temperatureLiquid(redeclare package Medium = Modelica.Media.R134a.R134a_ph) annotation(
    Placement(visible = true, transformation(origin = {50, 30}, extent = {{10, 10}, {-10, -10}}, rotation = 180)));
  Modelica.Fluid.Sensors.MassFlowRate massFlowLiquid(redeclare package Medium = Modelica.Media.R134a.R134a_ph) annotation(
    Placement(visible = true, transformation(origin = {30, 10}, extent = {{10, 10}, {-10, -10}}, rotation = 180)));
equation
  connect(furnace.port, condenser.heatPort) annotation(
    Line(points = {{0, -13}, {0, 0}}, color = {191, 0, 0}));
  connect(ramp_Q_flow_in.y, furnace.Q_flow) annotation(
    Line(points = {{-19, -50}, {0, -50}, {0, -33}}, color = {0, 0, 127}));
  connect(ramp_valveopen.y, VaporValve.opening) annotation(
    Line(points = {{-99, -30}, {-91, -30}, {-91, 2}}, color = {0, 0, 127}));
  connect(condenser.V, fracLiquid.u) annotation(
    Line(points = {{-4, 21}, {-4, 29}}, color = {0, 0, 127}));
  connect(fracLiquid.y, feedback.u2) annotation(
    Line(points = {{-4, 40.5}, {-4, 82}}, color = {0, 0, 127}));
  connect(pi.u, feedback.y) annotation(
    Line(points = {{68, 90}, {5, 90}}, color = {0, 0, 127}));
  connect(massFlowVapor.port_b, condenser.port_b) annotation(
    Line(points = {{-30, 10}, {-10, 10}}, color = {0, 127, 255}));
  connect(condenser.port_a, massFlowLiquid.port_a) annotation(
    Line(points = {{10, 10}, {20, 10}}, color = {0, 127, 255}));
  connect(ramp_r_liquidLevel.y, feedback.u1) annotation(
    Line(points = {{-38, 90}, {-12, 90}}, color = {0, 0, 127}));
  connect(pi.y, scavengePump.m_flow_in) annotation(
    Line(points = {{92, 90}, {94, 90}, {94, 18}, {80, 18}}, color = {0, 0, 127}));
  connect(boudaryVaporSupply.ports[1], VaporValve.port_a) annotation(
    Line(points = {{-120, 10}, {-100, 10}}, color = {0, 127, 255}));
  connect(VaporValve.port_b, massFlowVapor.port_a) annotation(
    Line(points = {{-80, 10}, {-50, 10}}, color = {0, 127, 255}));
  connect(VaporValve.port_b, pressureVapor.port) annotation(
    Line(points = {{-80, 10}, {-70, 10}, {-70, 24}}, color = {0, 127, 255}));
  connect(VaporValve.port_b, temperatureVapor.port) annotation(
    Line(points = {{-80, 10}, {-70, 10}, {-70, -10}}, color = {0, 127, 255}));
  connect(temperatureLiquid.port, scavengePump.ports[1]) annotation(
    Line(points = {{50, 20}, {50, 10}, {60, 10}}, color = {0, 127, 255}));
  connect(massFlowLiquid.port_b, scavengePump.ports[2]) annotation(
    Line(points = {{40, 10}, {60, 10}}, color = {0, 127, 255}));
  annotation(
    Icon(coordinateSystem(preserveAspectRatio = false, extent = {{-100, -100}, {100, 100}}), graphics = {Text(lineColor = {0, 0, 255}, extent = {{-151, 165}, {138, 102}}, textString = "%name"), Text(extent = {{-79, 67}, {67, 21}}, textString = "drum"), Text(extent = {{-90, -14}, {88, -64}}, textString = "boiler")}),
    experiment(StopTime = 300, StartTime = 0, Tolerance = 1e-06, Interval = 0.015),
    Documentation(info = "<html>

</html>"),
    __OpenModelica_commandLineOptions = "--matchingAlgorithm=PFPlusExt --indexReductionMethod=dynamicStateSelection -d=initialization,NLSanalyticJacobian,nonewInst -d=initialization, --maxMixedDeterminedIndex=1000, --maxSizeLinearTearing=400, --maxSizeNonlinearTearing=600 -d=nonewInst -d= --maxMixedDeterminedIndex=1000, --maxSizeLinearTearing=400, --maxSizeNonlinearTearing=600 -d=nonewInst -d= --maxMixedDeterminedIndex=1000, --maxSizeLinearTearing=400, --maxSizeNonlinearTearing=600 -d=nonewInst -d= --maxMixedDeterminedIndex=1000, --maxSizeLinearTearing=400, --maxSizeNonlinearTearing=600 -d=nonewInst -d= --maxMixedDeterminedIndex=1000, --maxSizeLinearTearing=400, --maxSizeNonlinearTearing=600 ",
    __OpenModelica_simulationFlags(lv = "LOG_STATS", s = "dassl"),
    Diagram(coordinateSystem(extent = {{-140, -100}, {100, 100}})));
end R134vaporCondenser_ex01;
