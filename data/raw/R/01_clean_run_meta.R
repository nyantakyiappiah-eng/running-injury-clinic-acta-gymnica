## 01_clean_run_meta.R
## Create cleaned analysis dataset from Running Injury Clinic metadata

library(dplyr)

# Paths (adjust if needed)
run_path  <- "data/raw/run_data_meta.csv"
walk_path <- "data/raw/walk_data_meta.csv"

# 1. Read metadata
run_meta  <- read.csv(run_path)
walk_meta <- read.csv(walk_path)

# 2. Basic cleaning and derived variables (running data)
run_clean <- run_meta %>%
  mutate(
    # Binary injury status: 0 = no injury, 1 = any injury definition
    inj_status = case_when(
      InjDefn == "No injury" ~ 0L,
      InjDefn == "" | is.na(InjDefn) ~ NA_integer_,
      TRUE ~ 1L
    ),
    # BMI (kg/m^2)
    bmi = ifelse(!is.na(Height) & !is.na(Weight),
                 Weight / (Height / 100)^2, NA_real_),
    # Factor variables
    sex   = factor(Gender,
                   levels = c("Male", "Female", "Unknown")),
    level = factor(Level),
    yrs_running = as.numeric(YrsRunning),
    speed_r     = as.numeric(speed_r)
  ) %>%
  # Keep only observations with clear injury status
  filter(!is.na(inj_status))

# 3. Apply analysis restrictions
analysis <- run_clean %>%
  filter(
    !is.na(age),
    age >= 18, age <= 75,
    !is.na(bmi),
    bmi >= 15, bmi <= 50,
    !is.na(yrs_running),
    !is.na(level),
    sex %in% c("Male", "Female"),
    !is.na(speed_r)
  )

# Optional: drop empty level and unused factor levels
analysis <- analysis %>%
  filter(level != "") %>%
  mutate(
    sex   = droplevels(sex),
    level = droplevels(level)
  )

# 4. Save cleaned dataset for downstream scripts
if (!dir.exists("data/derived")) dir.create("data/derived", recursive = TRUE)
saveRDS(analysis, file = "data/derived/analysis_run_meta.rds")

