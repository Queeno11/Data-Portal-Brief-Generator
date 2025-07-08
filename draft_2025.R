#######################    Brief model generator V 2025  ####################### 
#install.packages("tidyverse")
install.packages("ggrepel")
install.packages("sysfonts")
library(ggplot2)
library(tidyverse)
library(showtext)
library(sysfonts)
library(ggrepel)
library(patchwork)
library(cowplot)

setwd("/Users/florenciaruiz/Library/Mobile Documents/com~apple~CloudDocs/World Bank/Briefs/Data-Portal-Brief-Generator")

out <-"/Users/florenciaruiz/Library/Mobile Documents/com~apple~CloudDocs/World Bank/Briefs/Output"

#font_add_google("Roboto", "roboto")  # Descarga desde Google Fonts
#showtext_opts(dpi = 300) 

font_add_google(name = "Open Sans", family = "Open Sans")
showtext_auto()
showtext_opts(dpi = 300)

# ---------- LCHI por etapa de la vida  ---------- #
{
#### LHCI ####

# Datos solo para "Human Capital Index (HCI)"
hci_data <- data.frame(
  Category = "Human Capital Index (HCI)",
  Kenya = 0.22,
  Income_group = 0.48,
  Region = 0.35
)

# Reorganizamos los datos en formato largo para ggplot
hci_data <- pivot_longer(hci_data, cols = c(Kenya, Income_group, Region),
                          names_to = "Type", values_to = "Value")

# Definimos colores y tamaños
hci_data <- hci_data %>%
  mutate(
    Size = case_when(
      Type == "Kenya" ~ 6.5,
      Type == "Income_group" ~ 5,
      Type == "Region" ~ 3,
      Type == "Gold_Standard" ~ 4
    )
  )
hci_data$Type <- factor(hci_data$Type,
                       levels = c("Kenya", "Income_group", "Region", "Gold_Standard"))

# Gráfico
(lhci <- ggplot() +
    # Línea base del eje x para la distinción por genero
    geom_segment(aes(x = 0, xend = 1, y = 0, yend = 0), color = "gray95", linewidth = 4.5) +
    annotate("text", x = 0, y = 0, label = "0", fontface = "bold", color = "black", hjust = 1.1) +
    annotate("text", x = 1, y = 0, label = "1", fontface = "bold", color = "black", hjust = 0) +
    
    # Puntos
    geom_point(data = hci_data, shape =16,
               mapping = aes(x = Value, y = 0, color = Type, size = Size)) +
    # Etiquetas
    geom_text(data = hci_data,
              mapping = aes(x = Value, y = 0, label = Value),
              vjust = -2, fontface = "bold", size = 3) +
    # Colores y tamaños definidos manualmente
    scale_color_manual(
      name = NULL,
      values = c(
        "Kenya" = "#E95D4E",
        "Income_group" = "#0CB2AF",
        "Region" = "#264653"
      ),
      labels = c(
        "Kenya" = "Latest available \ndata for Kenya",
        "Income_group" = "Lower middle \nincome average",
        "Region" = "Sub-Saharan Africa \naverage"
      )) +
    scale_size_identity() +
    scale_x_continuous(limits = c(0, 1), breaks = c(0, 1)) +
    scale_y_continuous(limits = c(-0.1, 0.1))+
    labs(title = "Lifetime Human Capital Index (LHCI)") +
    theme_void(base_family = "sans") +
    theme(
      plot.title = element_text(hjust = 0.06, vjust = -1, face = "bold", size = 11,
                                margin = margin(t = 0, b = 0, l = 0, r = 0, "pt")),
      axis.text.x = element_blank(),
      axis.ticks.x = element_line(),
      axis.line.x = element_blank(),
      legend.position = c(0.52, 0.2),
      legend.justification = "center",
      legend.direction = "horizontal",
      legend.text = element_text(color="black", size =11),
      # Ancho fijo para cada “key” de la leyenda
      legend.key.width   = unit(1, "cm"),
      # Centramos el texto dentro de cada key
      #legend.text.align  = 0.5
      plot.margin   = margin(0, 0, 0, 0, "pt"),
      panel.spacing = unit(0, "pt")
    )+
    guides(
      color = guide_legend(nrow = 1, byrow = TRUE, override.aes = list(size = 4)))
    )
  
#### LHCI Early childhood ####

# Datos solo para early childhood
ec_data <- data.frame(
  Category = "Early Childhood HCI (0-5)",
  Kenya = 0.38,
  Income_group = 0.51,
  Region = 0.45
  #Gold_Standard = 0.72
)

# Reorganizamos los datos en formato largo para ggplot
ec_data <- pivot_longer(ec_data, cols = c(Kenya, Income_group, Region),
                          names_to = "Type", values_to = "Value")

# Definimos colores y tamaños
ec_data <- ec_data %>%
  mutate(
    Size = case_when(
      Type == "Kenya" ~ 6.5,
      Type == "Income_group" ~ 5,
      Type == "Region" ~ 3,
      Type == "Gold_Standard" ~ 4
    )
  )

ec_data$Type <- factor(ec_data$Type,
                       levels = c("Kenya", "Income_group", "Region", "Gold_Standard"))

# Gráfico
(ec <- ggplot() +
    # Línea base del eje x para la distinción por genero
    geom_segment(aes(x = 0, xend = 1, y = 0, yend = 0), color = "gray95", linewidth = 4.5) +
    annotate("text", x = 0, y = 0, label = "0", fontface = "bold", color = "black", hjust = 1.1) +
    annotate("text", x = 1, y = 0, label = "1", fontface = "bold", color = "black", hjust = 0) +
    
    # Puntos
    geom_point(data = ec_data, shape =16,
               mapping = aes(x = Value, y = 0, color = Type, size = Size)) +
    # Etiquetas
    geom_text(data = ec_data,
              mapping = aes(x = Value, y = 0, label = Value),
              vjust = -2, fontface = "bold", size = 3) +
    # Colores y tamaños definidos manualmente
    scale_color_manual(
      name = NULL,
      values = c(
        "Kenya" = "#E95D4E",
        "Income_group" = "#0CB2AF",
        "Region" = "#264653"
      ),
      labels = c(
        "Kenya" = "Latest available \ndata for Kenya",
        "Income_group" = "Lower middle \nincome average",
        "Region" = "Sub-Saharan Africa \naverage"
      )) +
    scale_size_identity() +
    scale_x_continuous(limits = c(0, 1), breaks = c(0, 1)) +
    scale_y_continuous(limits = c(-0.1, 0.1))+
    labs(title = "Early Childhood HCI (0-5)") +
    theme_void(base_family = "sans") +
    theme(
      plot.title = element_text(hjust = 0.06, vjust = -1, face = "bold", size = 11,
                                margin = margin(t = 0, b = 0, l = 0, r = 0, "pt")),
      axis.text.x = element_blank(),
      axis.ticks.x = element_line(),
      axis.line.x = element_blank(),
      legend.position = c(0.52, 0.2),
      legend.justification = "center",
      legend.direction = "horizontal",
      legend.text = element_text(color="black", size =11),
      # Ancho fijo para cada “key” de la leyenda
      legend.key.width   = unit(1, "cm"),
      # Centramos el texto dentro de cada key
      #legend.text.align  = 0.5
      plot.margin   = margin(0, 0, 0, 0, "pt"),
      panel.spacing = unit(0, "pt")
    )+
    guides(
      color = guide_legend(nrow = 1, byrow = TRUE, override.aes = list(size = 4)))
)

#### LHCI School Age ####

# Datos solo para school age
sa_data <- data.frame(
  Category = "School Age HCI (6-17)",
  Kenya = 0.55,
  Income_group = 0.68,
  Region = 0.60
  #Gold_Standard = 0.88
)

# Reorganizamos los datos en formato largo para ggplot
sa_data <- pivot_longer(sa_data, cols = c(Kenya, Income_group, Region),
                          names_to = "Type", values_to = "Value")

# Definimos colores y tamaños
sa_data <- sa_data %>%
  mutate(
    Size = case_when(
      Type == "Kenya" ~ 6.5,
      Type == "Income_group" ~ 5,
      Type == "Region" ~ 3,
      Type == "Gold_Standard" ~ 4
    )
  )

sa_data$Type <- factor(sa_data$Type,
                       levels = c("Kenya", "Income_group", "Region", "Gold_Standard"))

# Gráfico
(sa <- ggplot() +
    # Línea base del eje x para la distinción por genero
    geom_segment(aes(x = 0, xend = 1, y = 0, yend = 0), color = "gray95", linewidth = 4.5) +
    annotate("text", x = 0, y = 0, label = "0", fontface = "bold", color = "black", hjust = 1.1) +
    annotate("text", x = 1, y = 0, label = "1", fontface = "bold", color = "black", hjust = 0) +
    
    # Puntos
    geom_point(data = sa_data, shape =16,
               mapping = aes(x = Value, y = 0, color = Type, size = Size)) +
    # Etiquetas
    geom_text(data = sa_data,
              mapping = aes(x = Value, y = 0, label = Value),
              vjust = -2, fontface = "bold", size = 3) +
    # Colores y tamaños definidos manualmente
    scale_color_manual(
      name = NULL,
      values = c(
        "Kenya" = "#E95D4E",
        "Income_group" = "#0CB2AF",
        "Region" = "#264653"
      ),
      labels = c(
        "Kenya" = "Latest available \ndata for Kenya",
        "Income_group" = "Lower middle \nincome average",
        "Region" = "Sub-Saharan Africa \naverage"
      )) +
    scale_size_identity() +
    scale_x_continuous(limits = c(0, 1), breaks = c(0, 1)) +
    scale_y_continuous(limits = c(-0.1, 0.1))+
    labs(title = "School Age HCI (6-17)") +
    theme_void(base_family = "sans") +
    theme(
      plot.title = element_text(hjust = 0.06, vjust = -1, face = "bold", size = 11,
                                margin = margin(t = 0, b = 0, l = 0, r = 0, "pt")),
      axis.text.x = element_blank(),
      axis.ticks.x = element_line(),
      axis.line.x = element_blank(),
      legend.position = c(0.52, 0.2),
      legend.justification = "center",
      legend.direction = "horizontal",
      legend.text = element_text(color="black", size =11),
      # Ancho fijo para cada “key” de la leyenda
      legend.key.width   = unit(1, "cm"),
      # Centramos el texto dentro de cada key
      #legend.text.align  = 0.5
      plot.margin   = margin(0, 0, 0, 0, "pt"),
      panel.spacing = unit(0, "pt")
    )+
    guides(
      color = guide_legend(nrow = 1, byrow = TRUE, override.aes = list(size = 4)))
)

#### LHCI Youth Adult ####

# Datos 
ya_data <- data.frame(
  Category = "Youth Adult HCI (18-24)",
  Kenya = 0.15,
  Income_group = 0.28,
  Region = 0.66
  #Gold_Standard = 0.80
)

# Reorganizamos los datos en formato largo para ggplot
ya_data <- pivot_longer(ya_data, cols = c(Kenya, Income_group, Region),
                          names_to = "Type", values_to = "Value")

# Definimos colores y tamaños
ya_data <- ya_data %>%
  mutate(
    Size = case_when(
      Type == "Kenya" ~ 6.5,
      Type == "Income_group" ~ 5,
      Type == "Region" ~ 3,
      Type == "Gold_Standard" ~ 4
    )
  )

ya_data$Type <- factor(ya_data$Type,
                       levels = c("Kenya", "Income_group", "Region", "Gold_Standard"))

# Gráfico
(ya <- ggplot() +
    # Línea base del eje x para la distinción por genero
    geom_segment(aes(x = 0, xend = 1, y = 0, yend = 0), color = "gray95", linewidth = 4.5) +
    annotate("text", x = 0, y = 0, label = "0", fontface = "bold", color = "black", hjust = 1.1) +
    annotate("text", x = 1, y = 0, label = "1", fontface = "bold", color = "black", hjust = 0) +
    
    # Puntos
    geom_point(data = ya_data, shape =16,
               mapping = aes(x = Value, y = 0, color = Type, size = Size)) +
    # Etiquetas
    geom_text(data = ya_data,
              mapping = aes(x = Value, y = 0, label = Value),
              vjust = -2, fontface = "bold", size = 3) +
    # Colores y tamaños definidos manualmente
    scale_color_manual(
      name = NULL,
      values = c(
        "Kenya" = "#E95D4E",
        "Income_group" = "#0CB2AF",
        "Region" = "#264653"
      ),
      labels = c(
        "Kenya" = "Latest available \ndata for Kenya",
        "Income_group" = "Lower middle \nincome average",
        "Region" = "Sub-Saharan Africa \naverage"
      )) +
    scale_size_identity() +
    scale_x_continuous(limits = c(0, 1), breaks = c(0, 1)) +
    scale_y_continuous(limits = c(-0.1, 0.1))+
    labs(title = "Youth Adult HCI (18-24)") +
    theme_void(base_family = "sans") +
    theme(
      plot.title = element_text(hjust = 0.06, vjust = -1, face = "bold", size = 11,
                                margin = margin(t = 0, b = 0, l = 0, r = 0, "pt")),
      axis.text.x = element_blank(),
      axis.ticks.x = element_line(),
      axis.line.x = element_blank(),
      legend.position = c(0.52, 0.2),
      legend.justification = "center",
      legend.direction = "horizontal",
      legend.text = element_text(color="black", size =11),
      # Ancho fijo para cada “key” de la leyenda
      legend.key.width   = unit(1, "cm"),
      # Centramos el texto dentro de cada key
      #legend.text.align  = 0.5
      plot.margin   = margin(0, 0, 0, 0, "pt"),
      panel.spacing = unit(0, "pt")
    )+
    guides(
      color = guide_legend(nrow = 1, byrow = TRUE, override.aes = list(size = 4)))
)


#### LHCI Working Age ####

# Datos 
wa_data <- data.frame(
  Category = "Working Age HCI (25-65)",
  Kenya = 0.10,
  Income_group = 0.55,
  Region = 0.30
  #Gold_Standard = 0.41
)

# Reorganizamos los datos en formato largo para ggplot
wa_data <- pivot_longer(wa_data, cols = c(Kenya, Income_group, Region),
                          names_to = "Type", values_to = "Value")

# Definimos colores y tamaños
wa_data <- wa_data %>%
  mutate(
    Size = case_when(
      Type == "Kenya" ~ 6.5,
      Type == "Income_group" ~ 5,
      Type == "Region" ~ 3,
      Type == "Gold_Standard" ~ 4
    )
  )

wa_data$Type <- factor(wa_data$Type,
                         levels = c("Kenya", "Income_group", "Region", "Gold_Standard"))
# Gráfico
(wa <- ggplot() +
    # Línea base del eje x para la distinción por genero
    geom_segment(aes(x = 0, xend = 1, y = 0, yend = 0), color = "gray95", linewidth = 4.5) +
    annotate("text", x = 0, y = 0, label = "0", fontface = "bold", color = "black", hjust = 1.1) +
    annotate("text", x = 1, y = 0, label = "1", fontface = "bold", color = "black", hjust = 0) +
    
    # Puntos
    geom_point(data = wa_data, shape =16,
               mapping = aes(x = Value, y = 0, color = Type, size = Size)) +
    # Etiquetas
    geom_text(data = wa_data,
              mapping = aes(x = Value, y = 0, label = Value),
              vjust = -2, fontface = "bold", size = 3) +
    # Colores y tamaños definidos manualmente
    scale_color_manual(
      name = NULL,
      values = c(
        "Kenya" = "#E95D4E",
        "Income_group" = "#0CB2AF",
        "Region" = "#264653"
      ),
      labels = c(
        "Kenya" = "Latest available \ndata for Kenya",
        "Income_group" = "Lower middle \nincome average",
        "Region" = "Sub-Saharan Africa \naverage"
      )) +
    scale_size_identity() +
    scale_x_continuous(limits = c(0, 1), breaks = c(0, 1)) +
    scale_y_continuous(limits = c(-0.1, 0.1))+
    labs(title = "Working Age HCI (25-65)") +
    theme_void(base_family = "sans") +
    theme(
      plot.title = element_text(hjust = 0.06, vjust = -1, face = "bold", size = 11,
                                margin = margin(t = 0, b = 0, l = 0, r = 0, "pt")),
      axis.text.x = element_blank(),
      axis.ticks.x = element_line(),
      axis.line.x = element_blank(),
      legend.position = c(0.52, 0.2),
      legend.justification = "center",
      legend.direction = "horizontal",
      legend.text = element_text(color="black", size =11),
      # Ancho fijo para cada “key” de la leyenda
      legend.key.width   = unit(1, "cm"),
      # Centramos el texto dentro de cada key
      #legend.text.align  = 0.5
      plot.margin   = margin(0, 0, 0, 0, "pt"),
      panel.spacing = unit(0, "pt")
    )+
    guides(
      color = guide_legend(nrow = 1, byrow = TRUE, override.aes = list(size = 4)))
)

#### Junto los graficos ####
# Quitar leyenda de los tres primeros
lhci_nolegend <- lhci + theme(legend.position = "none")
ec_nolegend <- ec + theme(legend.position = "none")
sa_nolegend <- sa + theme(legend.position = "none")
ya_nolegend <- ya + theme(legend.position = "none")
wa_nolegend <- wa + theme(legend.position = "none")
# wa mantiene su leyenda

# Apilar y recolectar leyenda
combined1 <- (lhci_nolegend / 
               ec_nolegend  /
               sa_nolegend  /
               ya_nolegend  /
               wa) +
  plot_layout(
    ncol   = 1,
    guides = "collect"     # recoge sólo la leyenda que queda (la de wa_gender)
  ) +
  plot_annotation(
    title = "Human Capital Index Snapshot",
    theme = theme(
      plot.title = element_text(
        family = "sans", face = "bold",
        size   = 14,    hjust = 0.5
      )
    )
  )
combined1
# 3) Tema global: leyenda abajo, centrada, en fila
final1 <- combined1 & 
  theme(
    legend.position      = "bottom",
    legend.direction     = "horizontal",
    legend.box           = "horizontal",
    legend.justification = "center"
  )

print(final1)

ggsave(filename = "Output/lchi_stage.png",plot= final1, width = 6, height = 5.5,dpi = 300,  bg = "white")
#### Automatización ####

# Función para generar gráfico LHCI por grupo etario
crear_lhci_plot <- function(country_value, income_value, region_value,
                            title_text,
                            country_name = "Kenya",
                            income_label = "Lower middle \nincome average",
                            region_label = "Sub-Saharan \nAfrica average",
                            show_legend = FALSE) {
  
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
    geom_segment(aes(x = 0, xend = 1, y = 0, yend = 0), color = "gray97", linewidth = 9) +
    # Ticks verticales en los extremos (-0.03 y 0.03)
    geom_segment(aes(x = 0, xend = 0, y = -0.03, yend = 0.03), color = "black", linewidth = 0.7) +
    geom_segment(aes(x = 1, xend = 1, y = -0.03, yend = 0.03), color = "black", linewidth = 0.7)+
    # Valores de los extremos
    annotate("text", x = 0, y = -0.005, label = "0", size = 4, color = "black", hjust = 0.5, vjust = 2.5, family = "Open Sans") +
    annotate("text", x = 1, y = -0.005, label = "1", size = 4, color = "black", hjust = 0.7, vjust = 2.5, family = "Open Sans") +
    # Puntos
    geom_point(data = data, shape = 16,
               aes(x = Value, y = 0, color = Type, size = Size, alpha = Alpha))+
    # Texto de los puntos
    geom_text(data = data %>% filter(Type == "Country"),
            aes(x = Value, y = 0, label = Value),
            vjust = -1.5, fontface = "bold", size = 4, family = "Open Sans") +
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
                                override.aes = list(size = 4, 
                                                    alpha = c(1, 0.6, 0.6))
                                )
           )
  
  return(plot)
}

