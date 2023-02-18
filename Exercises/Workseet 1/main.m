PATH_TRAIN_DATA = "data/train/";
PATH_TEST_DATA = "data/test/";
EXTENSION_DATA = ".JPG";
NUM_CLASS_PEACH = 1;
NUM_CLASS_ORANGE = 2;
NUM_CLASS_APPLE = 3;
CLASSES = [NUM_CLASS_PEACH NUM_CLASS_ORANGE NUM_CLASS_APPLE];
CLASSES_INFO = ["Peach" PATH_TRAIN_DATA + "PEACHES/" PATH_TEST_DATA + "PEACHES/";
           "Orange" PATH_TRAIN_DATA + "ORANGES/" PATH_TEST_DATA + "ORANGES/";
           "Apple" PATH_TRAIN_DATA + "APPLES/" PATH_TEST_DATA + "APPLES/"];


peachesTrain = readImages(CLASSES_INFO(NUM_CLASS_PEACH, 2), EXTENSION_DATA);
orangesTrain = readImages(CLASSES_INFO(NUM_CLASS_ORANGE, 2), EXTENSION_DATA);
applesTrain = readImages(CLASSES_INFO(NUM_CLASS_APPLE, 2), EXTENSION_DATA);

idealPeach = getIdeal(peachesTrain, 1);
idealOrange = getIdeal(orangesTrain, 2);
idealApples = getIdeal(applesTrain, 3);

ideals = [idealPeach, idealOrange, idealApples];

figure;
ppatterns(idealPeach);
ppatterns(idealOrange);
ppatterns(idealApples);

peachesTest = readImages(CLASSES_INFO(NUM_CLASS_PEACH, 3), EXTENSION_DATA);
orangesTest = readImages(CLASSES_INFO(NUM_CLASS_ORANGE, 3), EXTENSION_DATA);
applesTest = readImages(CLASSES_INFO(NUM_CLASS_APPLE, 3), EXTENSION_DATA);

fprintf("\n------------------------------------------\n");
[cPeaches, patternsPeaches] = classify_(peachesTest, ideals, ...
    NUM_CLASS_PEACH, CLASSES_INFO(NUM_CLASS_PEACH, 1));
[cOranges, patternsOranges] = classify_(orangesTest, ideals, ...
    NUM_CLASS_ORANGE, CLASSES_INFO(NUM_CLASS_ORANGE, 1));
[cApples, patternsApples] = classify_(applesTest, ideals, ...
    NUM_CLASS_APPLE, CLASSES_INFO(NUM_CLASS_APPLE, 1));

totalAccuracy = (c1 + c2 + c3) / (size(peachesTest, 1) + size(orangesTest, 1) + size(applesTest, 1)) * 100;
fprintf("Total accuracy: %.2f%%\n", totalAccuracy);



