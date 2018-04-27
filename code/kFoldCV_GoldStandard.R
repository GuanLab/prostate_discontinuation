source("modelFit.R")
kFoldCV_GoldStandard <- function(data, fold = 5, seed) {
  set.seed(seed)
  data <- data[sample(nrow(data)), ]
  folds <- cut(seq(1, nrow(data)), breaks = fold, labels = F)
  
  result <- data.frame()
  for (i in 1:fold) {
    testIndexes <- which(folds == i, arr.ind = T)
    test <- data[testIndexes, ]
    train <- data[-testIndexes, ]
    
    train$DISCONT <- as.numeric(as.character(train$DISCONT))
    train$DISCONT_day <- as.numeric(as.character(train$DISCONT_day))
    train <- na.omit(train)
    test$DISCONT <- as.numeric(as.character(test$DISCONT))
    test$DISCONT_day <- as.numeric(as.character(test$DISCONT_day))
    test <- na.omit(test)
    
    model_rf_78_discont <- modelFit(DISCONT ~ ., train[, c(5, 7:84)], test[, c(5, 7:84)], model = "rf",
                                    seed = 1234, target_column = "DISCONT")
    model_rf_78_new <- modelFit(new_label ~ ., train[, c(2, 7:84)], test[, c(5, 7:84)], model = "rf",
                                seed = 1234, target_column = "DISCONT")
    
    res <- data.frame(identity = rep(c("model_rf_78_discont", "model_rf_78_new", "model_rf_78_Baseline"), each = 2),
                      value = c(model_rf_78_discont$roc$auc, model_rf_78_discont$pr$auc.integral,
                                model_rf_78_new$roc$auc, model_rf_78_new$pr$auc.integral,
                                0.5, model_rf_78_discont$pr$rand$auc.integral),
                      stringsAsFactors = F)
    
    res$gold_standard <- unlist(lapply(strsplit(res$identity, "_"), "[", 4))
    res$curve <- rep(c("AUC", "AUPRC"), 3)
    
    result <- rbind(result, res)
  }
  return(result)
}