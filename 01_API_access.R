# Carga de librerías
#install.packages("rsdmx")    # si necesitás el equivalente SDMX
#install.packages("dplyr")     # para manipulación de dataframes
install.packages("labelled")
library(rsdmx)
library(dplyr)
library(purrr)
library(tibble)
library(tidyr)
library(haven)
library(labelled)
library(stringr)

# Defino las rutas y la fecha globales
  portal         <- "/Users/florenciaruiz/Library/Mobile Documents/com~apple~CloudDocs/World Bank/Briefs/Data-Portal-Brief-Generator"
  data_raw       <- file.path(portal, "Data", "Data_Raw")
  data_processed <- file.path(portal, "Data", "Data_Processed")
  date           <- "27_jun_2023"
  extra          <- ""

# Definición del vector de indicadores
indicators_for_briefs <- c(
  "MNCH_MLRACT",   # Malaria testing en febrile children <5
  "MNCH_MLRDIAG",  # ACT treatment share
  "MNCH_PNEUCARE", # ARI care seeking
  "MNCH_ORS",      # ORS treatment
  "MNCH_ITN",      # Uso de mosquiteros insecticidas en <5
  "MNCH_MLRCARE",  # Care seeking for malaria 
  # "MNCH_PNEUMORT", # Pneumonia mortality rate --> no esta 
  "NT_ANT_HAZ_NE2",# Stunting
  "NT_ANT_WHZ_NE2",# Wasting
  "NT_ANT_WHZ_NE3",# Severe wasting
  "NT_ANT_WHZ_PO2",# Overweight
  "NT_BF_EXBF",    # Exclusive breastfeeding
  "NT_CF_MMF",     # Minimum meal frequency
  "MNCH_ANC1",     # ANC coverage ≥1 visit
  "MNCH_ANC4",     # ANC coverage ≥4 visits
  "PT_CHLD_5-17_LBR_ECON", # Child labour
  "ED_READ_G23",   # Reading proficiency
  "ED_MAT_G23",    # Math proficiency
  "HVA_EPI_DTH_RT",        # AIDS deaths rate (usamos 0–14)
  "HVA_EPI_DTH_ANN",       # AIDS deaths rate (usamos 15–24)
  "HVA_EPI_INF_RT",        # HIV incidence rate (usamos 0–14 y 10–19)
  "HVA_PMTCT_MTCT",        # MTCT rate
  "HVA_PED_ART_CVG",       # ART coverage children
  "HVA_PREV_KNOW",         # HIV knowledge 15–24
  "HVA_PREV_KNOW_TEST",    # Knowledge of test site
  "PT_M_18-29_SX-V_AGE-18",# Male sexual violence
  "PT_F_18-29_SX-V_AGE-18",# Female sexual violence
  "MNCH_DEMAND_FP",        # Family planning demand met
  "MNCH_SAB",              # Skilled birth attendant
  "MNCH_ITNPREG",          # ITN use in pregnant women
  "MNCH_BIRTH18",          # Birth before 18 rate
  "MNCH_PNCNB",            # Postnatal care newborns
  "MNCH_PNCMOM",           # Postnatal care mothers
  "MNCH_DIARCARE",         # Diarrhea care seeking
  
  # Vacunas
  "IM_BCG", "IM_DTP1", "IM_DTP3", "IM_HEPB3", "IM_HEPBB",
  "IM_HIB3", "IM_IPV1", "IM_MCV1", "IM_MCV2", "IM_PCV3",
  "IM_POL3", "IM_ROTAC", "IM_HPV",
  
  # Mortalidad infantil
  "CME_MRM0", "CME_MRY0T4", "CME_MRY5T14", "CME_MRY15T24",
  
  # Desarrollo infantil
  "ECD_CHLD_LMPSL", "C040202", "CME_SBR",
 
   # WASH
  "WS_PPL_W-ALB", "WS_PPL_S-ALB","WS_PPL_H-B",
  "WS_SCH_W-B","WS_HCF_W-B","WS_SCH_S-B",
  "WS_HCF_S-B","WS_SCH_H-B","WS_HCF_H-B"
)


