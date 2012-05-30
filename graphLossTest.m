%%%%%%%%%%%%%%%%%%% Testing graph loss function %%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%% Parameters %%%%%

% 5 ERRGs, 5 GRGs
graphs = zeros(100,100,10);
r = zeros(100);
for i=1:5
    r = rand(100);
    g = r<.05;
    g = or(r,r');
    g(logical(eye(size(g))))=0;
    graphs(:,:,i)=g;
end

for i=6:10
    g = geoRandGraph(100,250,2);
    graphs(:,:,i)=g;
end

% Noise levels in 2% increments from 0 to 50%, 10 trials each
vNoise = 0:.02:.50;
iters = 10;

%%%%% Experiment %%%%%

losses = zeros(size(graphs,3),size(vNoise,2),iters);

for i = 1:size(graphs,3)
    % Retrieve the graph
    g = graphs(:,:,i);   

    noiseCount = 0;
    for noise = vNoise
        noiseCount = noiseCount + 1
        
        for k = 1:iters
            % Add noise to the graph
            n = rand(100);
            n = triu(n<noise);
            n = or(n,n');
            h = xor(g,n);
            gl = graphLoss(g,h)/2;
            losses(i,noiseCount,k) = gl;
        end
    end
end

% Print table of noise vs. graph loss
