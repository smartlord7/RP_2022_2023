function [c, patterns] = classify_(inputs, ideals, class, className)
    c = 0;
    patterns = zeros(10, size(inputs,  1));
    for i=(1:size(inputs))
        peach = hideBackground(inputs{i});
        features = extractFeatures(peach);
        [minDist, minDistClass, isCorrect] = classify__(features, ideals, ...
            class, 'cityblock');
        c = c + isCorrect;
        patterns(:, i) = features;
    end
    
    accuracy = c / size(inputs, 1) * 100;
    fprintf("%s recognition accuracy: %.2f%%\n", className, accuracy);
end

