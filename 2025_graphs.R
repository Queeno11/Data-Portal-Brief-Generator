#######################    Brief graphs generator 2025  ####################### 

# Es para la versión de briefs que mandamos a que miren

#install.packages("tidyverse")
#install.packages("ggrepel")
#install.packages("sysfonts")
library(ggplot2)
library(tidyverse)
library(showtext)
library(sysfonts)
library(ggrepel)
library(patchwork)
library(cowplot)

#Fixme: ver bien las carpetas para que coincidan con la estructura anterior
setwd("C:\\Users\\pilih\\Documents\\World Bank\\Briefs\\Briefs generator\\Data-Portal-Brief-Generator")
out <-"C:\\Users\\pilih\\Documents\\World Bank\\Briefs\\Briefs generator\\Data-Portal-Brief-Generator\\Output"
data_raw <- read_dta("C:\\Users\\pilih\\Documents\\World Bank\\Briefs\\Briefs generator\\Data-Portal-Brief-Generator\\Data\\HCI_Data\\HCP_Data.dta")

#Fixme: Tal vez esto podría ser un script aparte, de armado de la base

### Data set up###
data <- data_raw %>% mutate(
  lfp_25to54_mf_fill_2025 = lfp_25to54_mf_fill_2025*100,
  shr_wgemp_25to54_mf_fill_2025 = shr_wgemp_25to54_mf_fill_2025*100,
  unemp_25to54_mf_fill_2025 = unemp_25to54_mf_fill_2025*100,
  WIDE_OECD_compl_ter_mf_fill_2025 = WIDE_OECD_compl_ter_mf_fill_2025*100,
  surv_18to24_mf_fill_2025 = surv_18to24_mf_fill_2025*100,
  unemp_20to24_mf_fill_2025 = unemp_20to24_mf_fill_2025*100,
  surv_sa_mf_fill_2025 = surv_sa_mf_fill_2025*100,
  le_25to55_mf_fill_2025 = le_25to55_mf_fill_2025*100,
  HCI = hci_0to5_mf_2025*hci_sa_mf_2025*youth_hci_18to24_mf_2025*wlhci_25to55_mf_2025,
  HCI_m = hci_0to5_m_2025*hci_sa_m_2025*youth_hci_18to24_m_2025_v3*wlhci_25to55_m_2025,
  HCI_f = hci_0to5_f_2025*hci_sa_f_2025*youth_hci_18to24_f_2025_v3*wlhci_25to55_f_2025
)

#Country selection
#Fixme: Loop for every country
data_alb <- data%>% filter(wbcode == "ALB")

#Fixme: Temporalmente sacamos promedios regionales a mano
data_reg <- data %>% filter(wbregion == "Europe & Central Asia") %>%  # filtro filas
  select(-wbcountryname, -wbcode, -year, -wbincomegroup, -wbregion) %>%  # excluyo columnas que no quiero resumir
  summarise(across(where(is.numeric), mean, na.rm = TRUE))  # promedio columnas numéricas restantes

#Fixme: Temporalmente sacamos promedios de ingresos a mano
data_inc <- data %>% filter(wbincomegroup == "Upper middle income") %>%  # filtro filas
  select(-wbcountryname, -wbcode, -year, -wbincomegroup, -wbregion) %>%  # excluyo columnas que no quiero resumir
  summarise(across(where(is.numeric), mean, na.rm = TRUE))  # promedio columnas numéricas restantes

######### Graph functions and setup #########

font_add_google(name = "Open Sans", family = "Open Sans")
showtext_auto()
showtext_opts(dpi = 300)