(p_lhci <- crear_lhci_plot(0.25, 0.48, 0.35, "Lifetime Human Capital Index (LHCI)", show_legend = TRUE))
p_ec   <- crear_lhci_plot(0.40, 0.51, 0.45, "Early Childhood HCI (0-5)")
p_sa   <- crear_lhci_plot(0.58, 0.68, 0.60, "School Age HCI (6-17)")
p_ya   <- crear_lhci_plot(0.20, 0.28, 0.66, "Youth Adult HCI (18-24)")
p_wa   <- crear_lhci_plot(0.12, 0.55, 0.30, "Working Age HCI (25-65)")

# Armar layout
combined <- (p_lhci / p_ec / p_sa / p_ya / p_wa) +
  plot_layout(ncol = 1, guides = "collect")

final_kenya <- combined & 
  theme(
    plot.title = element_text(family = "Open Sans", face = "bold", size = 11, hjust = 0.06),
    legend.position      = "top",
    #legend.key.width = unit(0.1, "cm"),
    legend.direction     = "horizontal",
    legend.box           = "horizontal",
    legend.justification = "center",
  )

final_kenya
ggsave(filename = paste(out, "/lchi_stage.png", sep =""),
       plot= final_kenya, width = 5.5, height = 5.5,dpi = 300,  bg = "white")