get_country_codes <- function() {
  # 1) Leer la definición de estructura (DSD) para el flujo IMMUNISATION
  dsd_msg <- readSDMX(
    providerId = "UNICEF",
    resource   = "datastructure", 
    flowRef    = "IMMUNISATION"
  )
  
  # 2) Extraer el objeto data structure definition del flow IMMUNISATION
  dsd      <- dsd_msg@datastructures@datastructures
  flow_ids <- sapply(dsd, function(x) slot(x, "id"))
  i        <- which(flow_ids == "IMMUNISATION")  # posición del flujo
  dsd_imm <- dsd_msg@datastructures@datastructures[[i]]    
  
  # 3) Identificar el componente de dimensión REF_AREA
  dims <- dsd_imm@Components@Dimensions                                # Dimensiones del fata flow inmuunization
  idx <- which(sapply(dims, function(x) x@conceptRef) == "REF_AREA")   # Extraer la posición de "REF_AREA"
  ref_area_comp <- dims[[idx]]                                         # Extraer ese componente de la lista
  codelist_id <- ref_area_comp@codelist                                # Sacar el identificador del codelist de ese componente

  # 4) Extraer la lista de todos los codelists
  codelists  <- dsd_msg@codelists@codelists                                              # Extraer todos los codigos de UNICEF
  ref_codes  <- codelists[[ which(sapply(codelists, function(x) x@id) == codelist_id) ]] # Slot de codigo de paises
  codes_list <- ref_codes@Code                                                           # Extraer el sub-slot con todos los códigos de paises
  ids        <- sapply(codes_list, function(x) slot(x, "id"))                            # Extraer el id dentro del slot de cada pais (tiene el codigo)
  names      <- sapply(codes_list,function(x) slot(x, "name")[["en"]],
                                  USE.NAMES = FALSE)                                     # Extraer los nombres de paises
  
  # 5) Pasar a data.frame
  df <- data.frame(
    REF_AREA    = ids,
    name = names,
    stringsAsFactors = FALSE
  )
  
  return(df)
}

get_indicators_description <- function() {
  # 1) Leer la definición de estructura (DSD) para el flujo IMMUNISATION
  dsd_msg <- readSDMX(
    providerId = "UNICEF",
    resource   = "datastructure", 
    flowRef    = "IMMUNISATION"
  )
  
  # 2) Extraer el objeto data structure definition del flow IMMUNISATION
  dsd      <- dsd_msg@datastructures@datastructures
  flow_ids <- sapply(dsd, function(x) slot(x, "id"))
  i        <- which(flow_ids == "IMMUNISATION")  # posición del flujo
  dsd_imm <- dsd_msg@datastructures@datastructures[[i]]    
  
  # 3) Identificar el componente de dimensión INDICATOR
  dims <- dsd_imm@Components@Dimensions                                         # Dimensiones del fata flow inmuunization
  idx <- which(sapply(dims, function(x) x@conceptRef) == "UNICEF_INDICATOR")    # Extraer la posición de "UNICEF_INDICATOR"
  indicator_comp <- dims[[idx]]                                                 # Extraer ese componente de la lista
  codelist_id <- indicator_comp@codelist                                        # Sacar el identificador del codelist de ese componente
  
  # 4) Extraer la lista de todos los codelists
  codelists  <- dsd_msg@codelists@codelists                                              # Extraer todos los codigos de UNICEF
  ref_codes  <- codelists[[ which(sapply(codelists, function(x) x@id) == codelist_id) ]] # Slot de codigo de paises
  codes_list <- ref_codes@Code                                                           # Extraer el sub-slot con todos los códigos de paises
  ids        <- sapply(codes_list, function(x) slot(x, "id"))                            # Extraer el id dentro del slot de cada pais (tiene el codigo)
  parents    <- sapply(codes_list, function(x) slot(x, "parentCode"))   
  labels     <- sapply(codes_list,
                   function(x) slot(x, "label")[["en"]],
                   USE.NAMES = FALSE)                                                   # Extraer la descripción en inglés dentro del slot de cada pais 
  
  # 5) Combinar en un data.frame
  df <- data.frame(
    id    = ids,
    label = labels,
    parent = parents,
    stringsAsFactors = FALSE
  ) %>% 
  mutate(
    parent = ifelse(is.na(parent), "CL_UNICEF_INDICATOR", parent)
  )

  return(df)
}