# Función para generar gráfico LHCI por grupo etario
crear_lhci_plot <- function(country_value, income_value, region_value,
                            title_text,
                            country_name = "Albania",
                            income_label = "Upper middle \nincome average",
                            region_label = "Europe and Central \nAsia average",
                            show_legend = FALSE,
                            xmin = 0,
                            xmax = 1){
  
  # Armar datos con nombre del país como columna
  data <- data.frame(
    Category = title_text,
    Country = country_value,
    IncomeGroup = income_value,
    Region = region_value
  ) %>%
    pivot_longer(cols = c(Country, IncomeGroup, Region),
                 names_to = "Type", values_to = "Value") %>%
    mutate(
      Size = case_when(
        Type == "Country" ~ 8,
        Type == "IncomeGroup" ~ 6,
        Type == "Region" ~ 6
      ),
      Alpha = case_when(
        Type == "Country" ~ 1,      # opaco
        TRUE              ~ 0.6     # traslúcido para los otros dos
      ),
      Type = factor(Type, levels = c("Country", "IncomeGroup", "Region"))
    )
  
  # Colores y etiquetas dinámicas
  colores <- c(
    "Country" = "#0094B5",
    "IncomeGroup" = "#b2443a", 
    "Region" = "#264653"
  )
  etiquetas <- c(
    "Country" = paste0("Latest available \ndata for ", country_name),
    "IncomeGroup" = income_label,
    "Region" = region_label
  )
  
  # Construcción del gráfico
  plot <- ggplot() +
    # Segmento de base
    geom_segment(aes(x = xmin, xend = xmax, y = 0, yend = 0), color = "gray97", linewidth = 9) +
    # Ticks verticales en los extremos
    geom_segment(aes(x = xmin, xend = xmin, y = -0.03, yend = 0.03), color = "black", linewidth = 0.7) +
    geom_segment(aes(x = xmax, xend = xmax, y = -0.03, yend = 0.03), color = "black", linewidth = 0.7) +
    # Valores de los extremos
    annotate("text", x = xmin, y = -0.005, label = xmin, size = 4, color = "black", hjust = 0.5, vjust = 2.5, family = "Open Sans") +
    annotate("text", x = xmax, y = -0.005, label = xmax, size = 4, color = "black", hjust = 0.5, vjust = 2.5, family = "Open Sans") +
    # Puntos
    geom_point(data = data, shape = 16,
               aes(x = Value, y = 0, color = Type, size = Size, alpha = Alpha))+
    # Texto de los puntos
    geom_text(data = data %>% filter(Type == "Country")%>%
                mutate(ValueLabel = format(round(Value, 2), nsmall = 2)),
              aes(x = Value, y = 0, label = ValueLabel),
              vjust = -1.5, fontface = "bold", size = 4, family = "Open Sans") +
    # Titulo
    annotate("text", x = xmin, y = 0.08, label = title_text,
             hjust = 0, vjust = 0, fontface = "bold", size = 4.4,
             family = "Open Sans") +
    
    scale_color_manual(name = NULL, values = colores, labels = etiquetas) +
    scale_size_identity() +
    scale_alpha_identity() +
    scale_x_continuous(
      limits = c(xmin, xmax),
      breaks = function(x) pretty(x, n = 2)
    ) +
    scale_y_continuous(limits = c(-0.1, 0.1)) +
    #labs(title = title_text) +
    theme_void(base_family = "Open Sans") +
    theme(
      plot.title = element_text(hjust = 0.06, vjust = -1, face = "bold", size = 11, family = "Open Sans"),
      axis.text.x = element_blank(),
      axis.ticks.x = element_line(),
      axis.line.x = element_blank(),
      legend.position = if (show_legend) c(0.52, 0.2) else "none",
      legend.justification = "center",
      legend.direction = "horizontal",
      legend.text = element_text(color="black", size =11, family = "Open Sans"),
      legend.key.width = unit(1, "cm"),
      plot.margin = margin(0, 0, 0, 0, "pt"),
      panel.spacing = unit(0, "pt")
    ) +
    guides(color = if (show_legend) {
      guide_legend(nrow = 1, byrow = TRUE,
                   override.aes = list(size = 4, alpha = c(1, 0.6, 0.6)))
    } else {
      "none"
    })
  
  return(plot)
}

