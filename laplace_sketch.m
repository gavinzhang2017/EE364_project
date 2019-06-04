%% create pde model object
model = createpde();
geometryFromEdges(model,@circleg);
applyBoundaryCondition(model,'dirichlet','Edge',1:model.Geometry.NumEdges,'u',0);
specifyCoefficients(model,'m',0,'d',0,'c',1,'a',0,'f',1);

%% generate mesh
hmax = 0.1;
generateMesh(model,'Hmax',hmax);
figure
pdemesh(model); 
axis equal

%% assemble matrices for the FEM
tic;
FEM = assembleFEMatrices(model,'nullspace');
A = FEM.Kc;
b = FEM.Fc;
n = length(FEM.Kc);
u = A\b;

m = 1325; % number of measurements for the sketch matrix
S = randn(m, n);
SA = S*A;
Sb = S*b;
u_skectch = SA\Sb;

u_new = FEM.B*u + FEM.ud;
u_sketch_new = FEM.B*u_sketch + FEM.ud;

toc;

%% plot the solution
pdeplot(model,'XYData',u_new,'ZData',u_new)
figure;
pdeplot(model,'XYData',u_sketch_new,'ZData',u_sketch_new)