get_list_of_unicef_indicators <- function(parent_database="IMMUNISATION") {
  # 1) Leer la definición de estructura (DSD) para el flujo IMMUNISATION
  dsd_msg <- readSDMX(
    providerId = "UNICEF",
    resource   = "datastructure", 
    flowRef    = "SDG_PROGRESS_ASSESSMENT"
  )
  
  # 2) Extraer el objeto data structure definition del flow parent_database
  dsd      <- dsd_msg@datastructures@datastructures
  flow_ids <- sapply(dsd, function(x) slot(x, "id"))
  i        <- which(flow_ids == "SDG_PROGRESS_ASSESSMENT")  # posición del flujo
  dsd_imm <- dsd_msg@datastructures@datastructures[[i]]    
  
  # 3) Identificar el componente de dimensión INDICATOR
  dims <- dsd_imm@Components@Dimensions                                         # Dimensiones del fata flow inmuunization
  idx <- which(sapply(dims, function(x) x@conceptRef) == "INDICATOR")    # Extraer la posición de "UNICEF_INDICATOR"
  indicator_comp <- dims[[idx]]                                                 # Extraer ese componente de la lista
  codelist_id <- indicator_comp@codelist                                        # Sacar el identificador del codelist de ese componente
  
  # 4) Extraer la lista de todos los codelists
  codelists  <- dsd_msg@codelists@codelists                                              # Extraer todos los codigos de UNICEF
  ref_codes  <- codelists[[ which(sapply(codelists, function(x) x@id) == codelist_id) ]] # Slot de codigo de paises
  codes_list <- ref_codes@Code                                                           # Extraer el sub-slot con todos los códigos de paises
  ids        <- sapply(codes_list, function(x) slot(x, "id"))                            # Extraer el id dentro del slot de cada pais (tiene el codigo)
  parents    <- sapply(codes_list, function(x) slot(x, "parentCode"))   
  labels     <- sapply(codes_list,
                       function(x) slot(x, "label")[["en"]],
                       USE.NAMES = FALSE)                                                   # Extraer la descripción en inglés dentro del slot de cada pais 
  
  # 5) Combinar en un data.frame
  df <- data.frame(
    id    = ids,
    label = labels,
    parent = parents,
    stringsAsFactors = FALSE
  ) %>% 
    mutate(
      parent = ifelse(is.na(parent), "CL_UNICEF_INDICATOR", parent)
    )
  
  return(df)
}

query_indicator <- function(indicator     = "CME_PND",
                            dataflow      = "CME",
                            startPeriod   = "2010",
                            countrycode   = "ARG") {
  # Llama al endpoint “data”
  msg <- readSDMX(
    providerId  = "UNICEF",
    resource    = "data",
    flowRef     = dataflow,         
    key         = list(
      REF_AREA  = countrycode,                 
      INDICATOR = indicator
    ),
    start = startPeriod               
  )
  
  # Convierte a data.frame
  df <- as.data.frame(msg)
  return(df)
}

