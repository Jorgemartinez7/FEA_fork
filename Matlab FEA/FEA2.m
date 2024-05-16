smodel = createpde('structural','static-solid');
importGeometry(smodel,'forkfinal.stl')
pdegplot(smodel,'FaceLabels', 'on', 'FaceAlpha',0.5);
msh= generateMesh(smodel, 'Hmax', 8);
pdeplot3D(smodel);