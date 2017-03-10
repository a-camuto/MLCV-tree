function rf_surf(results)
SN = [];
D = [];
A = [];
for i = 1:length(results)
    if strcmp(results{i}.split,'Axis Aligned') == 1
        D(end+1) = results{i}.bookparams.depth;
        SN(end+1) = results{i}.bookparams.splitNum;
        uD = unique(D);
        uDi = find(uD == results{i}.bookparams.depth);
        uSN = unique(SN);
        uSNi = find(uSN == results{i}.bookparams.splitNum);
        A(uSNi,uDi) = results{i}.accuracy;
    end
end
surf(uD,uSN,A)
colormap(spring)
end