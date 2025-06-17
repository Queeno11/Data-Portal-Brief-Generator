#------------------------------------------------------------------------------#
#--------------------------------------Graphs----------------------------------#
#------------------------------------------------------------------------------#
  
# This code replaces script 07_graphs from stata and improves efficiency.

library(haven)
library(dplyr)
library(tidyverse)
library(patchwork)

path <- "C:\\Users\\pilih\\Documents\\World Bank\\Briefs\\Briefs generator\\Data-Portal-Brief-Generator"
data_out_path <- paste0(path, "\\Data\\Data_Output")
charts <- paste0(path, "\\Graphs")

#--------------------------Local for page 2--------------------------*
# This locals are the selected indicators for each country based on the availability of data
# and the indicators ranking. They come from the previous do file.

locals <- read_dta(paste0(data_out_path, "\\new_locals.dta"))
locals <- locals %>%
  extract(locals, into = c("name", "value"), regex = "([^_]+)_(.*)")



#------------------------------------------------------------------------------#
#-----------------------------------GRAPHS-------------------------------------#
#------------------------------------------------------------------------------#

data_briefs <- read_dta(paste0(data_out_path, "\\data_briefs_allcountries.dta"))

## Version 2024: Keep all countries 

# Remove observations with no HCCI
vars_hcci <- data_briefs %>%
  select(
    -wbcode,
    -starts_with("wbcountry"),
    -wbregion,
    -wbincomegroup,
    -incomegroup,
    -starts_with("hci"),
    -starts_with("psurv"),
    -starts_with("eyrs"),
    -starts_with("test"),
    -starts_with("qeyrs"),
    -starts_with("asr"),
    -starts_with("nostu"),
    -starts_with("uhci"),
    -matches("_reg$"),
    -matches("_inc$")
  )

data_briefs <- data_briefs %>%
  mutate(has_hcci = rowSums(!is.na(vars_hcci)))

data_briefs <- data_briefs %>%
  filter(has_hcci!=0) %>%
  arrange(wbregion, wbcode)

#--------------------------Graph variables--------------------------#

indicators <- c("hci", "psurv", "eyrs", "qeyrs", "test", "asr", "nostu", "uhci")
labels <- c(
  "Human Capital Index",
  "Probability of Survival to Age 5 (%)",
  "Expected Years of School",
  "Learning-Adjusted Years of School",
  "Average Harmonized Test Scores",
  "Survival Rate from Age 15-60 (%)",
  "Fraction of Children Under 5 Not Stunted (%)",
  "Utilization-Adjusted Human Capital Index"
)
colors <- rep("black", length(indicators))

# Stages for Page 2
stages <- c("e", "b", "h", "l")
n_stage <- list(e = 3, b = 3, h = 3, l = 3)  # indicators per stage

#-------------------------- Graph setup--------------------------#

# For Page 1 (component indicators)
adjust_scales_p1 <- function(indicator, values) {
  values <- values[!is.na(values)]
  if (length(values) == 0) return(c(NA, NA))
  
  if (indicator %in% c("psurv", "asr", "nostu")) return(c(50, 100))
  if (indicator == "test") return(c(300, 625))
  if (indicator %in% c("eyrs", "qeyrs")) return(c(0, 14))
  
  min_val <- floor(min(values, na.rm = TRUE))
  max_val <- ceiling(max(values, na.rm = TRUE))
  return(c(min_val, max_val))
}

# For Page 2 (life stages)
adjust_scales_p2 <- function(values) {
  values <- values[!is.na(values)]
  if (length(values) == 0) return(c(NA, NA))
  min_val <- floor(min(values) / 10) * 10
  max_val <- ceiling(max(values) / 10) * 10
  return(c(min_val, max_val))
}

#--------------------------Loop on countries---------------------------#

