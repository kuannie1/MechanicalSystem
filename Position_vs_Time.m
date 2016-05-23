velocity(1)=0;
ForceDrag(1)=0;
acceleration(1)=0;
Height(1)=0;

for j=2:index
    acceleration(j)=(thrust_curve(j)+ForceDrag(j-1)-(9.81*(WaterMass+5)))/(WaterMass+5);
    velocity(j)=velocity(j-1)+dt(j)*acceleration(j);
    ForceDrag(j)=DragForce(velocity(j));
    Height(j)=Height(j-1)+dt(j)*velocity(j);
end
plot(Times,Height)
