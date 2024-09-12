clear all;clc;warning off;
addpath(genpath('./ilqr'), genpath('./utils'))

%% model and task setup
Model = model_reg('cartpole');
Task = task_reg(Model);

u_traj = zeros(Model.nu,Task.horizon)+1*randn(Model.nu,Task.horizon);
x_traj = Model.xInit;ite_per_step=[];time_per_step=[];cost0=[];

%% init
% fid = fopen('result0_noisy.txt','r');
% U = fscanf(fid, '%f');
% fclose(fid);
% u_traj = reshape(U(1:Model.nu*Task.horizon), Model.nu, Task.horizon);

%% run arma-ilqr
mexstep('load',['./model/' Model.file]);
[u_nom,x_nom,cost,train_time,fitcoef] = ilqr_arma_noisy(Model,Task,x_traj(:,1),u_traj,Task.horizon,cost0);
total_time = train_time
cost_f = cost(end)

%% nominal traj
% x_traj = Model.xInit;
% mexstep('reset');
% mexstep('set','qpos',Model.xInit(1:Model.nq,1),Model.nq);
% mexstep('set','qvel',Model.xInit(Model.nq+1:Model.nsys,1),Model.nv);
% mexstep('forward');
% for i=1:1:Task.horizon
%     mexstep('set','ctrl',u_traj(:,i),Model.nu);
%     mexstep('step',1);
%     x_traj(1:Model.nq,i) = mexstep('get','qpos')';
%     x_traj(Model.nq+1:Model.nsys,i) = mexstep('get','qvel')';
% end
% % mexstep('exit');
% [u_nom,x_nom,cost,train_time] = ilqr_arma(Model,Task,x_traj(:,1),u_traj,Task.horizon,cost0);
% cost_f = cost(end)

%% output result
% fid = fopen('result0_noisy.txt','wt');
% for i = 1 : Task.horizon
%     for j = 1 : Model.nu
%         fprintf(fid,'%.10f ',u_nom(j,i));
%     end
% end
% fclose(fid);

%% plot
figure;
subplot(1,3,1)
plot([x_nom(1,:)', x_nom(2,:)'])
xlabel('step')
ylabel('state')

subplot(1,3,2)
plot(0:1:size(u_nom,2)-1, u_nom(1,:))
xlabel('step')
ylabel('u')

subplot(1,3,3)
plot(0:1:size(cost,2)-1, cost);
xlabel('iteration')
ylabel('cost')
