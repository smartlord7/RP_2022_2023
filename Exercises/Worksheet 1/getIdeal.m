function [ideal] = getIdeal(images, class)
    patterns = zeros(10, size(images, 1));
    for i=(1:size(images))
        img = images{i};
        showImageHistogram(img, false);
        img = hideBackground(img);
        images{i} = img;
        showImageHistogram(img, false);
        features = extractFeatures(img);
        patterns(:, i) = features;
    end

    data = struct;
    data.X = patterns(:, :);
    data.y = repmat(class, 1, size(data.X, 2));
    data.dim = size(data.X, 1);
    data.num_data = size(data.X, 2);
    ppatterns(data);
    
    ideal = mean(patterns, 2);
end