crear_titulo_etapa <- function(titulo) {
  ggplot() +
    annotate("text", x = 0.5, y = 0, label = titulo,
             hjust = 0.5, vjust = 0, fontface = "bold",
             size = 5, family = "Open Sans") +
    theme_void() +
    theme(
      plot.margin = margin(0, 0, 0, 0, "pt")
    )}




######### Page 1 #########

# ---------- LCHI por etapa de la vida  ---------- #
  (p_lhci <- crear_lhci_plot(data_alb$HCI, data_reg$HCI, data_inc$HCI, "Lifetime Human Capital Index (LHCI)", show_legend = TRUE))
  p_ec   <- crear_lhci_plot(data_alb$hci_0to5_mf_2025, data_reg$hci_0to5_mf_2025, data_inc$hci_0to5_mf_2025, "Early Childhood HCI (0-5)")
  p_sa   <- crear_lhci_plot(data_alb$hci_sa_mf_2025, data_reg$hci_sa_mf_2025, data_inc$hci_sa_mf_2025, "School Age HCI (6-17)")
  p_ya   <- crear_lhci_plot(data_alb$youth_hci_18to24_mf_2025, data_reg$youth_hci_18to24_mf_2025, data_inc$youth_hci_18to24_mf_2025, "Youth Adult HCI (18-24)")
  p_wa   <- crear_lhci_plot(data_alb$wlhci_25to55_mf_2025, data_reg$wlhci_25to55_mf_2025, data_inc$wlhci_25to55_mf_2025, "Working Age HCI (25-65)")
  
  # Armar layout
  combined <- (p_lhci / p_ec / p_sa / p_ya / p_wa) +
    plot_layout(ncol = 1, guides = "collect")
  
  final_Albania <- combined & 
    theme(
      plot.title = element_text(family = "Open Sans", face = "bold", size = 11, hjust = 0.06),
      legend.position      = "bottom",
      #legend.key.width = unit(0.1, "cm"),
      legend.direction     = "horizontal",
      legend.box           = "horizontal",
      legend.justification = "center",
    )
  
  final_Albania
  ggsave(filename = paste(out, "/lchi_stage.png", sep =""),
         plot= final_Albania, width = 5.5, height = 5.5,dpi = 300,  bg = "white")