# Función para limpiar niveles irrelevantes de un data.frame de SDMX
# Conserva solo REF_AREA, INDICATOR, TIME_PERIOD, SEX y DATA_SOURCE (y columna value)
# Filtra y elimina otros niveles, adaptando AGE según el indicador
drops_irrelevant_index_levels <- function(df) {
  # Definir grupos de indicadores por rango de edad
  indicator_0_to_5_years   <- c("NT_ANT_HAZ_NE2", "NT_ANT_WHZ_NE2", "NT_ANT_WHZ_NE3", "NT_ANT_WHZ_PO2", "NT_BF_EXBF")
  indicator_6_to_23_months  <- "NT_CF_MMF"
  indicator_36_to_59_months <- "ECD_CHLD_LMPSL"
  indicator_15_to_49_years  <- c("MNCH_ANC1", "MNCH_ANC4", "MNCH_DEMAND_FP", "MNCH_PNCMOM", "MNCH_SAB", "MNCH_ITNPREG")
  indicator_18_to_29_years  <- c("PT_M_18-29_SX-V_AGE-18", "PT_F_18-29_SX-V_AGE-18")
  indicator_15_to_24_years  <- c("HVA_PREV_KNOW", "HVA_PREV_KNOW_TEST", "HVA_PREV_CNDM_MULT","HVA_EPI_DTH_ANN")
  indicator_0_to_14_years   <- c("HVA_EPI_DTH_RT", "HVA_EPI_INF_RT")
  indicator_15_to_19_years  <-  "HVA_EPI_INF_RT"

  
  # 1) Renombrar "COUNTRY" a "REF_AREA" si existe
  if ("COUNTRY" %in% names(df)) {
    df <- df %>% rename(REF_AREA = COUNTRY)
  }
  
  # 2) Obtener indicador único
  indicador <- df %>% pull(INDICATOR) %>% unique() %>% .[1]
  
  # 3) Columnas esenciales y columnas a procesar
  essentials <- c("REF_AREA", "INDICATOR", "TIME_PERIOD", "SEX", "DATA_SOURCE", "OBS_VALUE")
  extras     <- setdiff(names(df), essentials)

  # 4) Recorrer columnas extras
  for (col in extras) {
    # a) Si hay totales (_T), quedarse solo con ellos
    if (any(df[[col]] == "_T", na.rm = TRUE)) {
      df <- df %>% filter(.data[[col]] == "_T") %>% select(-all_of(col))
      
      # b) Si la columna es AGE, aplicar filtros por indicador
    } else if (col == "AGE") {
        if (indicador %in% indicator_0_to_5_years) {
          df <- df %>% filter(AGE %in% c("Y0T4", "M0T5")) # FIX ME: DEJAR SOLO y0t4
        } else if (indicador %in% indicator_6_to_23_months) {
          df <- df %>% filter(AGE == "M6T23")
        } else if (indicador %in% indicator_36_to_59_months) {
          df <- df %>% filter(AGE == "M36T59")
        } else if (indicador %in% indicator_15_to_49_years) {
          df <- df %>% filter(AGE == "Y15T49")
        } else if (indicador %in% indicator_18_to_29_years) {
          df <- df %>% filter(AGE == "Y18T29")
        } else if (indicador %in% indicator_15_to_24_years) {
          df <- df %>% filter(AGE == "Y15T24")
        } else if (indicador %in% indicator_0_to_14_years) {
          df <- df %>% filter(AGE == "Y0T14")
        } else if (indicador %in% indicator_15_to_19_years) {
          df <- df %>% filter(AGE == "Y15T19")
        } else {
          # si no entra en ningún grupo, entonces se elimina AGE sin filtrar
          df <- df %>% select(-AGE)
        }
      # c) Si no es ni totales ni AGE, eliminar la columna
    } else {
      df <- df %>% select(-all_of(col))
    }
  }
  
  # 5) Verificar no duplicados
   if (nrow(df) != nrow(distinct(df))) {
     stop("There are duplicated rows.")
     }
  
  return(df)
}

