# Running Injury Clinic – Acta Gymnica Analysis

R code for a secondary analysis of the **Running Injury Clinic Kinematic Dataset** to prepare a manuscript for submission to *Acta Gymnica*.[web:28][web:49]

---

## Overview

The Running Injury Clinic Kinematic Dataset includes treadmill walking and running data from **1,798 adults**, with:[web:28][web:49]

- 3D lower‑limb kinematics from motion capture  
- Demographics (age, sex, height, weight)  
- Running history (years running, race distance, performance)  
- Current injury status and injury characteristics  

This repository focuses on the **metadata** (`run_data_meta.csv`, `walk_data_meta.csv`) to study associations between running‑related injury and runner characteristics.

---

## Data access

The original data are **not stored in this repository**.

To reproduce the analysis:

1. Open the Figshare+ dataset page:  
   **Running Injury Clinic Kinematic Dataset**  
   https://plus.figshare.com/articles/dataset/Running_Injury_Clinic_Kinematic_Dataset/24255795 [web:49]

2. Download at least:
   - `run_data_meta.csv`
   - `walk_data_meta.csv`

3. Create the following folders in your local clone and place the files there:

```text
data/
  raw/
    run_data_meta.csv
    walk_data_meta.csv
---

## Research goal

The planned manuscript will examine how current running‑related injury status relates to:[web:28][web:49]

- Age  
- Sex  
- Body mass index (BMI)  
- Years of running experience  
- Competitive level (recreational vs competitive)  
- Self‑selected treadmill speed  

using logistic regression models that align with the biomechanics and sports medicine focus of *Acta Gymnica*.[web:45]

---

## How to run

After cloning the repository and downloading the metadata files into `data/raw/`:

1. Open R (or RStudio) with the project folder as working directory.
2. Run:

```r
source("R/01_clean_run_meta.R")  # create cleaned analysis dataset
source("R/02_models.R")          # fit main models and output ORs + AUC
source("R/03_figures.R")         # generate Fig 1 (injury probability vs speed)
