allImg=dir(['./stimuli_places1/*.jpg']);

%%
for i=1:length(allImg)
    imgName=[allImg(i).folder,'/',allImg(i).name];

    imgname = allImg(i).name;
    imgname = imgname(1:end-4);

    % Load an slice the image
    im=imread(imgName);
    im=imresize(im,[640,640]);

    im = single(im) ; % note: 255 range
    im = imresize(im, [224,224]) ;
    save(['./stimuli_places1_resized/',imgname], "im")
end