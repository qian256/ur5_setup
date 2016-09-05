% Author: Long Qian
% Date: June 2016
% I/O:
%     t: socket
%     q: joint state (6 vector)

function q = readrobotJoint(t)

if t.BytesAvailable>0
    fscanf(t,'%c',t.BytesAvailable);
end
fprintf(t,'(2)'); % task = 2 : reading task
while t.BytesAvailable==0
end
rec = fscanf(t,'%c',t.BytesAvailable);
if ~strcmp(rec(1),'[') || ~strcmp(rec(end),']')
    error('robot joint read error')
end
rec(end) = ',';
Curr_c = 1;
for i = 1 : 6
    C = [];
    Done = 0;
    while(Done == 0)
        Curr_c = Curr_c + 1;
        if strcmp(rec(Curr_c) , ',')
            Done = 1;
        else
            C = [C,rec(Curr_c)];
        end
    end
    q(i) = str2double(C);   
end
for i = 1 : length(q)
    if isnan(q(i))
        error('robot joint read error (Nan)')
    end
end
end