# Función para limpiar niveles irrelevantes de un data.frame de SDMX para el caso especial del indicador HVA_EPI_INF_RT
# Usamos una funcion especial porque agarramos dos current age como si fueran distintos indicadores
drops_irrelevant_index_levels_HVA <- function(df) {
  # 1) Renombrar "COUNTRY" a "REF_AREA" si existe
  if ("COUNTRY" %in% names(df)) {
    df <- df %>% rename(REF_AREA = COUNTRY)
  }
  
  # 2) Obtener indicador único
  indicador <- df %>% pull(INDICATOR) %>% unique() %>% .[1]
  
  # 3) Columnas esenciales y columnas a procesar
  essentials <- c("REF_AREA", "INDICATOR", "TIME_PERIOD", "SEX", "DATA_SOURCE", "OBS_VALUE")
  extras     <- setdiff(names(df), essentials)
  
  # 4) Recorrer columnas extras
  for (col in extras) {
    # a) Si hay totales (_T), quedarse solo con ellos
    if (any(df[[col]] == "_T", na.rm = TRUE)) {
      df <- df %>% filter(.data[[col]] == "_T") %>% select(-all_of(col))
      
      # b) Si la columna es AGE, cambiar el nombre del indicador para dividrlo en 2
    } else if (col == "AGE") {
      df <- df %>% 
        mutate(
          INDICATOR = case_when(
            AGE == "Y0T14"  ~ "HVA_EPI_INF_RT_0_14",
            AGE == "Y15T19" ~ "HVA_EPI_INF_RT_15_19",
            TRUE            ~ "HVA_EPI_INF_RT"   # No debería haber otra categoría de edad según la metadata de unicef, pero por las dudas dejamos HVA_EPI_INF_RT
                                                 # Chequear en: https://sdmx.data.unicef.org/webservice/data.html
          )
        )
    } else {
  # c) Si no es ni totales ni AGE, eliminar la columna
  df <- df %>% select(-all_of(col))
    }
    }
  # 5) Verificar no duplicados
  if (nrow(df) != nrow(distinct(df))) {
    stop("There are duplicated rows.")
    }
  return(df)
}

# Función para formatear el data.frame tras la limpieza de niveles irrelevantes
dbv_format_dataframe <- function(df, cl_ref_areas, indicator) {
  # 1) Aplicar la función de limpieza de índices, con funcion diferenial para HVA_EPI_INF_RT
  if(indicator=="HVA_EPI_INF_RT"){
    df <- drops_irrelevant_index_levels_HVA(df)
  } else{
    df <- drops_irrelevant_index_levels(df)
  }
  
  # 2) Unir la etiqueta de país (cl_ref_areas) al data.frame
  #   REF_AREA (código de país) y name (etiqueta en texto)
  df <- df %>%
    left_join(
      cl_ref_areas %>%
        rename(COUNTRY = name),
      by = "REF_AREA"
    )
  
  # 3) Asegurar columna SEX (total ambos sexos)
  df <- df %>%
    mutate(SEX = "_T") # FIX ME: Se estan cambiando todos
  
  # 4) Reordenar columnas en el orden deseado
  df <- df %>%
    select(REF_AREA, COUNTRY, INDICATOR, TIME_PERIOD, SEX, OBS_VALUE)
  
  return(df)
}

#### Aplicar las funciones ####

# 1) Definir los códigos de indicadores WASH
# FIXME: if this raises errors, they must have fixed the WASH dataset. 
#   In such case, delete the wash indicators ifs in the loop (next fixme).
wash_indicators_house  <- c("WS_PPL_W-ALB", "WS_PPL_S-ALB", "WS_PPL_H-B")
wash_indicators_school <- c("WS_SCH_W-B", "WS_SCH_S-B", "WS_SCH_H-B")
wash_indicators_health <- c("WS_HCF_W-B", "WS_HCF_S-B", "WS_HCF_H-B")

# 2) Cargar catálogos de indicadores y países
indicators      <- get_indicators_description()
#indicators_sdg  <- get_list_of_unicef_indicators(parent_database = "SDG_PROG_ASSESSMENT")
cl_ref_areas    <- get_country_codes()

# 3) Inicializar contenedores
datasets <- list()
errores  <- character()
errores_paises <- tibble(
  indicator = character(),
  country   = character()
)