# Solo el LHCI (cambiar ticks vericales a  y = -0.018, yend = 0.018)
p_lhci2 <- crear_lhci_plot(0.25, 0.48, 0.35, "Lifetime Human Capital Index (LHCI)", show_legend = TRUE)
p_lhci2
p_lhci2 <- p_lhci2 & 
  theme(
    legend.position      = "top",
    #legend.key.width = unit(0.1, "cm"),
    legend.direction     = "horizontal",
    legend.box           = "horizontal",
    legend.justification = "center",
    plot.margin = margin(2, 0, 0, 0, "pt"),
  )
p_lhci2
ggsave(filename = paste(out, "/solo_lchi.png", sep =""),
       plot= p_lhci2, width = 6, height = 1.5,dpi = 300,  bg = "white")

# Versión sin el LCHI junto (cambiar ticks vericales a  y = -0.018, yend = 0.018)
combined2 <- (p_ec / p_sa / p_ya / p_wa) +
  plot_layout(ncol = 1, guides = "collect")

final_kenya2 <- combined2 & 
  theme(
    plot.title = element_text(family = "Open Sans", face = "bold", size = 11, hjust = 0.06),
    legend.position      = "top",
    #legend.key.width = unit(0.1, "cm"),
    legend.direction     = "horizontal",
    legend.box           = "horizontal",
    legend.justification = "center",
  )
