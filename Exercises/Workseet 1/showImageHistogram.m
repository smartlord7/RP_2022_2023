function [R, G, B] = showImageHistogram(image, plot)
    R=imhist(image(:,:,1));
    G=imhist(image(:,:,2));
    B=imhist(image(:,:,3));
    if plot == true
        figure;
        plot(R,'r');
        hold on;
        plot(G,'g');
        plot(B,'b');
        legend(' Red channel', 'Green channel', 'Blue channel');
        hold off;
    end
end

