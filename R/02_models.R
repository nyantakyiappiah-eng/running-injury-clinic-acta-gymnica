## 02_models.R
## Logistic models and basic diagnostics for running injury

library(dplyr)
library(splines)
library(pROC)

# Load cleaned data
analysis <- readRDS("data/derived/analysis_run_meta.rds")

# Outcome as factor
analysis$inj_status <- factor(
  analysis$inj_status,
  levels = c(0, 1),
  labels = c("NoInjury", "Injured")
)

## 1. Main logistic regression

fit_main <- glm(
  inj_status ~ age + sex + bmi + yrs_running + level + speed_r,
  data   = analysis,
  family = binomial()
)

summary(fit_main)

# Odds ratios with 95% CIs
exp_coef <- exp(cbind(OR = coef(fit_main),
                      confint(fit_main)))
round(exp_coef, 2)

## 2. Nonlinear (spline) model

fit_spline <- glm(
  inj_status ~ ns(age, 3) + sex + bmi + ns(yrs_running, 3) + level + speed_r,
  data   = analysis,
  family = binomial()
)

anova(fit_main, fit_spline, test = "Chisq")

## 3. ROC / AUC

roc_obj <- roc(analysis$inj_status, fitted(fit_main))
auc(roc_obj)
