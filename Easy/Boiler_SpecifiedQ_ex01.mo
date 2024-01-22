within WalkingInWorldOfThermoFluid.Easy;

model Boiler_SpecifiedQ_ex01
  extends Modelica.Icons.Example;
  inner Modelica.Fluid.System system(p_ambient = 100*1000, T_ambient = 288.15) annotation(
    Placement(transformation(origin = {-80, 80}, extent = {{-10, -10}, {10, 10}})));
  Modelica.Fluid.Vessels.ClosedVolume volume(redeclare package Medium = Modelica.Media.Water.StandardWater, use_portsData = false, V = 0.1, use_HeatTransfer = false, nPorts = 3, p_start = 8*100*1000) annotation(
    Placement(transformation(origin = {-12, 28}, extent = {{-10, -10}, {10, 10}})));
  Modelica.Fluid.Sources.Boundary_pT boundary(p = 8*100*1000, T = 288.15, nPorts = 1, redeclare package Medium = Modelica.Media.Water.StandardWater) annotation(
    Placement(transformation(origin = {-62, 18}, extent = {{-10, -10}, {10, 10}})));
  Modelica.Fluid.Sources.MassFlowSource_T boundary1(nPorts = 1, m_flow = -50, T = 288.15, redeclare package Medium = Modelica.Media.Water.StandardWater) annotation(
    Placement(transformation(origin = {62, 18}, extent = {{10, -10}, {-10, 10}}, rotation = -0)));
  Modelica.Fluid.Vessels.ClosedVolume volume1(redeclare package Medium = Modelica.Media.Water.StandardWater, use_portsData = false, use_HeatTransfer = true, V = 0.1, nPorts = 3, p_start = 8*100*1000) annotation(
    Placement(transformation(origin = {18, 28}, extent = {{-10, -10}, {10, 10}})));
  Modelica.Fluid.Sensors.Density density(redeclare package Medium = Modelica.Media.Water.StandardWater) annotation(
    Placement(transformation(origin = {-12, 3}, extent = {{-5, -5}, {5, 5}}, rotation = 180)));
  Modelica.Fluid.Sensors.Density density1(redeclare package Medium = Modelica.Media.Water.StandardWater) annotation(
    Placement(transformation(origin = {18, 3}, extent = {{-5, -5}, {5, 5}}, rotation = 180)));
  Modelica.Thermal.HeatTransfer.Sources.PrescribedHeatFlow prescribedHeatFlow annotation(
    Placement(transformation(origin = {-2, 62}, extent = {{-10, -10}, {10, 10}})));
  Modelica.Blocks.Sources.Ramp ramp(height = 1.5*10^8, duration = 1, offset = 0, startTime = 10) annotation(
    Placement(transformation(origin = {-38, 62}, extent = {{-10, -10}, {10, 10}})));
equation
  connect(volume.ports[1], boundary.ports[1]) annotation(
    Line(points = {{-12, 18}, {-52, 18}}, color = {0, 127, 255}));
  connect(volume.ports[2], volume1.ports[1]) annotation(
    Line(points = {{-12, 18}, {18, 18}}, color = {0, 127, 255}));
  connect(volume1.ports[2], boundary1.ports[1]) annotation(
    Line(points = {{18, 18}, {52, 18}}, color = {0, 127, 255}));
  connect(volume.ports[3], density.port) annotation(
    Line(points = {{-12, 18}, {-12, 8}}, color = {0, 127, 255}));
  connect(volume1.ports[3], density1.port) annotation(
    Line(points = {{18, 18}, {18, 8}}, color = {0, 127, 255}));
  connect(prescribedHeatFlow.port, volume1.heatPort) annotation(
    Line(points = {{8, 62}, {8, 28}}, color = {191, 0, 0}));
  connect(ramp.y, prescribedHeatFlow.Q_flow) annotation(
    Line(points = {{-26, 62}, {-12, 62}}, color = {0, 0, 127}));
  annotation(
    uses(Modelica(version = "4.0.0")),
    experiment(StartTime = 0, StopTime = 100, Tolerance = 1e-06, Interval = 0.01),
  Diagram(graphics = {Text(origin = {2, -17}, extent = {{-88, 5}, {88, -5}}, textString = "*This model fails when Phase change occurs in volume1")}));
end Boiler_SpecifiedQ_ex01;
