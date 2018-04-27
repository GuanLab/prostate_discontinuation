source("modelFit.R")
kFoldCV_BaseLearner <- function(data, fold = 5, seed) {
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
    
    model_bag_78_discont <- modelFit(DISCONT ~ ., train[, c(5, 7:84)], test[, c(5, 7:84)], model = "bag",
                                     seed = 1234, target_column = "DISCONT")
    model_cox_78_discont <- modelFit(Surv(DISCONT_day, DISCONT) ~ ., train[, c(5:6, 7:84)], test[, c(5, 7:84)],
                                     model = "cox", seed = 1234, target_column = "DISCONT")
    model_lm_78_discont <- modelFit(DISCONT ~ ., train[, c(5, 7:84)], test[, c(5, 7:84)], model = "lm",
                                    seed = 1234, target_column = "DISCONT")
    model_logit_78_discont <- modelFit(as.factor(DISCONT) ~ ., train[, c(5, 7:84)], test[, c(5, 7:84)], model = "logit",
                                       seed = 1234, target_column = "DISCONT")
    model_rf_78_discont <- modelFit(DISCONT ~ ., train[, c(5, 7:84)], test[, c(5, 7:84)], model = "rf",
                                    seed = 1234, target_column = "DISCONT")
    
    res <- data.frame(identity = rep(c("model_bag_78_discont", 
                                       "model_lm_78_discont",
                                       "model_cox_78_discont",
                                       "model_logit_78_discont",
                                       "model_rf_78_discont",
                                       "model_baseline_78_discont"),
                                     each = 2),
                      value = c(model_bag_78_discont$roc$auc, model_bag_78_discont$pr$auc.integral,
                                model_lm_78_discont$roc$auc, model_lm_78_discont$pr$auc.integral,
                                model_cox_78_discont$roc$auc, model_cox_78_discont$pr$auc.integral,
                                model_logit_78_discont$roc$auc, model_logit_78_discont$pr$auc.integral,
                                model_rf_78_discont$roc$auc, model_rf_78_discont$pr$auc.integral,
                                0.5, model_rf_78_discont$pr$rand$auc.integral),
                      stringsAsFactors = F)
    
    res$model <- sapply(res$identity, function(x) {
      
      if (grepl("bag", x)) return("BAG-CART")
      if (grepl("cox", x)) return("Cox")
      if (grepl("lm", x)) return("Linear Regression")
      if (grepl("logit", x)) return("Logistic Regression")
      if (grepl("rf", x)) return("Random Forest")
      if (grepl("baseline", x)) return("Baseline")
      
    })
    res$gold_standard <- unlist(lapply(strsplit(res$identity, "_"), "[", 4))
    res$curve <- rep(c("AUC", "AUPRC"), 6)
    
    result <- rbind(result, res)
  }
  return(result)
}