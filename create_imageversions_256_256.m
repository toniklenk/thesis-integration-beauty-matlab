%% Taskonomy models
% resize to 256x256
% rescale to [-1, 1]
scale_factor = 1/8;
for i=1:length(allImg)
    imgName = [allImg(i).folder,'/',allImg(i).name];
    imgname = allImg(i).name;
    imgname = imgname(1:end-4);

    im = imread(imgName);
    im = imresize(im,[640,640]);
    imv1 = im;
    imv2 = im;

    for i1=1:1/scale_factor
        for i2=1:1/scale_factor
            if mod(i1+i2,2)==0
                imv1([1:640*scale_factor]+640*scale_factor*(i1-1),[1:640*scale_factor]+640*scale_factor*(i2-1),:)=127;
            else
                imv2([1:640*scale_factor]+640*scale_factor*(i1-1),[1:640*scale_factor]+640*scale_factor*(i2-1),:)=127;
            end
        end
    end


    im = single(im); % note: 255 range
    im = im / 127.5 - 1;
    im = imresize(im, [256,256]);
    save(['../Taskonomy Integration/data/stimuli_places1/untransformed/scale8/full/',imgname], "im")

    imv1 = single(imv1); % note: 255 range
    imv1 = imresize(imv1, [256,256]);
    imv1 = imv1 / 127.5 - 1;
    save(['../Taskonomy Integration/data/stimuli_places1/untransformed/scale8/version1/',imgname], "imv1")

    imv2 = single(imv2); % note: 255 range
    imv2 = imresize(imv2, [256,256]);
    imv2 = imv2 / 127.5 - 1;
    save(['../Taskonomy Integration/data/stimuli_places1/untransformed/scale8/version2/',imgname], "imv2")
end


%% Places 1
% Taskonomy models: resize to 256x256 rescale to [-1, 1]
dir_places1 = dir(['./stimuli_places1/*.jpg']);

scale_factor = 1/8;
for scale = [2 4 8 16 32]
    for i=1:length(dir_places1)
        imgpath = [allImg(i).folder,'/',allImg(i).name];
        imgname = allImg(i).name;
        imgname = imgname(1:end-4);
    
        im = imread(imgpath);
        im = imresize(im,[640,640]);
        imv1 = im;
        imv2 = im;
        

        scale_factor = 1/scale;
        for i1=1:scale
            for i2=1:scale
                if mod(i1+i2,2)==0
                    imv1([1:640*scale_factor]+640*scale_factor*(i1-1),[1:640*scale_factor]+640*scale_factor*(i2-1),:)=127;
                else
                    imv2([1:640*scale_factor]+640*scale_factor*(i1-1),[1:640*scale_factor]+640*scale_factor*(i2-1),:)=127;
                end
            end
        end
    
        % 224 x 224
        im = single(im); % note: 255 range
        im = im / 127.5 - 1;
        im = imresize(im, [256,256]);
        save(['../Taskonomy Integration/data/stimuli_places1/untransformed/scale8/full/',imgname], "im")
    
        imv1 = single(imv1); % note: 255 range
        imv1 = imresize(imv1, [256,256]);
        imv1 = imv1 / 127.5 - 1;
        save(['../Taskonomy Integration/data/stimuli_places1/untransformed/scale8/version1/',imgname], "imv1")
    
        imv2 = single(imv2); % note: 255 range
        imv2 = imresize(imv2, [256,256]);
        imv2 = imv2 / 127.5 - 1;
        save(['../Taskonomy Integration/data/stimuli_places1/untransformed/scale8/version2/',imgname], "imv2")
    end
end