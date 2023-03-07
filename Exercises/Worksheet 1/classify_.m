function [c, patterns] = classify_(inputs, ideals, class, className)
    c = 0;
    patterns = zeros(10, size(inputs,  1));
    for i=(1:size(inputs))
        input = hideBackground(inputs{i});
        features = extractFeatures(input);
        [minDist, minDistClass, isCorrect] = classify__(features, ideals, ...
            class, 'cosine');
        c = c + isCorrect;
        patterns(:, i) = features;
    end
    
    accuracy = c / size(inputs, 1) * 100;
    fprintf("%s recognition accuracy: %.2f%%\n", className, accuracy);
end