for (ctry in countries) {
  
  # Subset data for country
  df_ctry <- data_briefs %>% filter(wbcode == ctry)
  region <- df_ctry$wbregion[1]
  
  # ----------------- Page 1: Main HCI Components -----------------
  
  plot_list_p1 <- list()
  
  for (i in seq_along(indicators_p1)) {
    ind <- indicators_p1[i]
    label <- labels_p1[i]
    
    val <- df_ctry[[ind]]
    val_reg <- df_ctry[[paste0(ind, "_reg")]]
    val_inc <- df_ctry[[paste0(ind, "_inc")]]
    
    scales <- adjust_scales_p1(ind, val)
    min_val <- scales[1]
    max_val <- scales[2]
    
    plot_data <- tibble(
      group = c("country", "region", "income"),
      x = c(val, val_reg, val_inc)
    )
    
    p <- ggplot(plot_data, aes(x = x, y = 0)) +
      geom_point(aes(color = group, shape = group), size = 6) +
      scale_color_manual(values = c("country" = "skyblue", "region" = "brown", "income" = "red")) +
      scale_shape_manual(values = c("country" = 16, "region" = 17, "income" = 15)) +
      scale_x_continuous(limits = c(min_val, max_val), expand = expansion(mult = 0.1)) +
      labs(title = label, x = NULL, y = NULL) +
      theme_minimal() +
      theme(axis.text.y = element_blank(),
            axis.ticks.y = element_blank(),
            plot.title = element_text(size = 12, face = "bold"))
    
    plot_list_p1[[i]] <- p
  }
  
  # Combine Page 1 plots and export
  final_plot_p1 <- wrap_plots(plot_list_p1, ncol = 1)
  ggsave(paste0(charts, "\\p1_", ctry, "_all.png"), final_plot_p1, width = 8, height = 20)
  print(paste("Page 1 exported for", ctry))
  
  # ----------------- 3.2 Page 2: Life Stages -----------------
  
  all_stage_plots <- list()
  
  for (stage in stages) {
    stage_plots <- list()
    
    for (m in 1:n_stage[[stage]]) {
      ind_var <- paste0(stage, m, "_", ctry)
      ind_reg_var <- paste0(ind_var, "_reg")
      ind_prev_var <- paste0(ind_var, "_prev")
      
      val <- if (ind_var %in% names(df_ctry)) df_ctry[[ind_var]] else NA
      val_reg <- if (ind_reg_var %in% names(df_ctry)) df_ctry[[ind_reg_var]] else NA
      val_prev <- if (ind_prev_var %in% names(df_ctry)) df_ctry[[ind_prev_var]] else NA
      
      if (all(is.na(c(val, val_reg, val_prev)))) next
      
      scales <- adjust_scales_p2(c(val, val_reg, val_prev))
      min_val <- scales[1]
      max_val <- scales[2]
      
      plot_data <- tibble(
        group = c("country", "region", "previous"),
        x = c(val, val_reg, val_prev)
      )
      
      p <- ggplot(plot_data, aes(x = x, y = 0)) +
        geom_point(aes(color = group, shape = group), size = 6) +
        scale_color_manual(values = c("country" = "skyblue", "region" = "brown", "previous" = "pink")) +
        scale_shape_manual(values = c("country" = 16, "region" = 17, "previous" = 15)) +
        scale_x_continuous(limits = c(min_val, max_val), expand = expansion(mult = 0.1)) +
        labs(title = paste0("Stage: ", stage, " Indicator ", m), x = NULL, y = NULL) +
        theme_minimal() +
        theme(axis.text.y = element_blank(),
              axis.ticks.y = element_blank(),
              plot.title = element_text(size = 12, face = "bold"))
      
      stage_plots[[m]] <- p
    }
    
    stage_plot <- wrap_plots(stage_plots, ncol = 1)
    all_stage_plots[[stage]] <- stage_plot
  }
  
  full_plot_p2 <- wrap_plots(all_stage_plots, ncol = 1)
  ggsave(paste0(charts, "\\p2_", ctry, "_stages.png"), full_plot_p2, width = 10, height = 20)
  print(paste("Page 2 exported for", ctry))
}
