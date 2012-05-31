%%%%%%%%%%%%%%%%%%% Testing graph loss function %%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%% Parameters %%%%%

% 5 ERRGs, 5 GRGs
graphs = false(100,100,10);
r = zeros(100);
for i=1:5
    r = rand(100);
    g = r<.0125; %This gives an ER graph with ~p=.025
    g = or(g,g');
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
        msg = ['noise: ' num2str(noise)]
        noiseCount = noiseCount + 1;
        
        for k = 1:iters
            h = triu(g);
            edges = find(h);
            
            % Add noise to the graph
            n = rand(size(edges));
            h(edges(n<noise)) = 0 ;
            edges = randi(100*100,size(edges));
            h(edges(n<noise)) = 1;
            
            h = logical(h);
            h = or(h,h');
            h(logical(eye(size(h))))=0;
            gl = graphLoss(g,h)/2;
            losses(i,noiseCount,k) = gl;
        end
    end
end

% Print table of noise vs. graph loss