# ---------- Opción 5: plot del LCHI solo por género  ---------- #
{
  # Función para generar gráfico LHCI por grupo etario
  crear_gender_plot <- function(female_value, male_value,
                                title_text,
                                female_label = "Women average",
                                male_label = "Men average",
                                show_legend = FALSE) {
    
    # Armar datos con nombre del país como columna
    data <- data.frame(
      Category = title_text,
      Female = female_value,
      Male = male_value
    ) %>%
      pivot_longer(cols = c(Female, Male),
                   names_to = "Type", values_to = "Value")
    # Colores y etiquetas dinámicas
    colores <- c(
      "Female" = "#FF9800",
      "Male" = "#664AB6"
    )
    etiquetas <- c(
      "Female" = female_label,
      "Male" = male_label
    )
    
    # Construcción del gráfico
    plot <- ggplot() +
      # Segmento de base
      geom_segment(aes(x = 0, xend = 1, y = 0, yend = 0), color = "gray97", linewidth = 9) +
      # Ticks verticales en los extremos ( y = -0.02, yend = 0.02 si inclue lhci)
      geom_segment(aes(x = 0, xend = 0, y = -0.025, yend = 0.025), color = "black", linewidth = 0.7) +
      geom_segment(aes(x = 1, xend = 1, y = -0.025, yend = 0.025), color = "black", linewidth = 0.7)+
      # Valores de los extremos
      annotate("text", x = 0, y = -0.005, label = "0", size = 4, color = "black", hjust = 0.5, vjust = 2.5, family = "Open Sans") +
      annotate("text", x = 1, y = -0.005, label = "1", size = 4, color = "black", hjust = 0.7, vjust = 2.5, family = "Open Sans") +
      # Puntos
      geom_point(data = data, shape = 16, alpha = 0.6, size=8,
                 aes(x = Value, y = 0, color = Type))+
      # Texto de los puntos: Women arriba, Men abajo
      geom_text(
        data = data %>% filter(Type == "Female")%>%
          mutate(ValueLabel = format(round(Value, 2), nsmall = 2)),
        aes(x = Value, y = 0, label = ValueLabel),
        vjust = -1.5,              # por encima
        fontface = "bold", size = 4, family = "Open Sans"
      ) +
      geom_text(
        data = data %>% filter(Type == "Male")%>%
          mutate(ValueLabel = format(round(Value, 2), nsmall = 2)),
        aes(x = Value, y = 0, label = ValueLabel),
        vjust =  2.5,                # por debajo
        fontface = "bold", size = 4, family = "Open Sans"
      ) +
      # Titulo
      annotate("text", x = 0, y = 0.08, label = title_text,
               hjust = 0, vjust = 0, fontface = "bold", size = 4.4,
               family = "Open Sans") +
      
      scale_color_manual(name = NULL, values = colores, labels = etiquetas) +
      scale_size_identity() +
      scale_alpha_identity() +
      scale_x_continuous(limits = c(0, 1), breaks = c(0, 1)) +
      scale_y_continuous(limits = c(-0.1, 0.1)) +
      #labs(title = title_text) +
      theme_void(base_family = "Open Sans") +
      theme(
        plot.title = element_text(hjust = 0.06, vjust = -1, face = "bold", size = 11, family = "Open Sans"),
        axis.text.x = element_blank(),
        axis.ticks.x = element_line(),
        axis.line.x = element_blank(),
        legend.position = if (show_legend) c(0.52, 0.2) else "none",
        legend.justification = "center",
        legend.direction = "horizontal",
        legend.text = element_text(color="black", size =12, family = "Open Sans"),
        legend.key.width = unit(1, "cm"),
        plot.margin = margin(0, 0, 0, 0, "pt"),
        panel.spacing = unit(0, "pt")
      ) +
      guides(color = guide_legend(nrow = 1, byrow = TRUE,
                                  override.aes = list(size = 4)
      )
      )
    
    return(plot)
  }
  
  
  (p_lhci_g <- crear_gender_plot(data_alb$HCI_f, data_alb$HCI_m, "Lifetime Human Capital Index (LHCI)", show_legend = TRUE))
  p_ec_g   <- crear_gender_plot(data_alb$hci_0to5_f_2025, data_alb$hci_0to5_m_2025, "Early Childhood HCI (0-5)")
  p_sa_g   <- crear_gender_plot(data_alb$hci_sa_f_2025, data_alb$hci_sa_m_2025, "School Age HCI (6-17)")
  p_ya_g   <- crear_gender_plot(data_alb$youth_hci_18to24_f_2025_v3, data_alb$youth_hci_18to24_m_2025_v3, "Youth Adult HCI (18-24)")
  (p_wa_g   <- crear_gender_plot(data_alb$wlhci_25to55_f_2025, data_alb$wlhci_25to55_m_2025, "Working Age HCI (25-65)"))
  
  # Armar layout
  combined_g <- (p_ec_g / p_sa_g / p_ya_g / p_wa_g) +
    plot_layout(ncol = 1, guides = "collect")
  
  final_Albania_g <- combined_g & 
    theme(
      plot.title = element_text(family = "Open Sans", face = "bold", size = 11, hjust = 0.06),
      legend.position      = "bottom",
      #legend.key.width = unit(0.1, "cm"),
      legend.direction     = "horizontal",
      legend.box           = "horizontal",
      legend.justification = "center",
    )
  
  final_Albania_g
  ggsave(filename = paste(out, "/lchi_gender2.png", sep =""),
         plot= final_Albania_g, width = 5.5, height = 4.3,dpi = 300,  bg = "white")
  
}