final_kenya2
ggsave(filename = paste(out, "/stage.png", sep =""),
       plot= final_kenya2, width = 6, height = 5.5,dpi = 300,  bg = "white")


}
# ---------- Opción 1: plot de una sola descomposición ---------- #
{
# Valores base
x_start <- 0.15
x_end <- 0.80
total_diff <- x_end - x_start

# Componentes: porcentaje del total y colores
components <- data.frame(
  component = c("Education", "Labor", "Health"),
  share = c(0.45, 0.25, 0.30),
  color = c("#f7e1d7", "#a8dadc", "#b0c4b1")  # rojo, celeste, fucsia
)

# Posiciones acumuladas para cada segmento
components$xmin <- x_start + c(0, head(cumsum(components$share * total_diff), -1))
components$xmax <- x_start + cumsum(components$share * total_diff)
components$label_x <- (components$xmin + components$xmax) / 2

# Gráfico
decomp<- ggplot() +
  # Segmentos por componente
  geom_segment(data = components,
               aes(x = xmin, xend = xmax, y = 0, yend = 0, color = component),
               size = 6) +
  # Etiquetas de componentes
  geom_text(data = components,
            aes(x = label_x, y = -0.08, label = paste0(component, " (", share * 100, "%)")),
            color = components$color,
            size = 5,
            fontface = "bold") +
  # Puntos inicial y final
  geom_point(aes(x = x_start, y = 0), size = 9, color = "#E95D4E") +
  geom_point(aes(x = x_end, y = 0), size = 9, color = "#FAC723") +
  # Texto con valores extremos
  annotate("text", x = x_start, y = 0.06, label = "0.15", size = 5, fontface = "bold") +
  annotate("text", x = x_end, y = 0.06, label = "0.80", size = 5, fontface = "bold") +
  annotate("text", x = 0.15, y = 0.11, label = "Kenya score", size = 5, fontface = "bold") +
  annotate("text", x = 0.80, y = 0.11, label = "Gold standard", size = 5, fontface = "bold")+
  # Título
  annotate("text",
           x = (x_start + x_end)/2,
           y = 0.2,
           label = "Young Adult HCI (18–24)",
           fontface = "bold",
           family = "sans",
           size = 6)+
  scale_color_manual(values = setNames(components$color, components$component)) +
  coord_cartesian(ylim = c(-0.2, 0.3), xlim = c(0.07, 0.9)) +
  theme_void() +
  theme(legend.position = "none")

ggsave(filename = "Output/decomp.png",width = 6.5, height = 3,dpi = 300,   bg = "white")
}
# ---------- Opción 2: plot del LCHI acumulado por sexo ---------- #
{
# Genero la data
df <- data.frame(
  AgeGroup = factor(c("0-5", "6-17", "18-24", "25-65"), levels = c("0-5", "6-17", "18-24", "25-65")),
  Female = c(0.91, 0.52, 0.39, 0.22),
  Male = c(0.90, 0.49, 0.40, 0.31)
)

# Para definir si va arriba o abajo, necesitamos comparar por grupo de edad
# Agregamos vjust por grupo y género: Female arriba si su valor > Male, y viceversa
df_long <- df %>%
  mutate(
    vjust_Female = ifelse(Female >= Male, -1.2, 2),
    vjust_Male = ifelse(Male > Female, -1.2, 2)
  ) %>%
  pivot_longer(cols = c(Female, Male), names_to = "Gender", values_to = "Value") %>%
  mutate(vjust = ifelse(Gender == "Female", vjust_Female, vjust_Male)) %>%
  select(AgeGroup, Gender, Value, vjust)

# Plot
ggplot(df_long, aes(x = AgeGroup, y = Value, group = Gender, color = Gender)) +
  geom_line(linewidth = 1) +
  geom_point(size = 3) +
  geom_text(aes(label = Value, vjust = vjust), size = 5) +  # ajusta vjust según género
  scale_color_manual(values = c("Female" = "#E95D4E", "Male" = "#0CB2AF")) +
  labs(
    title = "LHCI Cumulative score",
    y = NULL,
    x = "Age group",
    color = "Gender"
  ) +
  ylim(0.15, 1.05) +  # más espacio en el eje Y
  theme_minimal() +
  theme(
    text = element_text(family = "sans"),
    legend.position = "bottom",
    legend.box = "vertical",                    # Título arriba de la leyenda
    legend.title = element_text(size =14, face = "bold"), # Estilo del título 
    legend.text =  element_text(size =14),
    plot.title = element_text(size =16, hjust = 0.5, face = "bold"),
    axis.text = element_text(color="black", size =14),
    panel.grid.major.x = element_blank(),  
    panel.grid.minor.x = element_blank(),
    panel.grid.minor.y = element_blank(), 
    panel.grid.major.y = element_line(color = "gray90", linetype = "dashed")
  )

ggsave(filename = "Output/lchi_cum_sex.png",width = 8, height = 6,dpi = 300,   bg = "white")
}
# ---------- Opción 3: plot del LCHI acumulado por grupo ---------- #
{
# Genero la data
df <- data.frame(
  AgeGroup = factor(c("0-5", "6-17", "18-24", "25-65"), levels = c("0-5", "6-17", "18-24", "25-65")),
  Kenya = c(0.74, 0.62, 0.45, 0.22),
  `Income group` = c(0.7, 0.58, 0.43, 0.35),
  Region = c(0.88, 0.72, 0.54, 0.48)
)
# A formato largo
df_long <- df %>%
  pivot_longer(cols = -AgeGroup, names_to = "Group", values_to = "Value")

df_long$Group <- recode(df_long$Group,
                        "Income.group" = "Income group",
                        "Kenya" = "Kenya",
                        "Region" = "Region")

df_long <- df_long %>%
  mutate(nudge_y = case_when(
    Group == "Income group" ~ -0.04,  # abajo
    TRUE ~ 0.04))                      # arriba

# Gráfico con etiquetas automáticas que no se superponen
ggplot(df_long, aes(x = AgeGroup, y = Value, color = Group, group = Group)) +
  geom_line(linewidth = 1) +
  geom_point(size = 3) +
  geom_text(
    aes(label = Value, y = Value + nudge_y),
    size = 5,
    show.legend = FALSE
  ) +
  theme_minimal() +
  labs(title = "LHCI Cumulative score", y = NULL, x = "Age group", color = NULL)+
  scale_color_manual(values = c("Kenya" = "#E95D4E", "Region" = "#264653", "Income group"= "#0CB2AF")) +
  theme(
    text = element_text(family = "sans"),
    legend.position = "bottom",
    legend.box = "vertical",                    # Título arriba de la leyenda
    legend.title = element_text(size =14, face = "bold"), # Estilo del título 
    legend.text =  element_text(size =14),
    plot.title = element_text(size =16, hjust = 0.5, face = "bold"),
    axis.text = element_text(color="black", size =14),
    panel.grid.major.x = element_blank(),  
    panel.grid.minor.x = element_blank(),
    panel.grid.minor.y = element_blank(), 
    panel.grid.major.y = element_line(color = "gray90", linetype = "dashed")
  )

ggsave(filename = "Output/lchi_cum_groups.png",width = 8, height = 6,dpi = 300,   bg = "white")
}
# ---------- Opción 4: plot del LCHI por género + grupo ---------- #
{
  
#### LHCI ####

# Datos solo para "Human Capital Index (HCI)"
hci_data_gender <- data.frame(
  Category = "Human Capital Index (HCI)",
  Female = 0.10,
  Male = 0.25
)

# Reorganizamos los datos en formato largo para ggplot
  hci_data_gender <- pivot_longer(hci_data_gender, cols = c(Female, Male),
                          names_to = "Type", values_to = "Value")

# Definimos colores y tamaños
hci_data_gender <- hci_data_gender %>%
  mutate(
    Size = case_when(
      Type == "Female" ~ 6,
      Type == "Male" ~ 6
    ))

hci_data_gender$Type <- factor(hci_data_gender$Type,
                              levels = c("Female", "Male"))

# Gráfico
(lhci_gender <- ggplot() +
    # Línea base del eje x para el HCI
    geom_segment(aes(x = 0, xend = 1, y = 0.1, yend = 0.1), color = "gray95", linewidth = 4.5) +
    annotate("text", x = 0, y = 0.1, label = "0", fontface = "bold", color = "black", hjust = 1.1) +
    annotate("text", x = 1, y = 0.1, label = "1", fontface = "bold", color = "black", hjust = 0) +
    
    # Línea base del eje x para la distinción por genero
    geom_segment(aes(x = 0, xend = 1, y = 0, yend = 0), color = "gray95", linewidth = 4.5) +
    annotate("text", x = 0, y = 0, label = "0", fontface = "bold", color = "black", hjust = 1.1) +
    annotate("text", x = 1, y = 0, label = "1", fontface = "bold", color = "black", hjust = 0) +
    
    # Puntos para HCI
    geom_point(data = hci_data, 
               mapping = aes(x = Value, y = 0.1, color = Type, shape = Type, size = Size)) +
    # Etiquetas solo para Kenya
    geom_text(data = filter(hci_data, Type == "Kenya"),
              mapping = aes(x = Value, y = 0.1, label = Value),
              vjust = -2, fontface = "bold", size = 3) +
    
    # Puntos para gender
    geom_point(data = hci_data_gender, 
               mapping = aes(x = Value, y = 0, color = Type, shape = Type, size = Size)) +
    # Etiquetas solo para Kenya
    geom_text(data = hci_data_gender,
              mapping = aes(x = Value, y = 0, label = Value),
              vjust = -2, fontface = "bold", size = 3) +
    
    # Colores y tamaños definidos manualmente
    scale_color_manual(
      name = NULL,
      values = c(
        "Kenya" = "#E95D4E",
        "Income_group" = "#0CB2AF",
        "Region" = "#264653",
        "Female" = "#e9c46a",
        "Male" = "#f4a261"
      ),
      labels = c(
        "Kenya" = "Latest available \ndata for Kenya",
        "Income_group" = "Lower middle \nincome average",
        "Region" = "Sub-Saharan Africa \naverage",
        "Female" = "Women average \nin Kenya",
        "Male" = "Men average \nin Kenya"
      )
    ) +
    scale_shape_manual(
      name = NULL,
      values = c("Kenya" = 16, "Income_group" = 16, "Region" = 16,"Female" = 15, "Male" = 17),
      labels = c(
        "Kenya" = "Latest available \ndata for Kenya",
        "Income_group" = "Lower middle \nincome average",
        "Region" = "Sub-Saharan Africa \naverage",
        "Female" = "Women average \nin Kenya",
        "Male" = "Men average \nin Kenya"
      )
    ) +
    scale_size_identity() +
    scale_x_continuous(limits = c(0, 1), breaks = c(0, 1)) +
    scale_y_continuous(limits = c(-0.1, 0.2))+
    labs(title = "Lifetime Human Capital Indez (LHCI)") +
    theme_void(base_family = "sans") +
    theme(
      plot.title = element_text(hjust = 0.06, vjust = -2, face = "bold", size = 11,
                                margin = margin(t = 0, b = 0, l = 0, r = 0, "pt")),
      axis.text.x = element_blank(),
      axis.ticks.x = element_line(),
      axis.line.x = element_blank(),
      legend.position = c(0.52, 0.2),
      legend.justification = "center",
      legend.direction = "horizontal",
      legend.text = element_text(color="black", size =11),
      legend.key.width   = unit(1, "cm"),   # Ancho fijo para cada “key” de la leyenda
      #legend.text.align  = 0.5     # Centramos el texto dentro de cada key
      plot.margin   = margin(0, 0, 0, 0, "pt"),  # Sin margen alrededor
      panel.spacing = unit(0, "pt"),   # Sin espacio interno entre panels
    )+
    guides(
      color = guide_legend(nrow = 2, byrow = TRUE, override.aes = list(size = 4)),
      shape = guide_legend(nrow = 2, byrow = TRUE, override.aes = list(size = 4))
    )
)

#### Early childhood ####
  
# Datos solo para early childhood
  ec_gender_data <- data.frame(
    Category = "Early Childhood HCI (0-5)",
    Female = 0.10,
    Male = 0.25
  )
  
# Reorganizamos los datos en formato largo para ggplot
  ec_gender_data <- pivot_longer(ec_gender_data, cols = c(Female, Male),
                            names_to = "Type", values_to = "Value")

  
# Definimos colores y tamaños
  ec_gender_data <- ec_gender_data %>%
    mutate(
      Size = case_when(
        Type == "Female" ~ 6,
        Type == "Male" ~ 6
      ))
  
  ec_gender_data$Type <- factor(ec_gender_data$Type,
                                levels = c("Female", "Male"))
  
# Gráfico
  (ec_gender <- ggplot() +
      # Línea base del eje x para el HCI
      geom_segment(aes(x = 0, xend = 1, y = 0.1, yend = 0.1), color = "gray95", linewidth = 4.5) +
      annotate("text", x = 0, y = 0.1, label = "0", fontface = "bold", color = "black", hjust = 1.1) +
      annotate("text", x = 1, y = 0.1, label = "1", fontface = "bold", color = "black", hjust = 0) +
      
      # Línea base del eje x para la distinción por genero
      geom_segment(aes(x = 0, xend = 1, y = 0, yend = 0), color = "gray95", linewidth = 4.5) +
      annotate("text", x = 0, y = 0, label = "0", fontface = "bold", color = "black", hjust = 1.1) +
      annotate("text", x = 1, y = 0, label = "1", fontface = "bold", color = "black", hjust = 0) +
      
      # Puntos para HCI
      geom_point(data = ec_data, 
                 mapping = aes(x = Value, y = 0.1, color = Type, shape = Type, size = Size)) +
      # Etiquetas solo para Kenya
      geom_text(data = filter(ec_data, Type == "Kenya"),
                mapping = aes(x = Value, y = 0.1, label = Value),
                vjust = -2, fontface = "bold", size = 3) +
      
      # Puntos para gender
      geom_point(data = ec_gender_data, 
                 mapping = aes(x = Value, y = 0, color = Type, shape = Type, size = Size)) +
      # Etiquetas solo para Kenya
      geom_text(data = ec_gender_data,
                mapping = aes(x = Value, y = 0, label = Value),
                vjust = -2, fontface = "bold", size = 3) +
      
      # Colores y tamaños definidos manualmente
      scale_color_manual(
        name = NULL,
        values = c(
          "Kenya" = "#E95D4E",
          "Income_group" = "#0CB2AF",
          "Region" = "#264653",
          "Female" = "#e9c46a",
          "Male" = "#f4a261"
        ),
        labels = c(
          "Kenya" = "Latest available \ndata for Kenya",
          "Income_group" = "Lower middle \nincome average",
          "Region" = "Sub-Saharan Africa \naverage",
          "Female" = "Women average \nin Kenya",
          "Male" = "Men average \nin Kenya"
        )
      ) +
      scale_shape_manual(
        name = NULL,
        values = c("Kenya" = 16, "Income_group" = 16, "Region" = 16,"Female" = 15, "Male" = 17),
        labels = c(
          "Kenya" = "Latest available \ndata for Kenya",
          "Income_group" = "Lower middle \nincome average",
          "Region" = "Sub-Saharan Africa \naverage",
          "Female" = "Women average \nin Kenya",
          "Male" = "Men average \nin Kenya"
        )
      ) +
      scale_size_identity() +
      scale_x_continuous(limits = c(0, 1), breaks = c(0, 1)) +
      scale_y_continuous(limits = c(-0.1, 0.2))+
      labs(title = "Early Childhood HCI (0–5)") +
      theme_void(base_family = "sans") +
      theme(
        plot.title = element_text(hjust = 0.06, vjust = -1, face = "bold", size = 11,
                                  margin = margin(t = 0, b = 0, l = 0, r = 0, "pt")),
        axis.text.x = element_blank(),
        axis.ticks.x = element_line(),
        axis.line.x = element_blank(),
        legend.position = c(0.52, 0.2),
        legend.justification = "center",
        legend.direction = "horizontal",
        legend.text = element_text(color="black", size =11),
        legend.key.width   = unit(1, "cm"),   # Ancho fijo para cada “key” de la leyenda
        #legend.text.align  = 0.5     # Centramos el texto dentro de cada key
        plot.margin   = margin(0, 0, 0, 0, "pt"),  # Sin margen alrededor
        panel.spacing = unit(0, "pt"),   # Sin espacio interno entre panels
      )+
      guides(
        color = guide_legend(nrow = 2, byrow = TRUE, override.aes = list(size = 4)),
        shape = guide_legend(nrow = 2, byrow = TRUE, override.aes = list(size = 4))
      )
  )
  
#### School age ####

# Datos solo para school age
sa_gender_data <- data.frame(
    Category = "School Age HCI (6-17)",
    Female = 0.60,
    Male = 0.50
)
  
# Reorganizamos los datos en formato largo para ggplot
sa_gender_data <- pivot_longer(sa_gender_data, cols = c(Female, Male),
                               names_to = "Type", values_to = "Value")
  
# Definimos colores y tamaños
sa_gender_data <- sa_gender_data %>%
  mutate(
    Size = case_when(
      Type == "Female" ~ 6,
      Type == "Male" ~ 6
    ))

sa_gender_data$Type <- factor(sa_gender_data$Type,
                              levels = c("Female", "Male"))

  
# Gráfico
(sa_gender <- ggplot() +
    # Línea base del eje x para el HCI
    geom_segment(aes(x = 0, xend = 1, y = 0.1, yend = 0.1), color = "gray95", linewidth = 4.5) +
    annotate("text", x = 0, y = 0.1, label = "0", fontface = "bold", color = "black", hjust = 1.1) +
    annotate("text", x = 1, y = 0.1, label = "1", fontface = "bold", color = "black", hjust = 0) +
    
    # Línea base del eje x para la distinción por genero
    geom_segment(aes(x = 0, xend = 1, y = 0, yend = 0), color = "gray95", linewidth = 4.5) +
    annotate("text", x = 0, y = 0, label = "0", fontface = "bold", color = "black", hjust = 1.1) +
    annotate("text", x = 1, y = 0, label = "1", fontface = "bold", color = "black", hjust = 0) +
    
    # Puntos para HCI
    geom_point(data = sa_data, 
               mapping = aes(x = Value, y = 0.1, color = Type, shape = Type, size = Size)) +
    # Etiquetas solo para Kenya
    geom_text(data = filter(sa_data, Type == "Kenya"),
              mapping = aes(x = Value, y = 0.1, label = Value),
              vjust = -2, fontface = "bold", size = 3) +
    
    # Puntos para gender
    geom_point(data = sa_gender_data, 
               mapping = aes(x = Value, y = 0, color = Type, shape = Type, size = Size)) +
    # Etiquetas solo para Kenya
    geom_text(data = sa_gender_data,
              mapping = aes(x = Value, y = 0, label = Value),
              vjust = -2, fontface = "bold", size = 3) +
    
    # Colores y tamaños definidos manualmente
    scale_color_manual(
      name = NULL,
      values = c(
        "Kenya" = "#E95D4E",
        "Income_group" = "#0CB2AF",
        "Region" = "#264653",
        "Female" = "#e9c46a",
        "Male" = "#f4a261"
      ),
      labels = c(
        "Kenya" = "Latest available \ndata for Kenya",
        "Income_group" = "Lower middle \nincome average",
        "Region" = "Sub-Saharan Africa \naverage",
        "Female" = "Women average \nin Kenya",
        "Male" = "Men average \nin Kenya"
      )
    ) +
    scale_shape_manual(
      name = NULL,
      values = c("Kenya" = 16, "Income_group" = 16, "Region" = 16,"Female" = 15, "Male" = 17),
      labels = c(
        "Kenya" = "Latest available \ndata for Kenya",
        "Income_group" = "Lower middle \nincome average",
        "Region" = "Sub-Saharan Africa \naverage",
        "Female" = "Women average \nin Kenya",
        "Male" = "Men average \nin Kenya"
      )
    ) +
    scale_size_identity() +
    scale_x_continuous(limits = c(0, 1), breaks = c(0, 1)) +
    scale_y_continuous(limits = c(-0.1, 0.2))+
    labs(title = "School Age HCI (6–17)") +
    theme_void(base_family = "sans") +
    theme(
      plot.title = element_text(hjust = 0.06, vjust = -1, face = "bold", size = 11,
                                margin = margin(t = 0, b = 0, l = 0, r = 0, "pt")),
      axis.text.x = element_blank(),
      axis.ticks.x = element_line(),
      axis.line.x = element_blank(),
      legend.position = c(0.52, 0.2),
      legend.justification = "center",
      legend.direction = "horizontal",
      legend.text = element_text(color="black", size =11),
      # Ancho fijo para cada “key” de la leyenda
      legend.key.width   = unit(1, "cm"),
      # Centramos el texto dentro de cada key
      #legend.text.align  = 0.5,
      plot.margin   = margin(0, 0, 0, 0, "pt"),
      panel.spacing = unit(0, "pt")
    )+
    guides(
      color = guide_legend(nrow = 2, byrow = TRUE, override.aes = list(size = 4)),
      shape = guide_legend(nrow = 2, byrow = TRUE, override.aes = list(size = 4))
    )
)

#### Young adult ####
  
# Datos solo para school age
ya_gender_data <- data.frame(
  Category = "Youth Adult HCI (18-24)",
  Female = 0.3,
  Male = 0.12
)

# Reorganizamos los datos en formato largo para ggplot
ya_gender_data <- pivot_longer(ya_gender_data, cols = c(Female, Male),
                          names_to = "Type", values_to = "Value")

# Definimos colores y tamaños
ya_gender_data <- ya_gender_data %>%
  mutate(
    Size = case_when(
      Type == "Female" ~ 6,
      Type == "Male" ~ 6
    ))

ya_gender_data$Type <- factor(ya_gender_data$Type,
                              levels = c("Female", "Male"))

# Gráfico
(ya_gender <- ggplot() +
    # Línea base del eje x para el HCI
    geom_segment(aes(x = 0, xend = 1, y = 0.1, yend = 0.1), color = "gray95", linewidth = 4.5) +
    annotate("text", x = 0, y = 0.1, label = "0", fontface = "bold", color = "black", hjust = 1.1) +
    annotate("text", x = 1, y = 0.1, label = "1", fontface = "bold", color = "black", hjust = 0) +
    
    # Línea base del eje x para la distinción por genero
    geom_segment(aes(x = 0, xend = 1, y = 0, yend = 0), color = "gray95", linewidth = 4.5) +
    annotate("text", x = 0, y = 0, label = "0", fontface = "bold", color = "black", hjust = 1.1) +
    annotate("text", x = 1, y = 0, label = "1", fontface = "bold", color = "black", hjust = 0) +
    
    # Puntos para HCI
    geom_point(data = ya_data, 
               mapping = aes(x = Value, y = 0.1, color = Type, shape = Type, size = Size)) +
    # Etiquetas solo para Kenya
    geom_text(data = filter(ya_data, Type == "Kenya"),
              mapping = aes(x = Value, y = 0.1, label = Value),
              vjust = -2, fontface = "bold", size = 3) +
    
    # Puntos para gender
    geom_point(data = ya_gender_data, 
               mapping = aes(x = Value, y = 0, color = Type, shape = Type, size = Size)) +
    # Etiquetas solo para Kenya
    geom_text(data = ya_gender_data,
              mapping = aes(x = Value, y = 0, label = Value),
              vjust = -2, fontface = "bold", size = 3) +
    
    # Colores y tamaños definidos manualmente
    scale_color_manual(
      name = NULL,
      values = c(
        "Kenya" = "#E95D4E",
        "Income_group" = "#0CB2AF",
        "Region" = "#264653",
        "Female" = "#e9c46a",
        "Male" = "#f4a261"
      ),
      labels = c(
        "Kenya" = "Latest available \ndata for Kenya",
        "Income_group" = "Lower middle \nincome average",
        "Region" = "Sub-Saharan Africa \naverage",
        "Female" = "Women average \nin Kenya",
        "Male" = "Men average \nin Kenya"
      )
    ) +
    scale_shape_manual(
      name = NULL,
      values = c("Kenya" = 16, "Income_group" = 16, "Region" = 16,"Female" = 15, "Male" = 17),
      labels = c(
        "Kenya" = "Latest available \ndata for Kenya",
        "Income_group" = "Lower middle \nincome average",
        "Region" = "Sub-Saharan Africa \naverage",
        "Female" = "Women average \nin Kenya",
        "Male" = "Men average \nin Kenya"
      )
    ) +
    scale_size_identity() +
    scale_x_continuous(limits = c(0, 1), breaks = c(0, 1)) +
    scale_y_continuous(limits = c(-0.1, 0.2))+
    labs(title = "Young Adult HCI (18–24)") +
    theme_void(base_family = "sans") +
    theme(
      plot.title = element_text(hjust = 0.06, vjust = -1, face = "bold", size = 11,
                                margin = margin(t = 0, b = 0, l = 0, r = 0, "pt")),
      axis.text.x = element_blank(),
      axis.ticks.x = element_line(),
      axis.line.x = element_blank(),
      legend.position = c(0.52, 0.2),
      legend.justification = "center",
      legend.direction = "horizontal",
      legend.text = element_text(color="black", size =11),
      # Ancho fijo para cada “key” de la leyenda
      legend.key.width   = unit(1, "cm"),
      # Centramos el texto dentro de cada key
      #legend.text.align  = 0.5
      plot.margin   = margin(0, 0, 0, 0, "pt"),
      panel.spacing = unit(0, "pt")
    )+
    guides(
      color = guide_legend(nrow = 2, byrow = TRUE, override.aes = list(size = 4)),
      shape = guide_legend(nrow = 2, byrow = TRUE, override.aes = list(size = 4))
    )
)

#### Working Age #### 
# Datos
wa_gender_data <- data.frame(
  Category = "Working Age HCI (25-65)",
  Female = 0.05,
  Male = 0.3
)

# Reorganizamos los datos en formato largo para ggplot
wa_gender_data <- pivot_longer(wa_gender_data, cols = c(Female, Male),
                        names_to = "Type", values_to = "Value")

# Definimos colores y tamaños
wa_gender_data <- wa_gender_data %>%
  mutate(
    Size = case_when(
      Type == "Female" ~ 6,
      Type == "Male" ~ 6
    ))

wa_gender_data$Type <- factor(wa_gender_data$Type,
                              levels = c("Female", "Male"))

# Gráfico
(wa_gender <- ggplot() +
    # Línea base del eje x para el HCI
    geom_segment(aes(x = 0, xend = 1, y = 0.1, yend = 0.1), color = "gray95", linewidth = 4.5) +
    annotate("text", x = 0, y = 0.1, label = "0", fontface = "bold", color = "black", hjust = 1.1) +
    annotate("text", x = 1, y = 0.1, label = "1", fontface = "bold", color = "black", hjust = 0) +
    
    # Línea base del eje x para la distinción por genero
    geom_segment(aes(x = 0, xend = 1, y = 0, yend = 0), color = "gray95", linewidth = 4.5) +
    annotate("text", x = 0, y = 0, label = "0", fontface = "bold", color = "black", hjust = 1.1) +
    annotate("text", x = 1, y = 0, label = "1", fontface = "bold", color = "black", hjust = 0) +
  
  # Puntos para HCI
  geom_point(data = wa_data, 
             mapping = aes(x = Value, y = 0.1, color = Type, shape = Type, size = Size)) +
  # Etiquetas solo para Kenya
  geom_text(data = filter(wa_data, Type == "Kenya"),
            mapping = aes(x = Value, y = 0.1, label = Value),
            vjust = -2, fontface = "bold", size = 3) +
    
  # Puntos para gender
  geom_point(data = wa_gender_data, 
             mapping = aes(x = Value, y = 0, color = Type, shape = Type, size = Size)) +
  # Etiquetas solo para Kenya
  geom_text(data = wa_gender_data,
              mapping = aes(x = Value, y = 0, label = Value),
              vjust = -2, fontface = "bold", size = 3) +
  
  # Colores y tamaños definidos manualmente
  scale_color_manual(
      name = NULL,
      values = c(
        "Kenya" = "#E95D4E",
        "Income_group" = "#0CB2AF",
        "Region" = "#264653",
        "Female" = "#e9c46a",
        "Male" = "#f4a261"
      ),
      labels = c(
        "Kenya" = "Latest available \ndata for Kenya",
        "Income_group" = "Lower middle \nincome average",
        "Region" = "Sub-Saharan Africa \naverage",
        "Female" = "Women average \nin Kenya",
        "Male" = "Men average \nin Kenya"
      )
  ) +
  scale_shape_manual(
      name = NULL,
      values = c("Kenya" = 16, "Income_group" = 16, "Region" = 16,"Female" = 15, "Male" = 17),
      labels = c(
        "Kenya" = "Latest available \ndata for Kenya",
        "Income_group" = "Lower middle \nincome average",
        "Region" = "Sub-Saharan Africa \naverage",
        "Female" = "Women average \nin Kenya",
        "Male" = "Men average \nin Kenya"
      )
    ) +
  scale_size_identity() +
  scale_x_continuous(limits = c(0, 1), breaks = c(0, 1)) +
  scale_y_continuous(limits = c(-0.1, 0.2))+
  labs(title = "Working Age HCI (25–65)") +
  theme_void(base_family = "sans") +
  theme(
    plot.title = element_text(hjust = 0.06, vjust = -1, face = "bold", size = 11,
                              margin = margin(t = 0, b = 0, l = 0, r = 0, "pt")),
    axis.text.x = element_blank(),
    axis.ticks.x = element_line(),
    axis.line.x = element_blank(),
    legend.position = c(0.52, 0.2),
    legend.justification = "center",
    legend.direction = "horizontal",
    legend.text = element_text(color="black", size =11),
    # Ancho fijo para cada “key” de la leyenda
    legend.key.width   = unit(1, "cm"),
    # Centramos el texto dentro de cada key
    #legend.text.align  = 0.5
    plot.margin   = margin(0, 0, 0, 0, "pt"),
    panel.spacing = unit(0, "pt")
  )+
    guides(
      color = guide_legend(nrow = 2, byrow = TRUE, override.aes = list(size = 4)),
      shape = guide_legend(nrow = 2, byrow = TRUE, override.aes = list(size = 4))
    )
)



#### Junto los graficos ####

# Quitar leyenda de los tres primeros
lhci_noleg <- lhci_gender + theme(legend.position = "none")
ec_noleg <- ec_gender + theme(legend.position = "none")
sa_noleg <- sa_gender + theme(legend.position = "none")
ya_noleg <- ya_gender + theme(legend.position = "none")
wa_noleg <- wa_gender + theme(legend.position = "none")
# wa_gender mantiene su leyenda

# Apilar y recolectar leyenda
combined <- (lhci_noleg / 
               ec_noleg  /
               sa_noleg  /
               ya_noleg  /
               wa_gender) +
  plot_layout(
    ncol   = 1,
    guides = "collect"     # recoge sólo la leyenda que queda (la de wa_gender)
  ) +
  plot_annotation(
    title = "Human Capital Index Snapshot",
    theme = theme(
      plot.title = element_text(
        family = "sans", face = "bold",
        size   = 14,    hjust = 0.5
      )
    )
  )
combined

# 3) Tema global: leyenda abajo, centrada, en fila
final <- combined & 
  theme(
    legend.position      = "bottom",
    legend.direction     = "horizontal",
    legend.box           = "horizontal",
    legend.justification = "center"
  )

print(final)
ggsave(filename = "Output/lhci_stage_sex.png",width = 5.5, height = 10,dpi = 300,   bg = "white")
}
# ---------- Opción 5: plot del LCHI solo por género  ---------- #
{
#### LHCI ####

# Gráfico
(lhci_gender_s <- ggplot() +
    # Línea base del eje x para la distinción por genero
    geom_segment(aes(x = 0, xend = 1, y = 0, yend = 0), color = "gray95", linewidth = 4.5) +
    annotate("text", x = 0, y = 0, label = "0", fontface = "bold", color = "black", hjust = 1.1) +
    annotate("text", x = 1, y = 0, label = "1", fontface = "bold", color = "black", hjust = 0) +
    
    # Puntos para gender
    geom_point(data = hci_data_gender, 
               mapping = aes(x = Value, y = 0, color = Type, shape = Type, size = Size)) +
    # Etiquetas 
    geom_text(data = hci_data_gender,
              mapping = aes(x = Value, y = 0, label = Value),
              vjust = -2, fontface = "bold", size = 3) +
    
    # Colores y tamaños definidos manualmente
    scale_color_manual(
      name = NULL,
      values = c(
        "Female" = "#e9c46a",
        "Male" = "#f4a261"
      ),
      labels = c(
        "Female" = "Women average \nin Kenya",
        "Male" = "Men average \nin Kenya"
      )
    ) +
    scale_shape_manual(
      name = NULL,
      values = c("Female" = 15, "Male" = 17),
      labels = c(
        "Female" = "Women average \nin Kenya",
        "Male" = "Men average \nin Kenya"
      )
    ) +
    scale_size_identity() +
    scale_x_continuous(limits = c(0, 1), breaks = c(0, 1)) +
    scale_y_continuous(limits = c(-0.1, 0.1))+
    labs(title = "Lifetime Human Capital Indez (LHCI)") +
    theme_void(base_family = "sans") +
    theme(
      plot.title = element_text(hjust = 0.06, vjust = -2, face = "bold", size = 11,
                                margin = margin(t = 0, b = 0, l = 0, r = 0, "pt")),
      axis.text.x = element_blank(),
      axis.ticks.x = element_line(),
      axis.line.x = element_blank(),
      legend.position = c(0.52, 0.2),
      legend.justification = "center",
      legend.direction = "horizontal",
      legend.text = element_text(color="black", size =11),
      legend.key.width   = unit(1, "cm"),   # Ancho fijo para cada “key” de la leyenda
      #legend.text.align  = 0.5     # Centramos el texto dentro de cada key
      plot.margin   = margin(0, 0, 0, 0, "pt"),  # Sin margen alrededor
      panel.spacing = unit(0, "pt"),   # Sin espacio interno entre panels
    )+
    guides(
      #color = guide_legend(nrow = 1, byrow = TRUE, override.aes = list(size = 4)),
      shape = guide_legend(nrow = 1, byrow = TRUE, override.aes = list(size = 4))
    )
)


#### Early childhood ####
# Gráfico
(ec_gender_s <- ggplot() +
   # Línea base del eje x para la distinción por genero
   geom_segment(aes(x = 0, xend = 1, y = 0, yend = 0), color = "gray95", linewidth = 4.5) +
   annotate("text", x = 0, y = 0, label = "0", fontface = "bold", color = "black", hjust = 1.1) +
   annotate("text", x = 1, y = 0, label = "1", fontface = "bold", color = "black", hjust = 0) +
   
   # Puntos para gender
   geom_point(data = ec_gender_data, 
              mapping = aes(x = Value, y = 0, color = Type, shape = Type, size = Size)) +
   # Etiquetas
   geom_text(data = ec_gender_data,
             mapping = aes(x = Value, y = 0, label = Value),
             vjust = -2, fontface = "bold", size = 3) +
   
   # Colores y tamaños definidos manualmente
   scale_color_manual(
     name = NULL,
     values = c(
       "Female" = "#e9c46a",
       "Male" = "#f4a261"
     ),
     labels = c(
       "Female" = "Women average \nin Kenya",
       "Male" = "Men average \nin Kenya"
     )
   ) +
   scale_shape_manual(
     name = NULL,
     values = c("Female" = 15, "Male" = 17),
     labels = c(
       "Female" = "Women average \nin Kenya",
       "Male" = "Men average \nin Kenya"
     )
   ) +
   scale_size_identity() +
   scale_x_continuous(limits = c(0, 1), breaks = c(0, 1)) +
   scale_y_continuous(limits = c(-0.1, 0.1))+
   labs(title = "Early Childhood HCI (0–5)") +
   theme_void(base_family = "sans") +
   theme(
     plot.title = element_text(hjust = 0.06, vjust = -1, face = "bold", size = 11,
                               margin = margin(t = 0, b = 0, l = 0, r = 0, "pt")),
     axis.text.x = element_blank(),
     axis.ticks.x = element_line(),
     axis.line.x = element_blank(),
     legend.position = c(0.52, 0.2),
     legend.justification = "center",
     legend.direction = "horizontal",
     legend.text = element_text(color="black", size =11),
     legend.key.width   = unit(1, "cm"),   # Ancho fijo para cada “key” de la leyenda
     #legend.text.align  = 0.5     # Centramos el texto dentro de cada key
     plot.margin   = margin(0, 0, 0, 0, "pt"),  # Sin margen alrededor
     panel.spacing = unit(0, "pt"),   # Sin espacio interno entre panels
   )+
   guides(
     #color = guide_legend(nrow = 1, byrow = TRUE, override.aes = list(size = 4)),
     shape = guide_legend(nrow = 1, byrow = TRUE, override.aes = list(size = 4))
   )
)


#### School age ####
# Gráfico
(sa_gender_s <- ggplot() +
   # Línea base del eje x para la distinción por genero
   geom_segment(aes(x = 0, xend = 1, y = 0, yend = 0), color = "gray95", linewidth = 4.5) +
   annotate("text", x = 0, y = 0, label = "0", fontface = "bold", color = "black", hjust = 1.1) +
   annotate("text", x = 1, y = 0, label = "1", fontface = "bold", color = "black", hjust = 0) +
   
   # Puntos para gender
   geom_point(data = sa_gender_data, 
              mapping = aes(x = Value, y = 0, color = Type, shape = Type, size = Size)) +
   # Etiquetas
   geom_text(data = sa_gender_data,
             mapping = aes(x = Value, y = 0, label = Value),
             vjust = -2, fontface = "bold", size = 3) +
   
   # Colores y tamaños definidos manualmente
   scale_color_manual(
     name = NULL,
     values = c(
       "Female" = "#e9c46a",
       "Male" = "#f4a261"
     ),
     labels = c(
       "Female" = "Women average \nin Kenya",
       "Male" = "Men average \nin Kenya"
     )
   ) +
   scale_shape_manual(
     name = NULL,
     values = c("Female" = 15, "Male" = 17),
     labels = c(
       "Female" = "Women average \nin Kenya",
       "Male" = "Men average \nin Kenya"
     )
   ) +
   scale_size_identity() +
   scale_x_continuous(limits = c(0, 1), breaks = c(0, 1)) +
   scale_y_continuous(limits = c(-0.1, 0.1))+
   labs(title = "School Age HCI (6–17)") +
   theme_void(base_family = "sans") +
   theme(
     plot.title = element_text(hjust = 0.06, vjust = -1, face = "bold", size = 11,
                               margin = margin(t = 0, b = 0, l = 0, r = 0, "pt")),
     axis.text.x = element_blank(),
     axis.ticks.x = element_line(),
     axis.line.x = element_blank(),
     legend.position = c(0.52, 0.2),
     legend.justification = "center",
     legend.direction = "horizontal",
     legend.text = element_text(color="black", size =11),
     # Ancho fijo para cada “key” de la leyenda
     legend.key.width   = unit(1, "cm"),
     # Centramos el texto dentro de cada key
     #legend.text.align  = 0.5,
     plot.margin   = margin(0, 0, 0, 0, "pt"),
     panel.spacing = unit(0, "pt")
   )+
   guides(
     #color = guide_legend(nrow = 1, byrow = TRUE, override.aes = list(size = 4)),
     shape = guide_legend(nrow = 1, byrow = TRUE, override.aes = list(size = 4))
   )
)


#### Young adult ####
# Gráfico
(ya_gender_s <- ggplot() +
   # Línea base del eje x para la distinción por genero
   geom_segment(aes(x = 0, xend = 1, y = 0, yend = 0), color = "gray95", linewidth = 4.5) +
   annotate("text", x = 0, y = 0, label = "0", fontface = "bold", color = "black", hjust = 1.1) +
   annotate("text", x = 1, y = 0, label = "1", fontface = "bold", color = "black", hjust = 0) +
   
   # Puntos para gender
   geom_point(data = ya_gender_data, 
              mapping = aes(x = Value, y = 0, color = Type, shape = Type, size = Size)) +
   # Etiquetas
   geom_text(data = ya_gender_data,
             mapping = aes(x = Value, y = 0, label = Value),
             vjust = -2, fontface = "bold", size = 3) +
   
   # Colores y tamaños definidos manualmente
   scale_color_manual(
     name = NULL,
     values = c(
       "Female" = "#e9c46a",
       "Male" = "#f4a261"
     ),
     labels = c(
       "Female" = "Women average \nin Kenya",
       "Male" = "Men average \nin Kenya"
     )
   ) +
   scale_shape_manual(
     name = NULL,
     values = c("Female" = 15, "Male" = 17),
     labels = c(
       "Female" = "Women average \nin Kenya",
       "Male" = "Men average \nin Kenya"
     )
   ) +
   scale_size_identity() +
   scale_x_continuous(limits = c(0, 1), breaks = c(0, 1)) +
   scale_y_continuous(limits = c(-0.1, 0.1))+
   labs(title = "Young Adult HCI (18–24)") +
   theme_void(base_family = "sans") +
   theme(
     plot.title = element_text(hjust = 0.06, vjust = -1, face = "bold", size = 11,
                               margin = margin(t = 0, b = 0, l = 0, r = 0, "pt")),
     axis.text.x = element_blank(),
     axis.ticks.x = element_line(),
     axis.line.x = element_blank(),
     legend.position = c(0.52, 0.2),
     legend.justification = "center",
     legend.direction = "horizontal",
     legend.text = element_text(color="black", size =11),
     # Ancho fijo para cada “key” de la leyenda
     legend.key.width   = unit(1, "cm"),
     # Centramos el texto dentro de cada key
     #legend.text.align  = 0.5
     plot.margin   = margin(0, 0, 0, 0, "pt"),
     panel.spacing = unit(0, "pt")
   )+
   guides(
     #color = guide_legend(nrow = 1, byrow = TRUE, override.aes = list(size = 4)),
     shape = guide_legend(nrow = 1, byrow = TRUE, override.aes = list(size = 4))
   )
)

#### Working Age #### 
# Gráfico
(wa_gender_s <- ggplot() +
   # Línea base del eje x para la distinción por genero
   geom_segment(aes(x = 0, xend = 1, y = 0, yend = 0), color = "gray95", linewidth = 4.5) +
   annotate("text", x = 0, y = 0, label = "0", fontface = "bold", color = "black", hjust = 1.1) +
   annotate("text", x = 1, y = 0, label = "1", fontface = "bold", color = "black", hjust = 0) +
   
   # Puntos para gender
   geom_point(data = wa_gender_data, 
              mapping = aes(x = Value, y = 0, color = Type, shape = Type, size = Size)) +
   # Etiquetas
   geom_text(data = wa_gender_data,
             mapping = aes(x = Value, y = 0, label = Value),
             vjust = -2, fontface = "bold", size = 3) +
   
   # Colores y tamaños definidos manualmente
   scale_color_manual(
     name = NULL,
     values = c(
       "Female" = "#e9c46a",
       "Male" = "#f4a261"
     ),
     labels = c(
       "Female" = "Women average \nin Kenya",
       "Male" = "Men average \nin Kenya"
     )
   ) +
   scale_shape_manual(
     name = NULL,
     values = c("Female" = 15, "Male" = 17),
     labels = c(
       "Female" = "Women average \nin Kenya",
       "Male" = "Men average \nin Kenya"
     )
   ) +
   scale_size_identity() +
   scale_x_continuous(limits = c(0, 1), breaks = c(0, 1)) +
   scale_y_continuous(limits = c(-0.1, 0.1))+
   labs(title = "Working Age HCI (25–65)") +
   theme_void(base_family = "sans") +
   theme(
     plot.title = element_text(hjust = 0.06, vjust = -1, face = "bold", size = 11,
                               margin = margin(t = 0, b = 0, l = 0, r = 0, "pt")),
     axis.text.x = element_blank(),
     axis.ticks.x = element_line(),
     axis.line.x = element_blank(),
     legend.position = c(0.52, 0.2),
     legend.justification = "center",
     legend.direction = "horizontal",
     legend.text = element_text(color="black", size =11),
     # Ancho fijo para cada “key” de la leyenda
     legend.key.width   = unit(1, "cm"),
     # Centramos el texto dentro de cada key
     #legend.text.align  = 0.5
     plot.margin   = margin(0, 0, 0, 0, "pt"),
     panel.spacing = unit(0, "pt")
   )+
   guides(
     #color = guide_legend(nrow = 1, byrow = TRUE, override.aes = list(size = 4)),
     shape = guide_legend(nrow = 1, byrow = TRUE, override.aes = list(size = 4))
   )
)

#### Junto los graficos #### 
# Quitar leyenda de los tres primeros
lhci_noleg_s <- lhci_gender_s + theme(legend.position = "none")
ec_noleg_s <- ec_gender_s + theme(legend.position = "none")
sa_noleg_s <- sa_gender_s + theme(legend.position = "none")
ya_noleg_s <- ya_gender_s + theme(legend.position = "none")
wa_noleg_s <- wa_gender_s + theme(legend.position = "none")
# wa_gender mantiene su leyenda

# Apilar y recolectar leyenda
combined_s <- (lhci_noleg_s / 
               ec_noleg_s  /
               sa_noleg_s  /
               ya_noleg_s  /
               wa_gender_s) +
  plot_layout(
    ncol   = 1,
    guides = "collect"     # recoge sólo la leyenda que queda (la de wa_gender)
  ) +
  plot_annotation(
    title = "Differences in LHCI Across Genders and Life Stages",
    theme = theme(
      plot.title = element_text(
        family = "sans", face = "bold",
        size   = 14,    hjust = 0.5
      )
    )
  )
combined_s

# 3) Tema global: leyenda abajo, centrada, en fila
final_s <- combined_s & 
  theme(
    legend.position      = "bottom",
    legend.direction     = "horizontal",
    legend.box           = "horizontal",
    legend.justification = "center"
  )

print(final_s)
ggsave(filename = "Output/lhci_sex.png",width = 6, height = 5,dpi = 300,   bg = "white")

#### Automatizacion #### 

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
      data = data %>% filter(Type == "Female"),
      aes(x = Value, y = 0, label = Value),
      vjust = -1.5,              # por encima
      fontface = "bold", size = 4, family = "Open Sans"
    ) +
    geom_text(
      data = data %>% filter(Type == "Male"),
      aes(x = Value, y = 0, label = Value),
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

(p_lhci_g <- crear_gender_plot(0.1, 0.25, "Lifetime Human Capital Index (LHCI)", show_legend = TRUE))
p_ec_g   <- crear_gender_plot(0.27, 0.41, "Early Childhood HCI (0-5)")
p_sa_g   <- crear_gender_plot(0.5, 0.6, "School Age HCI (6-17)")
p_ya_g   <- crear_gender_plot(0.12, 0.3, "Youth Adult HCI (18-24)")
(p_wa_g   <- crear_gender_plot(0.05, 0.15, "Working Age HCI (25-65)"))

# Armar layout
combined_g <- (p_ec_g / p_sa_g / p_ya_g / p_wa_g) +
  plot_layout(ncol = 1, guides = "collect")

final_kenya_g <- combined_g & 
  theme(
    plot.title = element_text(family = "Open Sans", face = "bold", size = 11, hjust = 0.06),
    legend.position      = "top",
    #legend.key.width = unit(0.1, "cm"),
    legend.direction     = "horizontal",
    legend.box           = "horizontal",
    legend.justification = "center",
  )

final_kenya_g
ggsave(filename = paste(out, "/lchi_gender2.png", sep =""),
       plot= final_kenya_g, width = 5.5, height = 4.5,dpi = 300,  bg = "white")

}
