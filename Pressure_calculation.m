function res = Pressure_calculation(params,RocketDiameter,RocketHeightFeet)


dt=params(1);
i_airpressure=params(2);
WaterHeight_initial_inches=params(3);
v_flowrate=params(4);
NozzleDiameter=0.5;%                                Nozzle Diameter in inches
%RocketDiameter=3;%                                  Diameter of the rocket in inches
RocketRadius=RocketDiameter/2;%                     Radius of the rocket in inches
%RocketHeightFeet=9;%                                Height of the rocket in feet
RocketHeight=RocketHeightFeet*12;%                  Height of the rocket converted to inches
VolumeTotal=RocketRadius^2*pi*RocketHeight*1.63871e-5;%        Total volume of rocket including water and compressed air
VolumeWater_initial=RocketRadius^2*pi*WaterHeight_initial_inches*1.63871e-5;
VolumeAir_initial=VolumeTotal-VolumeWater_initial;
v_flowrate = WaterRocketFlowRate(i_airpressure);% outputs m^3/s
airvolume = VolumeAir_initial + v_flowrate*dt;
airpressure = (i_airpressure * VolumeAir_initial) / airvolume;
WaterVolume=(VolumeTotal-airvolume);
WaterVolume_inch=WaterVolume/1.63871e-5;
WaterHeight=WaterVolume_inch/(pi*RocketRadius^2);
res = [dt,airpressure,WaterHeight,v_flowrate];

function res=thrust_nozzle_diameter(i_airpressure)%function accepts pressure in psi as input and outputs thrust in Newtons
NozzleDiameter=.75;
Volflowrate=WaterRocketFlowRate(NozzleDiameter);
res=thrust(Volflowrate,i_airpressure);


function res=WaterRocketFlowRate(NozzleDiameter)




%VolumeCompressedAir=VolumeTotal-VolumeWater;%       Placeholder for accounting for pressure drop over time
%p1=400;%                                            Starting pressure in psi
%p2=p1*v1/v2;%                                       p1 and v2 are initial pressure and volume, p2 and v2 are current pressure and volume                    Diameter of the nozzle in inches
NozzleRadius=NozzleDiameter/2;%                     Radius of Nozzle in inches
NozzleRadiusFoot=NozzleRadius/12;%                  Radius of Nozzle converted to ft
A=NozzleRadiusFoot^2*pi;%                           Area of Nozzle orfice in square ft
head=i_airpressure*2.31;%                           Converting pressure inside the rocket to equivalent "head"
V=8.02*sqrt(head);%                                 Velocity of flow in ft/s
K=1.55;%                                            Correction factor based on orfice shape
Q=A*V*K;%                                           Q is flow rate in ft^3/s

res=Q;
end

function res = thrust(Volflowrate, Pressure) %volflowrate in ft^3/sec, pressure in psi(lbs/in^2)
%Calculating velocity
head = (Pressure * 2.31); %height of water in water rocket in ft.
thrust_velocity = (8.02 * sqrt(head)); %Velocity of the thrust converted to ft/s
thrust_velocity=thrust_velocity*0.3048;%Velocity of the thrust converted to m/s
Volflowrate = Volflowrate/35.314667; % m^3/s

%Calculating mass flow rate
H2Odensity = 1000; %kg/m^3
mflowrate = H2Odensity * Volflowrate; %kg/s (m^3 cancels out from volflowrate)

%Resulting thrust:
Thrustresult = mflowrate * thrust_velocity;%Thrust result is in Newtons

res = [Volflowrate,Thrustresult];
end
end













end