%WaterHeight_initial=linspace(0,108,109)

for i=1:1008
    for j=1:25
        MaxHeight(i,j)=HeightCalc(i/10,j*40,3,9);
        Times(i)=i/10;
        J(j)=j*40;
    end
    fprintf('currently at %d\n',i);
end
