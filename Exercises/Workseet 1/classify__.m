function [minDist, minDistClass, isCorrect] = classify__(input, classIdeals, realClass, distance)
    minDist = inf;
    minDistClass = -1;

    for i=(1:size(classIdeals, 2))
       X = [input';classIdeals(:, i)'];
       dist = pdist(X, distance);
       if dist < minDist
            minDist = dist;
            minDistClass = i;
       end
    end

    if minDistClass ~= realClass
        isCorrect = 0;
    else
        isCorrect = 1;
    end
end