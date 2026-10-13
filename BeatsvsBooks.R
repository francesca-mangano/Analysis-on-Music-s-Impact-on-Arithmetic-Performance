# =========================
# MIE237 Project Analysis
# Beats vs Books
# Within-subject 2x2 design
# =========================
library(tidyverse)
#Reminder to TAs - this was compiled on a mac, make sure to getwd() and setwd()

# -------------------------
# Load and prepare data
# -------------------------
dat <- read_csv("BeatsvsBooks_CompiledData.csv", show_col_types = FALSE)

#Factoring the data
dat <- dat %>%
  mutate(
    Participant_ID   = factor(Participant_ID),
    Condition_Order  = factor(Condition_Order,
                              levels = c("silence_first", "music_first")),
    Audio_Condition  = factor(Audio_Condition,
                              levels = c("no_music", "music")),
    Difficulty       = factor(Difficulty,
                              levels = c("easy", "hard"))
  )

#Check structure
glimpse(dat)

# Confirm balanced within-subject design
dat %>%
  count(Participant_ID, Audio_Condition, Difficulty)

# -------------------------
#Descriptive statistics
# -------------------------

# Cell means for each DV: Problems Attempted and Accuracy
#Descriptive Statistics across the 4 conditions
attempted_cell_summary <- dat %>%
  group_by(Audio_Condition, Difficulty) %>%
  summarise(
    mean_attempted = mean(Problems_Attempted),
    sd_attempted   = sd(Problems_Attempted),
    n              = n(),
    .groups = "drop"
  )

accuracy_cell_summary <- dat %>%
  group_by(Audio_Condition, Difficulty) %>%
  summarise(
    mean_accuracy = mean(Accuracy_Percent),
    sd_accuracy   = sd(Accuracy_Percent),
    n             = n(),
    .groups = "drop"
  )

attempted_cell_summary
accuracy_cell_summary

#Participant-level summaries
#For the purpose of familiarizing myself, not for report contents, this doesn't really say much basically just repeats the dataset
dat %>%
  group_by(Participant_ID) %>%
  summarise(
    mean_attempted = mean(Problems_Attempted),
    sd_attempted   = sd(Problems_Attempted),
    mean_accuracy  = mean(Accuracy_Percent),
    sd_accuracy    = sd(Accuracy_Percent),
    .groups = "drop"
  )

# -------------------------
# Visual Exploration
# -------------------------

# Interaction plot for Problems Attempted
ggplot(dat, 
       aes(x = Difficulty, 
           y = Problems_Attempted, 
           colour = Audio_Condition)) +
  geom_jitter(width = 0.08, 
              alpha = 0.4, 
              size = 2) +
  stat_summary(fun = mean, geom = "point", size = 4) +
  stat_summary(fun = mean, geom = "line",
               aes(group = Audio_Condition), linewidth = 1.2) +
  theme_classic(base_size = 14) +
  labs(
    title = "Interaction Plot: Problems Attempted",
    x = "Difficulty",
    y = "Problems Attempted",
    colour = "Audio Condition"
  )

# Reversed interaction plot for Problems Attempted
ggplot(dat, aes(x = Audio_Condition, y = Problems_Attempted, colour = Difficulty)) +
  geom_jitter(width = 0.08, alpha = 0.4, size = 2) +
  stat_summary(fun = mean, geom = "point", size = 4) +
  stat_summary(fun = mean, geom = "line",
               aes(group = Difficulty), linewidth = 1.2) +
  theme_classic(base_size = 14) +
  labs(
    title = "Interaction Plot: Problems Attempted",
    x = "Audio Condition",
    y = "Problems Attempted",
    colour = "Difficulty"
  )

# Interaction plot for Accuracy
ggplot(dat, aes(x = Difficulty, y = Accuracy_Percent, colour = Audio_Condition)) +
  geom_jitter(width = 0.08, alpha = 0.4, size = 2) +
  stat_summary(fun = mean, geom = "point", size = 4) +
  stat_summary(fun = mean, geom = "line",
               aes(group = Audio_Condition), linewidth = 1.2) +
  theme_classic(base_size = 14) +
  labs(
    title = "Interaction Plot: Accuracy",
    x = "Difficulty",
    y = "Accuracy (%)",
    colour = "Audio Condition"
  )

# Reversed interaction plot for Accuracy
ggplot(dat, aes(x = Audio_Condition, y = Accuracy_Percent, colour = Difficulty)) +
  geom_jitter(width = 0.08, alpha = 0.4, size = 2) +
  stat_summary(fun = mean, geom = "point", size = 4) +
  stat_summary(fun = mean, geom = "line",
               aes(group = Difficulty), linewidth = 1.2) +
  theme_classic(base_size = 14) +
  labs(
    title = "Interaction Plot: Accuracy",
    x = "Audio Condition",
    y = "Accuracy (%)",
    colour = "Difficulty"
  )

# Participant effects (blocked design)
ggplot(dat, aes(x = Participant_ID, y = Problems_Attempted)) +
  geom_boxplot() +
  theme_minimal() +
  labs(
    title = "Participant Differences in Problems Attempted",
    x = "Participant",
    y = "Problems Attempted"
  ) +
  theme(axis.text.x = element_text(angle = 45, hjust = 1))

ggplot(dat, aes(x = Participant_ID, y = Accuracy_Percent)) +
  geom_boxplot() +
  theme_minimal() +
  labs(
    title = "Participant Differences in Accuracy",
    x = "Participant",
    y = "Accuracy (%)"
  ) +
  theme(axis.text.x = element_text(angle = 45, hjust = 1))

# -------------------------
#Blocked two-factor ANOVA
# -------------------------
# Same structure as Lab 11 Part 2:
# response ~ factor1 * factor2 + participant
#the structure above reflections the interaction between -> factor1*factor2 + blocking(participantID)
#Note that we are NOT including ORDER of music vs no music(whether the participant was tested under one or the other first)

fit_attempted <- aov(Problems_Attempted ~ Audio_Condition * Difficulty + Participant_ID,
                     data = dat)

fit_accuracy <- aov(Accuracy_Percent ~ Audio_Condition * Difficulty + Participant_ID,
                    data = dat)

summary(fit_attempted)
summary(fit_accuracy)

# Extract the interaction rows directly from the ANOVA table
summary(fit_attempted)[[1]]["Audio_Condition:Difficulty", ]
summary(fit_accuracy)[[1]]["Audio_Condition:Difficulty", ]

# -------------------------
# Model diagnostics
#We'll use this to generate plots that verify that ANOVA assumptions are met
# -------------------------

# Problems Attempted
par(mfrow = c(1, 2))
plot(fit_attempted, which = 1)
plot(fit_attempted, which = 2)
par(mfrow = c(1, 1))
#Conclusion: Residuals appear randomly scattered with no clear pattern, 
#suggests that homoscedasticity is satisfied.
#The Q-Q plot indicates that residuals are approximately normally 
#distributed, with minor deviations in the tails due to a small number of outliers.

# Accuracy
par(mfrow = c(1, 2))
plot(fit_accuracy, which = 1)
plot(fit_accuracy, which = 2)
par(mfrow = c(1, 1))
#Conclusions:
#The residuals vs fitted plot suggests a slight variation in spread, 
#with a few outliers present. However, no strong funnel pattern is observed, and 
#the variance appears reasonably constant overall.
#The Q-Q plot indicates that residuals are approximately normally distributed, 
#with slight deviations at the tails attributable to a small number of outliers(points 46 and 4).
