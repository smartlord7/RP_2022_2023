function [img] = hideBackground(img)
    level = multithresh(img);
    seg_I = imquantize(img, level);
    seg_I(seg_I <= 1) = 1; 
    seg_I(seg_I > 1) = 0; 
    img2 = img .* uint8(seg_I);
    mask = img2(:, :, 1) ~= 0 | img2(:, :, 2) ~= 0 | img2(:, :, 3) ~= 0;
    img = img .* uint8(mask);
    %figure;
    %imshow(img)
end

