function [node,nodeL,nodeR] = splitNode(data,node,param)
% Split node

visualise = 1;

% Initilise child nodes
iter = param.splitNum;
nodeL = struct('idx',[],'t',nan,'dim',0,'prob',[],'a',0,'b',0,'c',0);
nodeR = struct('idx',[],'t',nan,'dim',0,'prob',[],'a',0,'b',0,'c',0);

if length(node.idx) <= 5 % make this node a leaf if has less than 5 data points
    node.t = nan;
    node.dim = 0;
    return;
end

idx = node.idx;
data = data(idx,:);
[N,D] = size(data);
ig_best = -inf; % Initialise best information gain
idx_best = [];
for n = 1:iter
    
    
    % Split function - Modify here and try other types of split function
    if (strcmp(param.split,'Axis Aligned'))
    dim = randi(D-1); % Pick one random dimension
    d_min = single(min(data(:,dim))) + eps; % Find the data range of this dimension
    d_max = single(max(data(:,dim))) - eps;
    t = d_min + rand*((d_max-d_min)); % Pick a random value within the range as threshold
    idx_ = data(:,dim) < t;
    
    ig = getIG(data,idx_); % Calculate information gain
    
    if visualise
        visualise_splitfunc(idx_,data,dim,t,ig,n);
        pause();
    end
    
    [node, ig_best, idx_best] = updateIG(node,ig_best,ig,t,idx_,dim,idx_best,0,0,0);
    elseif (strcmp(param.split,'Linear'))
     dim = randi(D-1);
    
     for dim=1:D
    d_min(dim) = single(min(data(:,dim))) + eps; % Find the data range of this dimension
    d_max(dim) = single(max(data(:,dim))) -  eps;
     end 
     
    notDone=true; 
    
    while(notDone)
     for i =1:2
      index = randsample(D,1); 
         for dim = 1:D
             if (index == dim)
                  min_max = randsample(2,1); 
                 if (min_max == 0)
            choice(i,dim) = d_min(dim);
                 else 
            choice(i,dim) = d_max(dim);
                 end 
             else 
             choice(i,dim) = d_min(dim)+(d_max(dim)-d_min(dim))*rand;
             end 
             
         end
     end 
     
     
     coefficients = polyfit([choice(:,1)], [choice(:,2)], 1);
    a = coefficients(1);
    b = coefficients(2);
    
    for k=1:length(data)
        idx_(k) = dot([data(k,1:D-1),1],[a -1 b])<0; 
    end 
    if (range(idx_))
        notDone = false; 
    end 
    end
    ig = getIG(data,idx_); % Calculate information gain
    
    if visualise
        visualise_splitfunclinear(idx_,data,dim,a,b,ig,n);
        pause();
     end
    
    [node, ig_best, idx_best] = updateIG(node,ig_best,ig,0,idx_,dim,idx_best,a,b,0);
    
    
    elseif (strcmp(param.split,'Non Linear'))
     dim = randi(D-1);
    
     for dim=1:D
    d_min(dim) = single(min(data(:,dim))) + eps; % Find the data range of this dimension
    d_max(dim) = single(max(data(:,dim))) -  eps;
     end 
     
    notDone=true; 
    
    while(notDone)
     for i =1:2
      index = randsample(D,1); 
         for dim = 1:D
             if (index == dim)
                  min_max = randsample(2,1); 
                 if (min_max == 0)
            choice(i,dim) = d_min(dim);
                 else 
            choice(i,dim) = d_max(dim);
                 end 
             else 
             choice(i,dim) = d_min(dim)+(d_max(dim)-d_min(dim))*rand;
             end
             
             choice(D+1,i) = d_min(i)+(d_max(i)-d_min(i))*rand;

         end
     end 
     
     beta0 = [1;1;1];
     opts = statset('nlinfit');
    opts.RobustWgtFun = 'bisquare';

     coefficients = polyfit([choice(:,1)],[choice(:,2)],2); 
    a = coefficients(1);
    b = coefficients(2);
    c = coefficients(3);
    
    for k=1:length(data)
        idx_(k) = dot([data(k,1).^2,data(k,1),data(k,2:D-1),1],[a b -1 c])<0; 
    end 
    if (range(idx_))
        notDone = false; 
    end 
    end
    ig = getIG(data,idx_); % Calculate information gain
    
    if visualise
        visualise_splitfuncnonlinear(idx_,data,dim,a,b,c,ig,n);
        pause();
    end
     
    [node, ig_best, idx_best] = updateIG(node,ig_best,ig,0,idx_,dim,idx_best,a,b,c);

    
    else
        
      error('specify split');  
    end
    
  
        
    
end

nodeL.idx = idx(idx_best);
nodeR.idx = idx(~idx_best);

end

function ig = getIG(data,idx) % Information Gain - the 'purity' of data labels in both child nodes after split. The higher the purer.
L = data(idx);
R = data(~idx);
H = getE(data);
HL = getE(L);
HR = getE(R);
ig = H - sum(idx)/length(idx)*HL - sum(~idx)/length(idx)*HR;
end

function H = getE(X) % Entropy
cdist= histc(X(:,1:end), unique(X(:,end))) + 1;
cdist= cdist/sum(cdist);
cdist= cdist .* log(cdist);
H = -sum(cdist);
end

function [node, ig_best, idx_best] = updateIG(node,ig_best,ig,t,idx,dim,idx_best,a,b,c) % Update information gain
if ig > ig_best
    if (t)
    ig_best = ig;
    node.t = t;
    node.dim = dim;
    idx_best = idx;
    node.c = 0; 
    node.b = 0; 
    node.a = 0; 
    elseif (c)
        node.c = c; 
        node.b = b; 
        node.a = a; 
        node.t = 0;
        node.dim = dim;
        idx_best = idx;
        ig_best = ig;
    else 
        node.c = 0; 
        node.b = b; 
        node.a = a; 
        node.t = 0;
        node.dim = dim;
        idx_best = idx;
        ig_best = ig;
    end 
else
    idx_best = idx_best;
end
end