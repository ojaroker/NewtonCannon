% Oscar Jaroker
% April 2024
% Newton Cannon Simulation
% github.com/ojaroker/NewtonCannon

m=1; % mass of projectile (irrelevant) (kg)
R=6371000; % mean radius of earth (m)
startHeight = .155*R; %height, abt 1000 km
G=6.6743e-11; % gravitational constant (Nm^2/kg^2)
M=5.97219e24; % mass of earth (kg)
v0 = 7000; % launch speed (m/s)

scaleFactor = 1e4;

hold on
% load and scale image
img = imread("NewtonWorld.png");
img = imresize(img, [1770,1770]);
img = flipdim(img,1);
% center image
imshow(img, 'XData', [-883, -883 + size(img,2)], ...
    'YData', [-884, -884 + size(img,1)]);

% change axis scale. 1e3 default.
axis([-1e3 1e3 -1e3 1e3])
% make pi/2 top and positive velocity clockwise
set(gca,'XDir','reverse','YDir','normal') 
axis equal

% white background
set(gcf,'Color','w')

v0vals = [4000 5000 6000 7000 7200 7500];
% endVals for plotting points at stopping location
% endVals = zeros(6,2);
counter=1;
for i = v0vals
    v0 = i;
    % get simulated trajectory values r,theta
    out = sim('newtonCannonSim.slx');
    rVals = out.output(:,1);
    thetaVals = out.output(:,2);
    % convert to cartestian, scale
    xVals = rVals .* cos(thetaVals) ./ scaleFactor;
    yVals = rVals .* sin(thetaVals) ./ scaleFactor;
    % instant plotting:
    plot(xVals,yVals,'Color',rand(1,3))
    % endVals(counter,1) = xVals(end);
    % endVals(counter,2) = yVals(end);
    % comet for animation:
    % comet(xVals,yVals,.3)
    counter = counter + 1;
end
legend(char(['v0=' int2str(v0vals(1))]), ...
    char(['v0=' int2str(v0vals(2))]), ...
    char(['v0=' int2str(v0vals(3))]), ...
    char(['v0=' int2str(v0vals(4))]), ...
    char(['v0=' int2str(v0vals(5))]), ...
    char(['v0=' int2str(v0vals(6))]))
title(['Trajectories for ' ...
    'Different Initial Velocities (m/s)'])
hold off
