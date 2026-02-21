# Running Injury Clinic – Acta Gymnica Analysis

R code for a secondary analysis of the **Running Injury Clinic Kinematic Dataset** to prepare a manuscript for submission to *Acta Gymnica*.[web:28][web:49]

---

## Overview

The Running Injury Clinic Kinematic Dataset includes treadmill walking and running data from **1,798 adults**, with:[web:28][web:49]

- 3D lower‑limb kinematics from motion capture  
- Demographics (age, sex, height, weight)  
- Running history (years running, race distance, performance)  
- Current injury status and injury characteristics  

This repository focuses on the **metadata** files (`run_data_meta.csv`, `walk_data_meta.csv`) to study associations between running‑related injury and runner characteristics.

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