# 4) Bucle sobre los indicadores de interest
walk2(
  .x = seq_along(indicators_for_briefs),
  .y = indicators_for_briefs,
  .f = ~{
    i <- .x; selected_ind <- .y
    message(sprintf("%.1f%%: %s", 100 * i / length(indicators_for_briefs), selected_ind))
    tryCatch({
      # 4a) Determinar el parent SDMX
      if (selected_ind == "C040202") {
        selected_ind_code   <- selected_ind
        selected_ind_parent <- "SDG_PROG_ASSESSMENT"
      } else {
        print(selected_ind)
        row                 <- indicators[indicators$id==selected_ind, ]
        print(row)
        selected_ind_code   <- row$id        # Nombre del índice
        selected_ind_parent <- row$parent      # Data set padre
        print(selected_ind_parent)
      }
      # 4b) Corrección manual para WASH, ECD y MNCH_PNCNB
      if (selected_ind %in% wash_indicators_house) {
        selected_ind_parent <- "WASH_HOUSEHOLDS"
      } else if (selected_ind %in% wash_indicators_school) {
        selected_ind_parent <- "WASH_SCHOOLS"
      } else if (selected_ind %in% wash_indicators_health) {
        selected_ind_parent <- "WASH_HEALTHCARE_FACILITY"
      } else if (selected_ind == "ECD_CHLD_LMPSL") {
        selected_ind_parent <- "ECD"
      } else if (selected_ind == "MNCH_PNCNB") {
        selected_ind_parent <- "UNICEF,MNCH,1.0"
      }  
      print(selected_ind_parent)
      
      # 4c) Descarga y formateo
      df_raw <- map_dfr(cl_ref_areas$REF_AREA, function(pais) {
        message("Descargando país: ", pais)
        
        tryCatch({
          query_indicator(
            indicator   = selected_ind_code,
            dataflow    = selected_ind_parent,
            startPeriod = "2010",
            countrycode = pais
          )
        }, error = function(e) {
          message("❌ No hay data para el país: ", pais, "e  indicador", selected_ind)
          message("  ➤ ", e$message)
          errores_paises <<- bind_rows(
            errores_paises,
            tibble(
              indicator = selected_ind_code,
              country   = pais
            )
          )  # Agrega país con error a lista global
          NULL  # Retorna NULL para que map_dfr lo ignore
        })
      })
      
      # 4d) Verificar descarga
      if (nrow(df_raw) == 0) {
        stop("No se descargaron datos para ningún país.")
      }
      # 4e) Formateo
      df_fmt <- dbv_format_dataframe(df_raw, cl_ref_areas)
      # 4f) Guardar resultado
      datasets[[selected_ind_code]] <<- df_fmt
      
    }, error = function(e) {
      message("Error en: ", selected_ind)
      message(e$message)
      errores <<- c(errores, selected_ind)
    })
  }
)

# 5) Preparar etiquetas para Stata
labels_dict   <- indicators %>%
  filter(id %in% names(datasets)) %>%
  select(-parent) %>% 
  transmute(
    var   = paste0("i_", gsub("-", "_", id)),
    label = substr(label, 1, 80)
  ) %>%
  deframe()

# Agregar/actualizar dos labels puntuales del indicador HVA_EPI_INF_RT
labels_dict["i_HVA_EPI_INF_RT_0_14"] <- "Estimated incidence rate (new HIV infection per 1, 000 uninfected population, children aged 0-14 years)"
labels_dict["i_HVA_EPI_INF_RT_15_19"] <- "Estimated incidence rate (new HIV infection per 1, 000 uninfected population, adolescents aged 15-19 years)"
keys <- c("i_HVA_EPI_INF_RT_0_14", "i_HVA_EPI_INF_RT_15_19")
labels_dict[keys] <- substr(labels_dict[keys], 1, 80)