######### Page 2 #########

### Graphs ###
data_alb <- data%>% filter(wbcode == "ALB")

data_reg <- data %>% filter(wbregion == "Europe & Central Asia") %>%  # filtro filas
  select(-wbcountryname, -wbcode, -year, -wbincomegroup, -wbregion) %>%  # excluyo columnas que no quiero resumir
  summarise(across(where(is.numeric), mean, na.rm = TRUE))  # promedio columnas numéricas restantes

data_inc <- data %>% filter(wbincomegroup == "Upper middle income") %>%  # filtro filas
  select(-wbcountryname, -wbcode, -year, -wbincomegroup, -wbregion) %>%  # excluyo columnas que no quiero resumir
  summarise(across(where(is.numeric), mean, na.rm = TRUE))  # promedio columnas numéricas restantes

#Nombres de variables y descripciones
vars_labels <- tibble(
  variable_name = names(data),
  variable_label = sapply(data, function(x) attr(x, "label"))
)


# Grafico 1
# Early Childhood (0-5)
# pais, region, ingresos
p_preprim <- crear_lhci_plot(data_alb$cer_pp_mf_repadj_fill_2025, data_reg$cer_pp_mf_repadj_fill_2025, data_inc$cer_pp_mf_repadj_fill_2025, "Pre-primary enrollment (%)", xmin = 25, xmax = 100)
p_surv5   <- crear_lhci_plot(data_alb$surv_0to5_mf_fill_2025, data_reg$surv_0to5_mf_fill_2025, data_inc$surv_0to5_mf_fill_2025, "Probability of survival to age 5", xmin = 0.88, xmax = 1)
p_nostunt <- crear_lhci_plot(1-data_alb$stunt_mf_fill_2025, 1-data_reg$stunt_mf_fill_2025, 1-data_inc$stunt_mf_fill_2025, "Fraction of children under 5 not stunted", xmin = 0.45, xmax = 1)


#t_work <- crear_titulo_etapa("Early Childhood (0-5)")

combined <- (
  # Early Childhood (0-5)
  #t_work/
  p_preprim / 
    p_surv5 / 
    p_nostunt) +
  plot_layout(ncol = 1, guides = "collect")

early_ch_p2 <- combined & 
  theme(
    plot.title = element_text(family = "Open Sans", face = "bold", size = 11, hjust = 0.06),
    legend.position      = "top",
    #legend.key.width = unit(0.1, "cm"),
    legend.direction     = "horizontal",
    legend.box           = "horizontal",
    legend.justification = "center",
  )
early_ch_p2
ggsave(filename = paste(out, "/early_ch_p2.png", sep =""),
       plot= early_ch_p2, width = 6, height = 3,dpi = 300,  bg = "white")


# Grafico 2
# School Age (6-17)
p_school  <- crear_lhci_plot(data_alb$eys_ps_mf_2025, data_reg$eys_ps_mf_2025, data_inc$eys_ps_mf_2025, "Learning-adjusted years of school", xmin = 0, xmax = 14, show_legend = FALSE)
p_childsr <- crear_lhci_plot(data_alb$surv_sa_mf_fill_2025, data_reg$surv_sa_mf_fill_2025, data_inc$surv_sa_mf_fill_2025, "Child survival rate (ages 5–14)", xmin = 88, xmax = 100, show_legend = FALSE)

#t_work <- crear_titulo_etapa("School Age (6-17)")

combined <- (
  # School Age (6–17)
  #t_work/
  p_school / 
    p_childsr) +
  plot_layout(ncol = 1, guides = "collect")

sch_age_p2 <- combined & 
  theme(
    plot.title = element_text(family = "Open Sans", face = "bold", size = 11, hjust = 0.06),
    legend.position      = "top",
    #legend.key.width = unit(0.1, "cm"),
    legend.direction     = "horizontal",
    legend.box           = "horizontal",
    legend.justification = "center",
  )
