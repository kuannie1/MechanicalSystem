function res=HeightCalc(WaterHeight_initial,i_airpressure,RocketDiameter,RocketHeightFeet)
TotalTime=10;
dt=0.0025;
%i_airpressure=400;
v_flowrate=0;
%WaterHeight_initial(1)=80;
radius=RocketDiameter/2;
index=TotalTime/dt;
pressures=zeros(5000,3);
params=[dt,i_airpressure,WaterHeight_initial,v_flowrate];
pressure(1)=params(2);
WaterHeight(1)=params(3);
VolumetricFlowrate(1)=params(4);
dt(1)=params(1);
Times(1)=(1*dt(1));
thrust_curve(1)=0;
WaterMass(1)=1000*pi*radius^2*WaterHeight(1)*1.63871e-5;
for i=2:index
   
    params=Pressure_calculation(params,RocketDiameter,RocketHeightFeet);
    pressure(i)=params(2);
    WaterHeight(i)=params(3);
    VolumetricFlowrate(i)=params(4);
    dt(i)=params(1);
    Times(i)=i*dt(i);
    
    if WaterHeight(i)<0
        params(2)=0;
    end
   
    paramsthrust=[params(4),params(2)];
    thrust_curve(i)=thrust(paramsthrust);
    
    
    WaterMass(i)=1000*pi*1.5^2*WaterHeight(i)*1.63871e-5;
    
end

velocity(1)=0;
ForceDrag(1)=0;
acceleration(1)=0;
Height(1)=0;

for j=2:index
    acceleration(j)=(thrust_curve(j)+ForceDrag(j-1)-(9.81*(WaterMass+5)))/(WaterMass+5);
    velocity(j)=velocity(j-1)+dt(1)*acceleration(j);
    ForceDrag(j)=DragForce(velocity(j),radius,RocketHeightFeet);
    Height(j)=Height(j-1)+dt(j)*velocity(j)*3.28084;
end
MaxHeight=max(Height);
res=MaxHeight;
end