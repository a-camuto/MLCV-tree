function km_surf(results)
N = [];
D = [];
A = [];
for i = 1:length(results)
    if strcmp(results{i}.split,'Axis Aligned') == 1
        D(end+1) = results{i}.depth;
        N(end+1) = results{i}.num;
        uD = unique(D);
        uDi = find(uD == results{i}.depth);
        uN = unique(N);
        uNi = find(uN == results{i}.num);
        A(uNi,uDi) = results{i}.accuracy;
    end
end
surf(uD,uN,A)
colormap(spring)
end

