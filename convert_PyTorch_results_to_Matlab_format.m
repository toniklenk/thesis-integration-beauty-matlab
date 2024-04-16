%% init
clear
STUDY_NAME = {'places1', 'places1', 'places2', 'oasis'};

%% single task
task = 'autoencoding';

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

