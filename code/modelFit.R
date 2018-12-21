modelFit <- function(formula, train.data, test.data, model = c("bag", "cox", "lm", "logit", "rf"), 
         seed, target_column) {
  
  require(ipred)
  require(survival)
  require(randomForest)
  require(PRROC)
  
  set.seed(seed)
  
  fit_model <- switch(
    model,
    "bag" = bagging(formula = formula, data = train.data),
    "lm" = lm(formula = formula, data = train.data),
    "logit" = glm(formula = formula, data = train.data, family = binomial(link = "logit")),
    "rf" = randomForest(formula = formula, data = train.data),
    "cox" = coxph(formula = formula, data = train.data, ties = "breslow")
  )
  
  pred <- predict(fit_model, test.data[, -which(names(test.data) %in% target_column)])
  roc <- roc.curve(scores.class0 = pred, weights.class0 = test.data[, target_column])
  pr <- pr.curve(scores.class0 = pred, weights.class0 = test.data[, target_column], rand.compute = T)
  
  return(list(roc = roc, pr = pr))
}
