% Init the ethernet port on PC
% Author: Long Qian
% Date: June 2016

function s = init()

    % Connect to robot
    Robot_IP = '172.22.22.2';
    Socket_conn = tcpip(Robot_IP,30000,'NetworkRole','server');
    fclose(Socket_conn);
    disp('Press Play on Robot...')
    fopen(Socket_conn);
    disp('Connected!');
    
    s = Socket_conn;
end