# 6) Concatenar y pivotar a formato wide
df_all <- bind_rows(datasets) %>%
  mutate(
    TIME_PERIOD = str_extract(as.character(TIME_PERIOD), "\\d{4}") %>% 
      as.integer(),
    INDICATOR   = paste0("i_", gsub("-", "_", INDICATOR))
  ) %>%
  arrange(REF_AREA, INDICATOR, SEX, TIME_PERIOD) %>%
  group_by(REF_AREA, INDICATOR, SEX, TIME_PERIOD) %>%
  slice_tail(n = 1) %>%  # ultima obs dentro del grupo
  ungroup() %>% 
  pivot_wider(
    id_cols  = c(REF_AREA, COUNTRY, TIME_PERIOD, SEX),
    names_from = INDICATOR,
    values_from = OBS_VALUE
  )

# 7) Exportar a Stata
output_file <- file.path(data_raw, sprintf("UNICEF_api_flor_%s.dta", date))

# labels_dict como named character vector
names_labels <-  names(labels_dict)
names_dfall <-  names(df_all)
setdiff(names_dfall, names_labels)

df_all <- df_all %>%
  set_variable_labels(!!!labels_dict)

write_dta(df_all, output_file)
message("Proceso finalizado. Archivo creado: ", output_file)


## FIX ME: hay 4810 obs. En stata hay 4,836 por que 26 tienen NA en el año. Son años que aca no se ponen porque son raros, tipo periods 1998-2022


# Ejemplo de uso:
country_codes <- get_country_codes()
indicator_desc <- get_indicators_description()
indicator_list <- get_list_of_unicef_indicators()
indicator_list <- get_list_of_unicef_indicators(parent_database="SDG_PROGRESS_ASSESSMENT")

df_ors <- query_indicator("C040202", "SDG_PROGRESS_ASSESSMENT", "ARG")
df_ors <-  query_indicator(
  indicator   = "NT_ANT_HAZ_NE2",
  dataflow    = "NUTRITION",
  startPeriod = "2010",
  countrycode = "ARG"
)

df_ors <-  query_indicator(
  indicator   = "HVA_EPI_INF_RT",
  dataflow    = "HIV_AIDS",
  startPeriod = "2010",
  countrycode = "ARG"
)

df_ors <-  query_indicator(
  indicator   = "HVA_EPI_INF_RT",
  dataflow    = "HIV_AIDS",
  startPeriod = "2010",
  countrycode = "AFG"
)
unique(df_ors$AGE)

df_ors_2 <- drops_irrelevant_index_levels_HVA(df_ors)
df_ors_3 <-  dbv_format_dataframe(df_ors_2, cl_ref_areas, HVA_EPI_INF_RT)

df_SDG <- as.data.frame(msg)

df_SDG2_2 <-drops_irrelevant_index_levels(df_SDG)
df_SDG2 <- dbv_format_dataframe(df_SDG, cl_ref_areas)


errores_paises <<- c()
df_raw <- map_dfr(cl_ref_areas$REF_AREA, function(pais) {
  message("Descargando país: ", pais)
  
  tryCatch({
    query_indicator(
      indicator   = "NT_ANT_HAZ_NE2",
      dataflow    = "NUTRITION",
      start = 2010,
      countrycode = pais
    )
  }, error = function(e) {
    message("❌ No hay data para el país: ", pais, " e indicador", "WS_HCF_H-B")
    message("  ➤ ", e$message)
    errores_paises <<- c(errores_paises, pais)  # Agrega país con error a lista global
    NULL  # Retorna NULL para que map_dfr lo ignore
  })
})

df_bol <- df_raw %>% 
  filter(
    REF_AREA=="BOL"
  )

datasets[["NT_ANT_HAZ_NE2"]] <- dbv_format_dataframe(df_raw, cl_ref_areas)
df_raw2 <-drops_irrelevant_index_levels(df_raw)
df_raw2 %>%
  filter(duplicated(.) | duplicated(., fromLast = TRUE)) %>% 
  View()

View(datasets[["WS_HCF_H-B"]])

