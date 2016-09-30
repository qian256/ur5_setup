function openGripper(t)
% Open the gripper
% Long Qian 2016
    if t.BytesAvailable>0
        fscanf(t,'%c',t.BytesAvailable);
    end
    fprintf(t,'(3)'); % task = 3 : Open Gripper
    while t.BytesAvailable==0
        %t.BytesAvailable
    end
    success = readrobotMsg(t);
    if ~strcmp(success,'1')
        error('error sending open gripper command')
    end
end