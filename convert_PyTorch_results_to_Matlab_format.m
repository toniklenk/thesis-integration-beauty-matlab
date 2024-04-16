%% init
clear

%
DATASET_NAMES = {'places1', 'places1', 'places2', 'oasis'};
SCALE_NAMES = {'scale2','scale4','scale8','scale16','scale32'};
%STUDY_NAMES = ('study1', 'study2','study3', 'study4');

MODEL_NAME = 'vgg16';

PYTORCH_RESULTS_PATH = '../Taskonomy Integration/results';
SAVE_PATH = './data';






%% vgg16
task = 'vgg16';
%task = 'autoencoding';

for study = 1:4
    for scale = 1:5
        corr{scale} = single(readmatrix('./vgg16_places_results.csv'));
        %sim{scale} = single(readmatrix('./vgg16_places_results.csv'));
        %l2{scale} = single(readmatrix('./vgg16_places_results.csv'));
    end

    % combine into single struct
    cnn.corr = corr;
    %cnn.sim = sim;
    %cnn.l2 = l2;

    % export csv for one study
    save(['results_taskonomy/cnn_' task '_res_' STUDY_NAME{study} '.mat'], "cnn")
end

clear study scale sim corr l2 cnn task

%%
readmatrix()