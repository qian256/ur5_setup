%% TestGripperControl
% Sample code to control the gripper open / close of UR5
% First run Matlab code; then run the Polyscope program
% Long Qian 2016

%% Note
% task 1: moving robot
% task 2: read pose / joint
% task 3: open gripper
% task 4: close gripper

%% Program
s = init();

% Must wait a certain time period 
% for the gripper to fully open / close
openGripper(s);
pause(1);
closeGripper(s);


