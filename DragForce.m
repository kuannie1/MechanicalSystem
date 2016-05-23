function res = DragForce(Velocity,radius,RocketHeightFeet)
radius=radius*0.3048/12;
height=RocketHeightFeet*0.3048;
reference_area = (2 * pi *radius * height);
air_mass_density = 1.225; %kg/m^3
Rocket_velocity = Velocity; %m/sec, CONVERT IF NEEDED
drag_coefficient = 0.015; %unitless, Drag coefficient of a bullet (closest representation of water rocket)
Drag_Force = .5 * air_mass_density * (Rocket_velocity^2) * drag_coefficient * reference_area; %check units!
res=-Drag_Force;