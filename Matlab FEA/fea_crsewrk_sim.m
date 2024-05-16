smodel = createpde('structural','static-solid');
importGeometry(smodel,'forkfinal.stl')
pdegplot(smodel,'FaceLabels', 'on', 'FaceAlpha',0.5);
msh= generateMesh(smodel, 'Hmax', 8);
pdeplot3D(smodel);

%Material Properties
E= 193E9;
nu = 0.3;
structuralProperties(smodel, 'YoungsModulus', E, 'PoissonsRatio',nu);

% structuralBC(smodel, 'Face', 12, 'Constraint','fixed');
% structuralBC(smodel, 'Face', 6, 'Constraint','fixed');

structuralBC(smodel, 'Face', 10, 'Constraint','fixed');
structuralBC(smodel, 'Face', 8, 'Constraint','fixed');

F1 = 89000;
a = (125*1e-3)*(995*1e-3);
p1 = F1/a;
%p1 = 98592.96482;
structuralBoundaryLoad(smodel, 'Face', 20, 'Pressure', p1);

Rs = solve(smodel)
pdeplot3D(smodel,'ColorMapData', Rs.VonMisesStress, 'Deformation',Rs.Displacement, 'DeformationScaleFactor',5);

minUz = min(Rs.Displacement.uz);
fprintf("Maximal deflection in the z-direction is %g meters.", minUz)
max(Rs.VonMisesStress)