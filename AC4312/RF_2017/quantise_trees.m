function data = quantise_trees(desc,trees)

data = zeros(size(desc,1)*size(desc,2),size(trees(1).prob,1)+1);

for ObjCat = 1:size(desc,1)
    for ImgNum = 1:size(desc,2)
        TestDescVect = transpose(desc{ObjCat,ImgNum});
        TestDescVect(:,end+1) = ObjCat;
        labels = testTrees(TestDescVect,trees);
        histC = histcounts(reshape(labels,1,size(labels,1)*size(labels,2)));
        data((ObjCat-1)*size(desc,2)+ImgNum,1:length(histC))=histC./sum(histC);
        data((ObjCat-1)*size(desc,2)+ImgNum,size(trees(1).prob,1)+1)=ObjCat;
        waitbar(((ObjCat-1)*size(desc,2)+ImgNum)/(size(desc,1)*size(desc,2)))
    end
    
end
end

