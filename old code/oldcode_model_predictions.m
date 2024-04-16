
load('./vgg16_places365/vggnet16_places365.mat');


%% inspect dnn
net.Layers

%% send image thorugh dnn
im = imresize(im, net.Layers(1).InputSize(1:2));
im_ = single(im); % note: 255 range

%% inspect last layer predictions
sort(predict(net, im_))
predict(net, im_)

%% inspect intermediate layer activations
a = activations(net, im_, 'conv1_1');












%% TENSOR OF ONES

%% LAYER 1
%% get activation in PyTorchs first conv layer
py_c1 = conv1;
clear conv1

%% get activatvation in PyTorch's first convolutional dimension
py_c1_d1 = squeeze(py_c1(3,:,:));


%% get activation in Matlabs first conv layer
mat_c1 = activations(net, ones(224,224,3), 'conv1_1');

%% get activation in matlabs first convolutional dimension
mat_c1_d1 = mat_c1(:,:,3);

%% 
squeeze(py_c1(1,2:223,2:223))

%% compare all concolutional dimensions in first layer

%p = squeeze(py_c1(13,2:223,2:223));

for i = 1:64
    p = uint32(squeeze(py_c1(i,2:223,2:223))*1000);
    m = uint32(squeeze(mat_c1(2:223,2:223,i))*1000);

    %p = squeeze(py_c1(i,2:223,2:223));
    %m = squeeze(mat_c1(2:223,2:223,i));

    if sum(sum(p == m)) == 222*222
        disp(i)
    end
end
clear i

%% LAYER 2
%% get activation in PyTorchs first conv layer
py_c2= conv1_1;
clear conv1_1
    
%% get activatvation in PyTorch's first convolutional dimension
py_c1_d1 = squeeze(py_c1_1(3,:,:));


%% get activation in Matlabs first conv layer
mat_c2 = activations(net, ones(224,224,3), 'conv1_2');

%% get activation in matlabs first convolutional dimension
mat_c1_d1 = mat_c1(:,:,3);

%% 
squeeze(py_c1(1,2:223,2:223))

%% compare all concolutional dimensions in first layer

%p = squeeze(py_c1(13,2:223,2:223));

for i = 1:64
    p = uint32(squeeze(py_c2(i,:,2:223))*1000);
    m = uint32(squeeze(mat_c2(2:223,2:223,i))*1000);

    %p = squeeze(py_c1(i,2:223,2:223));
    %m = squeeze(mat_c1(2:223,2:223,i));

    if sum(sum(p == m)) == 222*222
        disp(i)
    end
end


%% LAYER 11
%% get activation in PyTorch's layer
py_c11= conv5;
clear conv5
    
%% get activatvation in PyTorch's  layer's convolutional dimension
py_c11_d1 = squeeze(py_c11(3,:,:));


%% get activation in Matlab's layer
mat_c11 = activations(net, ones(224,224,3), 'conv5_1');

%% get activation in Matlab's layers convolutional dimension
mat_c11_d1 = mat_c11(:,:,3);

%% 
squeeze(py_c1(1,2:223,2:223))

%% compare all concolutional dimensions in first layer

%p = squeeze(py_c1(13,2:223,2:223));
l=0;
for i = 1:512
    p = uint32(squeeze(py_c11(i,:,:))*10);
    m = uint32(squeeze(mat_c11(:,:,i))*10);

    %p = squeeze(py_c1(i,2:223,2:223));
    %m = squeeze(mat_c1(2:223,2:223,i));

    if sum(sum(p == m)) == 14*14
        l = l+1;
        disp(i)
    end
end
disp(l)
clear i l p m
% i think its reasonable to assume here, that activations, apart from some
% minor decimals, are pretty much the same, so we go on to next level of
% comparison


%% REAL IMAGE

%% compare raw images
im = imread('stimuli_places1/Places365_val_00001153.jpg');
im = imresize(im, net.Layers(1).InputSize(1:2));
im = single(im);

%%
%py_image = cat(3, py_image_1, py_image_2, py_image_3);

py_image_1 = single(py_image_1);
py_image_2 = single(py_image_2);
py_image_3 = single(py_image_3);

im(:,:,1) - py_image_1;
im(:,:,2) - py_image_2;
im(:,:,3) - py_image_3;

% images are slightly different, but on a scale that should be within the 
% invariance of the dnn, however dnn's might be sensitive to very small
% changes
%%
net.Layers
%% activations matlab
ma1 = activations(net, im, 'conv1_1');

%% activations pytorch
pa1 = conv1;
clear conv1

%% compute L1 distance between activations

a = ma1(:,:,1);
b = squeeze(pa1(1,:,:));

% there are already at this level horendous differences in activation
% between matlab and pytorch, lets find out if this is due to error
% propagation of the differences in the image resizing or due to how
% pytorch and matlab compute activations.
% test the first possibility first.


%%
sum(uint32(ma1(:,:,1)*1000) == uint32(squeeze(pa1(1,:,:))*1000),'all')







