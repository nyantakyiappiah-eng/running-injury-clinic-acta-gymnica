## 03_figures.R
## Predicted probabilities vs speed, by competitive level

library(dplyr)
library(ggplot2)

# Load cleaned data
analysis <- readRDS("data/derived/analysis_run_meta.rds")

# Drop empty level and unused levels, refit model as before
analysis2 <- analysis %>%
  filter(level != "") %>%
  mutate(
    sex   = droplevels(sex),
    level = droplevels(level)
  )

fit_main2 <- glm(
  inj_status ~ age + sex + bmi + yrs_running + level + speed_r,
  data   = analysis2,
  family = binomial()
)

# Reference values
ref_age <- median(analysis2$age, na.rm = TRUE)
ref_bmi <- median(analysis2$bmi, na.rm = TRUE)
ref_yrs <- median(analysis2$yrs_running, na.rm = TRUE)
ref_sex <- levels(analysis2$sex)[1]

speed_seq <- seq(
  from = min(analysis2$speed_r, na.rm = TRUE),
  to   = max(analysis2$speed_r, na.rm = TRUE),
  length.out = 100
)

newdat <- expand.grid(
  speed_r = speed_seq,
  level   = levels(analysis2$level),
  KEEP.OUT.ATTRS = FALSE,
  stringsAsFactors = FALSE
) %>%
  mutate(
    age         = ref_age,
    bmi         = ref_bmi,
    yrs_running = ref_yrs,
    sex         = ref_sex,
    sex   = factor(sex,   levels = levels(analysis2$sex)),
    level = factor(level, levels = levels(analysis2$level))
  )

pred <- predict(fit_main2, newdata = newdat, type = "link", se.fit = TRUE)
newdat$pred_prob <- plogis(pred$fit)
newdat$lower     <- plogis(pred$fit - 1.96 * pred$se.fit)
newdat$upper     <- plogis(pred$fit + 1.96 * pred$se.fit)

fig1_ci <- ggplot(newdat, aes(x = speed_r, y = pred_prob, color = level, fill = level)) +
  geom_line(linewidth = 1.1) +
  geom_ribbon(aes(ymin = lower, ymax = upper), alpha = 0.15, color = NA) +
  labs(
    x = "Self-selected treadmill running speed (m/s)",
    y = "Predicted probability of current injury",
    color = "Competitive level",
    fill  = "Competitive level"
  ) +
  theme_minimal(base_size = 12)

# Save figure
if (!dir.exists("figs")) dir.create("figs")
ggsave("figs/fig1_injury_prob_by_speed.png", fig1_ci, width = 7, height = 5, dpi = 300)
