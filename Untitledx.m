bison1 = imread("bison1.jpg");
[mask1,labels1] = bisonMaskAndLabel(bison1);
overlay1 = labeloverlay(bison1,labels1);









function [mask,labelMatrix] = bisonMaskAndLabel(bison)
    
    gray = im2gray(bison);
    bisonBW = gray<65;
    
    bisonBW = bwareaopen(bisonBW,150);
    
    mask = activecontour(bison,bisonBW,"Chan-Vese","ContractionBias",-.25);
    
    mask = imfill(mask,"holes");
    
    se = strel("disk",3);
    mask = imopen(mask,se);

    % create and pre-process grayscale image for watershed
    d = bwdist(~mask);
    d = imcomplement(d);
    
    Ihmin = imhmin(d,5);
    
    % perform watershed
    labelMatrix = watershed(Ihmin);
    
    % post processing
    labelMatrix(~mask) = 0;
end
