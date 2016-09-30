function closeGripper(t)
% Close the gripper
% Long Qian 2016
    if t.BytesAvailable>0
        fscanf(t,'%c',t.BytesAvailable);
    end
    fprintf(t,'(4)'); % task = 4 : Close Gripper
    while t.BytesAvailable==0
        %t.BytesAvailable
    end
    success = readrobotMsg(t);
    if ~strcmp(success,'1')
        error('error sending close gripper command')
    end
end