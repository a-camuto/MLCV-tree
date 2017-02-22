function data = quantise(desc,C)

data=zeros(size(desc,1)*size(desc,2),size(C,2)+1);
for ObjCat = 1:size(desc,1)
    for ImgNum = 1:size(desc,2)
        ClustIdx = zeros(1,size(desc{ObjCat,ImgNum},2));
        for DescVecNum = 1:size(desc{ObjCat,ImgNum},2)
            Dists = zeros(1,size(C,2));
            for Cluster = 1:size(C,2)
                Dists(1,Cluster) = norm(double(C(:,Cluster))-double(desc{ObjCat,ImgNum}(:,DescVecNum)));
            end
            [~, minIdx] = min(Dists);
            ClustIdx(1,DescVecNum) = minIdx;
        end
        data((ObjCat-1)*size(desc,2)+ImgNum,1:size(C,2)) = histcounts(ClustIdx,size(C,2));
        data((ObjCat-1)*size(desc,2)+ImgNum,size(C,2)+1)=ObjCat;
        waitbar(((ObjCat-1)*size(desc,2)+ImgNum)/(size(desc,1)*size(desc,2)))
    end
end

end

