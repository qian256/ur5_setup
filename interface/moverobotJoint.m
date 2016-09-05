% Goal_Pose should be in mm and Orientation the rotation vector
% Author: Long Qian
% Date: June 2016
% Inputs:
%     t: socket
%     q: joint state (6 vector)

function moverobotJoint(t,q)
if nargin == 1
    error('error; not enough input arguments')
elseif nargin == 2
    if length(q)~=6
        error('Joint variable vector not length 6')
    end
    % To do: test that t is a good socket
end
q_char = ['(',num2str(q(1)),',',...
    num2str(q(2)),',',...
    num2str(q(3)),',',...
    num2str(q(4)),',',...
    num2str(q(5)),',',...
    num2str(q(6)),...
    ')'];
success = '0';
while strcmp(success,'0')
    fprintf(t,'(1)'); % task = 1 : moving task
    pause(0.01);% Tune this to meet your system
    fprintf(t,q_char);
    while t.BytesAvailable==0
        %t.BytesAvailable
    end
    success  = readrobotMsg(t);
end
if ~strcmp(success,'1')
    error('error sending robot joints')
end
%pause(0.5)