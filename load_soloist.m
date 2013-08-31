function load_soloist()

Variables
port = soloistPort;
hostname = soloistHostName;
motionProfile = MotionProfile;

data = sprintf('c\\nm %f %f %f\\n',motionProfile(1,1),motionProfile(2,1),motionProfile(3,1));
for i = 1:size(motionProfile,2)
    data = strcat(data, sprintf('am %f %f %f',motionProfile(1,i),motionProfile(2,i),motionProfile(3,i)),'\n');
    data = strcat(data, 'at','\n');
end

send_to_soloist(data,hostname,port);
