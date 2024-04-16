clear
clc

warning off

%study
for st=1:4
    
    if st==1
        stim_type='places1_short';
        cnn_type='places1';
    elseif st==2
        stim_type='places1';
        cnn_type='places1';
    elseif st==3
        stim_type='places2';
        cnn_type='places2';
    else
        stim_type='oasis';
        cnn_type='oasis';
    end
    
    %load behavioral data
    load(['./behavior/study',num2str(st),'_',stim_type]);
    load(['./results/cnn_places365_res_',cnn_type]);
    
    %% compute correlations

    for scale=1:5

        %choose behaviour
        d1=mean(res.beauty,2); 

        %cnn
        % images
        for c=1:size(cnn.corr{1},2)

            %choose dnn variables (integration, self-similarity, competition)
            d2=-cnn.corr{scale}(:,c);
            d3=cnn.sim{scale}(:,c);
            d4=cnn.l2{scale}(:,c);

            %integration effect
            [r,p]=corr(d1,d2,'type','Spearman');
            dat.c{st}{1}{scale}(c,1)=r;
            dat.p{st}{1}{scale}(c,1)=p;

            %part-similarity effect
            [r,p]=corr(d1,d3,'type','Spearman');
            dat.c{st}{2}{scale}(c,1)=r;
            dat.p{st}{2}{scale}(c,1)=p;

            %integration effect (unique, wrt part-similarity)
            [r,p]=partialcorr(d1,d2,d3,'type','Spearman');
            dat.c{st}{3}{scale}(c,1)=r;
            dat.p{st}{3}{scale}(c,1)=p;

            %L2 for whole image
            [r,p]=corr(d1,d4,'type','Spearman');
            dat.c{st}{4}{scale}(c,1)=r;
            dat.p{st}{4}{scale}(c,1)=p;

            %integration effect (unique, wrt L2)
            [r,p]=partialcorr(d1,d2,d4,'type','Spearman');
            dat.c{st}{5}{scale}(c,1)=r;
            dat.p{st}{5}{scale}(c,1)=p;

            %store all variables
            dat.data{st}{scale}{c}=[d1,d2,d3,d4];

            %partial out complexity and order
            if st==3
                dat.corr_co(:,:,c)=corr([d1,d2,mean(res.complexity,2),mean(res.order,2)],'type','Spearman');
                [r,p]=partialcorr(d1,d2,mean(res.complexity,2),'type','Spearman');
                dat.c_co{1}{1}{scale}(c,1)=r;
                dat.p_co{1}{1}{scale}(c,1)=p;
                [r,p]=partialcorr(d1,d2,mean(res.order,2),'type','Spearman');
                dat.c_co{2}{1}{scale}(c,1)=r;
                dat.p_co{2}{1}{scale}(c,1)=p;
            end
            
        end
    end

    %% compute GLMs
    
    %choose behaviour
    d1=mean(res.beauty,2);
    d1_individual=res.beauty;

    %compute regression for each spatial scale
    for scale=1:5

        X=-cnn.corr{scale};

        %zscore
        X=zscore(X,0,1);
        Y=d1;
        Y=zscore(Y,0,1);

        %perform cross-validated glm
        Z=zeros(size(X,1),1);

        for i=1:size(X,1)

            %split into train and test set
            all_i=1:size(X,1);
            train_i=all_i(not(all_i==i));
            test_i=i;
            
            %get regression coefficients
            B=regress(Y(train_i),[X(train_i,:),ones(size(Y(train_i)))]);

            %get prediction for left-out image
            Z(i,1)=sum(B(1:end-1)'.*X(test_i,:));

        end

        %evaluate predictions
        [r,p]=corr(Z,Y,'type','Spearman');
        dat.r_crossval{st}{1}(1,scale)=r;
        dat.p_crossval{st}{1}(1,scale)=p;

    end

end

save ./results/cnn_prediction dat