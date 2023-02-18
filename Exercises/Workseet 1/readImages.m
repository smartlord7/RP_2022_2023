function [images] = readImages(path, extension)
    files = dir(path + "*" + extension);
    nFiles = size(files, 1);
    images = cell(nFiles, 1);
    
    for i=(1:nFiles)
        file_path = path + files(i).name;
        image = imread(file_path);
        images{i} = image;
    end
end