sch_age_p2
ggsave(filename = paste(out, "/sch_age_p2.png", sep =""),
       plot= sch_age_p2, width = 6, height = 2,dpi = 300,  bg = "white")

# Grafico 3
# Young Adult (18–24)
p_tertiary <- crear_lhci_plot(data_alb$WIDE_OECD_compl_ter_mf_fill_2025, data_reg$WIDE_OECD_compl_ter_mf_fill_2025, data_inc$WIDE_OECD_compl_ter_mf_fill_2025, "Tertiary school enrollment rate (%)", xmin = 0, xmax = 60, show_legend = FALSE)
p_ysurv   <- crear_lhci_plot(data_alb$surv_18to24_mf_fill_2025, data_reg$surv_18to24_mf_fill_2025, data_inc$surv_18to24_mf_fill_2025, "Youth survival rate (%)", xmin = 90, xmax = 100, show_legend = FALSE)
p_yhqjobs  <- crear_lhci_plot(data_alb$shr_wgemp_15to24_mf_fill_2025, data_reg$shr_wgemp_15to24_mf_fill_2025, data_inc$shr_wgemp_15to24_mf_fill_2025, "Share of youth in high-quality jobs (%)", xmin = 0, xmax = 80, show_legend = FALSE)
p_yemp     <- crear_lhci_plot(data_alb$unemp_20to24_mf_fill_2025, data_reg$unemp_20to24_mf_fill_2025, data_inc$unemp_20to24_mf_fill_2025, "Youth employment rate (%)", xmin = 0, xmax = 100, show_legend = FALSE)

#t_work <- crear_titulo_etapa("Young Adult (18–24)")

combined <- (
  # Young Adult (18–24)
  #t_work/  
  p_tertiary / 
    p_ysurv /
    p_yemp /
    p_yhqjobs ) + 
  
  plot_layout(ncol = 1, guides = "collect")

young_ad_p2 <- combined & 
  theme(
    plot.title = element_text(family = "Open Sans", face = "bold", size = 11, hjust = 0.06),
    legend.position      = "top",
    #legend.key.width = unit(0.1, "cm"),
    legend.direction     = "horizontal",
    legend.box           = "horizontal",
    legend.justification = "center",
  )
young_ad_p2
ggsave(filename = paste(out, "/young_ad_p2.png", sep =""),
       plot= young_ad_p2, width = 6, height = 4,dpi = 300,  bg = "white")

# Grafico 4
# Working Age (25–65)
p_lfp      <- crear_lhci_plot(data_alb$lfp_25to54_mf_fill_2025, data_reg$lfp_25to54_mf_fill_2025, data_inc$lfp_25to54_mf_fill_2025, "Labor force participation rate (%)", xmin = 40, xmax = 100, show_legend = FALSE)
p_ahqjobs  <- crear_lhci_plot(data_alb$shr_wgemp_25to54_mf_fill_2025, data_reg$shr_wgemp_25to54_mf_fill_2025, data_inc$shr_wgemp_25to54_mf_fill_2025, "Share of adults in high-quality jobs (%)", xmin = 0, xmax = 100, show_legend = FALSE)
p_aunemp   <- crear_lhci_plot(data_alb$unemp_25to54_mf_fill_2025, data_reg$unemp_25to54_mf_fill_2025, data_inc$unemp_25to54_mf_fill_2025, "Adult unemployment rate (%)", xmin = 0, xmax = 25, show_legend = FALSE)
p_asurv    <- crear_lhci_plot(data_alb$le_25to55_mf_fill_2025, data_reg$le_25to55_mf_fill_2025, data_inc$le_25to55_mf_fill_2025, "Adult survival", xmin = 55, xmax = 100, show_legend = FALSE)

#t_work <- crear_titulo_etapa("Working Age (25–65)")

