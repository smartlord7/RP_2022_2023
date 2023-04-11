function [features_matrix] = readImages(path, extension)
    files = dir(path + "*" + extension);
    nFiles = size(files, 1);
    features_matrix = zeros(nFiles, 10);
    
    for i=(1:nFiles)
        file_path = path + files(i).name;
        image = imread(file_path);
        features_matrix(i, :) = extractFeatures(image);
    end
end

