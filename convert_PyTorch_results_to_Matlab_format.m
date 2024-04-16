%% init
clear

DATASET_NAMES = {'places1', 'places2', 'oasis'};
SCALE_NAMES = {'scale2','scale4','scale8','scale16','scale32'};

SAVE_PATH = './data vgg16';

%% vgg16
task = 'vgg16'; % placeholder for different taskonomy models
%task = 'autoencoding';
PYTORCH_RESULTS_PATH = '../Taskonomy Integration/results_vgg16';


for dataset = 1:1
    for scale = 1:5
        corr{scale} = single(readmatrix(fullfile(PYTORCH_RESULTS_PATH, task, DATASET_NAMES{dataset}, SCALE_NAMES{scale}, 'correlations.csv')));
        sim{scale} = single(readmatrix(fullfile(PYTORCH_RESULTS_PATH, task, DATASET_NAMES{dataset}, SCALE_NAMES{scale}, 'selfsimilarity.csv')));
        l2{scale} = single(readmatrix(fullfile(PYTORCH_RESULTS_PATH, task, DATASET_NAMES{dataset}, SCALE_NAMES{scale}, 'l2norm.csv')));
    end

    % combine into single struct
    cnn.corr = corr;
    cnn.sim = sim;
    cnn.l2 = l2;

    % export csv for one study
    save(fullfile(SAVE_PATH, task, ['cnn_' task '_res_' DATASET_NAMES{dataset} '.mat']), "cnn");
end

clear study scale sim corr l2 cnn task

%%
task = 'vgg16'; 
readmatrix(fullfile(PYTORCH_RESULTS_PATH, task, DATASET_NAMES{1}, SCALE_NAMES{1}, 'correlations.csv'))
%%
for dataset = DATASET_NAMES
    disp(dataset{1})
end