combined <- (
  # Working Age (25–65)
  #t_work/  
  p_lfp / 
    p_ahqjobs / 
    p_aunemp / 
    p_asurv) +
  plot_layout(ncol = 1, guides = "collect")


work_age_p2 <- combined & 
  theme(
    plot.title = element_text(family = "Open Sans", face = "bold", size = 11, hjust = 0.06),
    legend.position      = "top",
    #legend.key.width = unit(0.1, "cm"),
    legend.direction     = "horizontal",
    legend.box           = "horizontal",
    legend.justification = "center",
  )
work_age_p2
ggsave(filename = paste(out, "/work_age_p2.png", sep =""),
       plot= work_age_p2, width = 6, height = 4,dpi = 300,  bg = "white")

########## Nuevo plot

gdp_data <- read_csv("C:\Users\pilih\Downloads\API_NY.GDP.PCAP.CD_DS2_en_csv_v2_38293\API_NY.GDP.PCAP.CD_DS2_en_csv_v2_38293.csv",
                     skip = 4)

# 2. Filtrar solo el año 2023
gdp_2023 <- gdp_data %>%
  select(`Country Name`, `Country Code`, `2023`) %>%
  rename(wbcode = `Country Code`,
         gdp = `2023`)

# 3. Leer la otra base de datos (ajusta la ruta)
# Supongamos que la otra base se llama hci_data y contiene las columnas: wbcode, HCI, region
# Ejemplo para cargarla desde CSV:
# hci_data <- read_csv("C:/Users/pilih/Downloads/hci_data.csv")

# 4. Hacer el merge por wbcode
merged_data <- gdp_2024 %>%
  inner_join(data, by = "wbcode")

region_colors <- c(
  "East Asia & Pacific"      = "#e7a6a1",  # rosa claro
  "Europe & Central Asia"    = "#4c4c4c",  # gris oscuro
  "Latin America & Caribbean"= "#b0dfe8",  # celeste claro
  "Middle East & North Africa" = "#f5e79e",# amarillo pastel
  "North America"            = "#fcd9b1",  # durazno claro
  "South Asia"               = "#5f77c4",  # azul medio
  "Sub-Saharan Africa"       = "#a9a9a9"   # gris medio
)

# 5. Graficar: eje X = GDP, eje Y = HCI, color = region, punto de Albania más grande
ggplot(merged_data, aes(x = log(gdp), y = HCI, color = wbregion)) +
  geom_point(aes(size = ifelse(wbcode == "ALB", 7, 4))) +
  geom_text(data = filter(merged_data, wbcode == "ALB"),
            aes(label = "Albania"), vjust = -1, size = 3.5, color = "black") +
  geom_smooth(method = "lm", se = FALSE, color = "gray40", linetype = "solid", linewidth = 1)+
  scale_size_identity() +
  scale_color_manual(values = region_colors) +
  scale_x_continuous(labels = scales::comma) +
  labs(
    title = "",
    x = "Log GDP per capita (US$)",
    y = "Human Capital Index",
    color = NULL
  ) +
  theme_minimal()+
  theme(
    plot.background = element_rect(fill = "white", color = NA),
    panel.background = element_rect(fill = "white", color = NA),
    panel.grid.major = element_blank(),
    #panel.grid.minor = element_blank(),
    panel.border = element_blank(),
    legend.position = c(0.95, 0.95),         # posición relativa (x, y)
    legend.justification = c("right", "top"),# ancla en la esquina superior derecha
    legend.background = element_blank(),     # ❌ Quita el recuadro
    legend.box.background = element_blank(), # ❌ Asegura que no haya borde exterior
    #axis.text.x = element_blank()            # ❌ Quita los números del eje X
  ) + guides(color = guide_legend(override.aes = list(size = 5)))
ggsave("C:/Users/pilih/Downloads/grafico_hci_vs_gdp.png", width = 12, height = 6, dpi = 300)

