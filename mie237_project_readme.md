# Beats vs Books: Music's Impact on Arithmetic Accuracy and Speed

## 📝 Overview

This repository contains the final report, dataset, and interface code for our MIE237 project: **Beats vs Books**.

The study examines whether background music influences cognitive performance on mental arithmetic tasks, and whether that influence changes depending on task difficulty. By comparing performance on easy and hard arithmetic problems under two conditions (smooth jazz music vs. silence), this project aims to better understand how everyday study habits affect academic task performance, specifically for undergraduate engineering students.

**Current Status:** Completed (MIE237 Final Project)

## 📂 Repository Structure

This repository contains the following key components:

* **`MIE237 Final Report_ Team 9 (2).pdf`**: The finalized project report detailing our literature review, methodology, two-factor ANOVA analysis, and conclusions.

* **`BeatsvsBooks_CompiledData - names redacted.csv`**: The combined dataset containing the raw response data (number of problems attempted and accuracy) from all 12 participants across all four experimental conditions.

* **`Experimental Study Design`**: Contains the source code and assets for the interactive Figma-based arithmetic task interface used to administer the experiment and record participant responses.

* **`BeatsvsBooks.R`**: The R script used to compute descriptive statistics, generate diagnostic plots, and run the blocked two-factor ANOVA test.

## 📊 Key Findings

Our study utilized a 2x2 within-subject design (Audio Condition x Task Difficulty) and yielded the following results:

* **Task Difficulty:** Significantly impacted accuracy ($p=0.005$), with lower accuracy observed in hard conditions (high working-memory load).

* **Audio Condition:** Background music had no statistically significant effect on either the number of problems attempted ($p=0.650$) or overall accuracy ($p=0.834$).

* **Interaction:** No significant interaction was found between audio condition and task difficulty.

## 💻 How to Use This Repository

1. **Read the Report:** Start with `MIE237 Final Report_ Team 9 (2).pdf` for a comprehensive overview of the study's design, execution, and statistical findings.

2. **Explore the Data:** The raw data is available in `BeatsvsBooks_CompiledData.csv` for independent review or replication of our ANOVA testing.

3. **Run the Interface:** Navigate to the `/dashboard-interface/` directory to view the code that ran the 1.5-minute timed arithmetic sessions. *\[Add specific instructions here if users need to run a local server or open a specific file to view the interface\]*

## 👤 Project Authors (Team 9)

* **Alexis Maheras** (1010863059)

* **Francesca Mangano** (1010951864)

* **Gabriela Dos Santos** (1011043620)

*This project was completed for MIE237 at the University of Toronto. All materials are original and adhere to the university's academic integrity guidelines.*
