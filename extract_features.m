function extract_features(opts)

if ~exist(opts.fileFeatures,'file')
    load(opts.fileImages,'images');
    
    if ~exist(opts.fileGMM,'file')
        % Computes GMM and PCA models
        idxTrainGMM = sort(randperm(length(images),opts.numWordsTrainGMM));
        [GMM,PCA] = compute_GMM_PCA_models(opts,images(idxTrainGMM));
        save(opts.fileGMM,'GMM');
        save(opts.filePCA,'PCA');
    else
        load(opts.fileGMM);
        load(opts.filePCA);
    end
    
    % Extracts FV representation from dataset images
    features = extract_FV_features(opts,images,GMM,PCA);
    
    save(opts.fileFeatures,'features');
end

end