import pandasdmx as sdmx
import pandas as pd
from sfi import Macro

portal = Macro.getGlobal("portal")
data_raw = Macro.getGlobal("data_raw")
data_processed = Macro.getGlobal("data_processed")
date = Macro.getGlobal("date") # Date when the full process is run
extra = Macro.getGlobal("extra") # Placeholder for testing, just add "_test" or something like that to avoid overwrite db

indicators_for_briefs = [
    'MNCH_MLRACT', # Percentage of febrile children (under age 5) who had a finger or heel stick for malaria testing
    'MNCH_MLRDIAG', # Percentage of febrile children (under age 5) receiving ACT (first-line antimalarial drug), among those receiving any antimalarial drugs
    'MNCH_PNEUCARE', # Percentage of children (under age 5) with acute respiratory infection symptoms whom advice or treatment was sought from a health facility or provider
    'MNCH_ORS', # Diarrhea treatment with ORS
    'MNCH_ITN', # Use of insecticide-treated bed nets under 5
    'MNCH_MLRCARE', # Care seeking for malaria 
    'MNCH_PNEUMORT', # Pneumonia mortality rate
    'NT_ANT_HAZ_NE2', # Stunting
    'NT_ANT_WHZ_NE2', # Wasting
    'NT_ANT_WHZ_NE3', # Severe wasting
    'NT_ANT_WHZ_PO2', # Overweight
    'MNCH_ANC1', # Antenatal care coverage at least one visit
    'MNCH_ANC4', # Antenatal care coverage at least four visits
    'PT_CHLD_5-17_LBR_ECON', # Child labour
    'ED_READ_G23', # Proportion of children and young people c) at the end of lower secondary education achieving at least a minimum proficiency level in (i) reading
    'ED_MAT_G23',  # Proportion of students at the end of lower secondary achieving at least a minimum proficiency level in mathematics
    'HVA_EPI_DTH_RT_0-14',   # Estimated rate of annual AIDS-related deaths (per 100,000 population, children aged 0-14 years)	
    'HVA_EPI_DTH_ANN_15-24', # Estimated number of annual AIDS-related deaths (per 100,000 population, adolescents aged 15-24 years)
    'HVA_EPI_INF_RT_0-14',   # Estimated incidence rate(new HIV infection per 1, 000 uninfected population, children aged 0-14 years)
    'HVA_EPI_INF_RT_10-19',  # Estimated incidence rate(new HIV infection per 1, 000 uninfected population, adolescents aged 10-19 years)
    'HVA_PMTCT_MTCT',        # Mother-to-child HIV transmission rate
    'HVA_PED_ART_CVG',	# Per cent of children(aged 0-14 years) living with HIV and receiving antiretroviral therapy(ART)
    'HVA_PREV_KNOW',	# Per cent of young people(aged 15-24 years) with comprehensive, correct knowledge of HIV
    'HVA_PREV_KNOW_TEST',    # Per cent of young people (aged 15-24 years) who know a place to get tested for HIV
    # 'HVA_PREV_CNDM_MULT',    # Per cent of young people(aged 15-24 years) who had more than one sexual partner in the past 12 months reporting the use of a condom during their last sexual intercourse
    'PT_M_18-29_SX-V_AGE-18',# Percentage of men(aged 18-29 years) who experienced sexual violence by age 18
    'PT_F_18-29_SX-V_AGE-18',# Percentage of women(aged 18-29 years) who experienced sexual violence by age 18
    'MNCH_DEMAND_FP',   # Demand for family planning satisfied with modern methods - percentage of women(aged 15-49 years)
    'MNCH_SAB',	    # Skilled birth attendant - percentage of deliveries attended by skilled health personnel
    'MNCH_ITNPREG',	# Pregnant women sleeping under ITN - percentage of pregnant women(aged 15-49 years) who slept under an insecticide-treated net the previous night
    'MNCH_BIRTH18', # Early childbearing - percentage of women (aged 20-24 years) who gave birth before age 18
    ## Vaccines
    'IM_BCG',
    'IM_DTP1', 
    'IM_DTP3', 
    'IM_HEPB3', 
    'IM_HEPBB', 
    'IM_HIB3', 
    'IM_IPV1', 
    'IM_MCV1', 
    'IM_MCV2', 
    'IM_PCV3', 
    'IM_POL3', 
    'IM_ROTAC',
    'IM_HPV',
    ## Child mortality
    'CME_MRY0T4', #04mort
    'CME_MRY5T14', #514mort
    'CME_MRY15T24', #1512mort
    ## Caremother
    'MNCH_PNCNB', #Postnatal care for newborns within 2 days of birth
    ## Childs on track
    'ECD_CHLD_36-59M_LMPSL', # Proportion of children aged 24-59 months of age who are developmentally on track in health, learning and psychosocial well-being, by sex
    ## Organized learning pre-primary
    'C040202',
    ## Stilbirth
    ######
    ## WASH
    'WS_PPL_W-ALB', #  "Basic water in household"
    'WS_PPL_S-ALB', #  "Basic sanitation in household"
    'WS_PPL_H-B', # "Basic hygiene in household"
    'WS_SCH_W-B', #  "Basic water in school"
    'WS_HCF_W-B', # "Basic water in health facility"
    'WS_SCH_S-B', #  "Basic sanitation in school"
    'WS_HCF_S-B', # "Basic sanitation in health facility"
    'WS_SCH_H-B', #  "Basic hygiene in school"
    'WS_HCF_H-B', # "Basic hygiene in health facility"
]

def get_county_codes():
    # Get dataset structure from UNESCO
    unicef = sdmx.Request('UNICEF') # Queries the UNICEF database
    params = dict(startPeriod='2010')

    # Only immunisation
    exr_msg = unicef.dataflow('IMMUNISATION')
    exr_flow = exr_msg.dataflow.IMMUNISATION
    dsd = exr_flow.structure
    dsd.dimensions.components
    
    # Gets the dimensions REF_AREA of the dataflow -> Countries and regions.
    codelist = dsd.dimensions.get('REF_AREA').local_representation.enumerated
    cl_ref_areas = sdmx.to_pandas(codelist)
    
    return cl_ref_areas

def get_indicators_description():
    # Get dataset structure from UNESCO
    unicef = sdmx.Request('UNICEF') # Queries the UNICEF database
    params = dict(startPeriod='2010') # FIXME: ¿Desde que año hay que descargar los datos?

    # Only immunisation
    exr_msg = unicef.dataflow('IMMUNISATION')
    exr_flow = exr_msg.dataflow.IMMUNISATION
    dsd = exr_flow.structure
    dsd.dimensions.components
    
    # Gets the dimensions REF_AREA of the dataflow -> Countries and regions.
    codelist = dsd.dimensions.get('INDICATOR').local_representation.enumerated
    cl_indicators = sdmx.to_pandas(codelist)
    
    return cl_indicators


def get_list_of_unicef_indicators():
    ''' Returns a pd.DataFrame of all the indicators in the UNICEF database.
    
        Connects to the UNICEF database via SDMX and queries the list of indicators (index),
        the indicators description and the parent database of each.
    '''
    
    unicef = sdmx.Request('UNICEF')  # Queries the UNICEF database
    
    # Query any database (in this case IMMUNISATION) but it is irrelevant
    exr_msg = unicef.dataflow('IMMUNISATION')
    exr_flow = exr_msg.dataflow.IMMUNISATION
    dsd = exr_flow.structure

    # Prints the dimensions INDICATOR of the dataflow -> Indicators.
    codelist = dsd.dimensions.get('INDICATOR').local_representation.enumerated
    cl_indicators = sdmx.to_pandas(codelist)
    return cl_indicators

def query_indicator(indicator, database):
    unicef = sdmx.Request('UNICEF')  # Queries the UNICEF database
    key = dict(INDICATOR=[indicator])  # Pneumococcal conjugate vaccine, 3rd dose
    params = dict(startPeriod='2010')  # Start period
    data_msg = unicef.data(database, key=key, params=params)  # Gets the data

    df = sdmx.writer.pandas.write_datamessage(data_msg, dtype='str').to_frame()
    
    
    # data = data_msg.data[0]  # Gets the first dataset (there's only one)
    # # if sk.FREQ == 'D'] # Gets the series
    # data_for_pandasdmx = [series for series_key, series in data.series.items()]
    # # concat is required as sdmx.to_pandas returns a list of dataframes
    # df = pd.concat(sdmx.to_pandas(data_for_pandasdmx)).to_frame()
    return df

def drops_irrelevant_index_levels(df):
    
    indicator_0_to_5_years = [
        'NT_ANT_HAZ_NE2', 'NT_ANT_WHZ_NE2', 
        'NT_ANT_WHZ_NE3', 'NT_ANT_WHZ_PO2'
        ]
    indicator_15_to_49_years = [
        'MNCH_ANC1', 'MNCH_ANC4',
        'MNCH_DEMAND_FP', 
        'MNCH_SAB', 'MNCH_ITNPREG',
        ]
    indicator_18_to_29_years = [
        'PT_M_18-29_SX-V_AGE-18',
        'PT_F_18-29_SX-V_AGE-18',
    ]
    indicator_15_to_24_years = [
        'HVA_PREV_KNOW', 'HVA_PREV_KNOW_TEST', 
        'HVA_PREV_CNDM_MULT'
    ]
    
    indicador = df.index.get_level_values('INDICATOR').unique().values[0]

    indexes = df.index.names
    # print(f'Los indices de esta base son: {indexes}')
    irrelevant_indexes = [
        idx for idx in indexes if idx not in ['REF_AREA', 'INDICATOR', 'TIME_PERIOD', 'SEX', 'DATA_SOURCE']]
    # print(f'Se eliminan los indices {irrelevant_indexes}.')
    
    for idx in irrelevant_indexes:
        totals_mask = df.index.get_level_values(idx) == '_T'
        if totals_mask.sum() > 0:
            df = df[totals_mask].droplevel(idx)
        elif idx == 'AGE':
            if indicador in indicator_0_to_5_years:
                df = df[df.index.get_level_values('AGE') == 'Y0T4']
            elif indicador in indicator_15_to_49_years:
                df = df[df.index.get_level_values('AGE') == 'Y15T49']
            elif indicador in indicator_18_to_29_years:
                df = df[df.index.get_level_values('AGE') == 'Y18T29']
            elif indicador in indicator_15_to_24_years:
                df = df[df.index.get_level_values('AGE') == 'Y15T24']
            else:
                df = df.droplevel(idx)
        else:
            df = df.droplevel(idx)
    
    assert df.index.duplicated().sum() == 0, 'There are duplicated rows.'
    return df

def format_dataframe(df, cl_ref_areas):
    
    df = drops_irrelevant_index_levels(df)
    df = df.reset_index()

    # Adds the country name to the dataframe
    df = df.merge(cl_ref_areas[[
                            'name']], left_on='REF_AREA', right_index=True, how='left', validate='m:1')
    df = df.rename(columns={'name': 'COUNTRY'})

    # If SEX is not in the dataframe, it is added as 'B' (both)
    df['SEX'] = '_T'

    # Reorder dataframe columns
    ids = ['REF_AREA', 'COUNTRY', 'INDICATOR', 'TIME_PERIOD', 'SEX']
    df = df[ids + ['value']]
    return df



if __name__ == '__main__':

    # FIXME: if this raises errors, they must have fixed the WASH dataset. 
    #   In such case, delete the wash indicators ifs in the loop (next fixme).
    wash_indicators_house  = ['WS_PPL_W-ALB', 'WS_PPL_S-ALB','WS_PPL_H-B',]
    wash_indicators_school = ['WS_SCH_W-B','WS_SCH_S-B','WS_SCH_H-B',]
    wash_indicators_health = ['WS_HCF_W-B','WS_HCF_S-B','WS_HCF_H-B']
    
    indicators = get_list_of_unicef_indicators()
    cl_ref_areas = get_county_codes()

    # Get dataframes for each indicator in the dataset
    datasets = {}
    errores = []

    for i, selected_ind in enumerate(indicators_for_briefs):
        
        print(f'{round(i/len(indicators_for_briefs)*100, 1)}%: {selected_ind}')

        try:
            selected_ind_data = indicators.loc[selected_ind]
            selected_ind_code = selected_ind_data.name
            selected_ind_name = selected_ind_data['name']
            selected_ind_parent = selected_ind_data['parent']
                        
            # Parents in WASH are not correct
            #   FIXME: if this raises errors, they must have fixed the WASH dataset. Check previous fixme...
            if selected_ind in wash_indicators_house:
                selected_ind_parent = 'WASH_HOUSEHOLDS'
            elif selected_ind in wash_indicators_school:
                selected_ind_parent = 'WASH_SCHOOLS'
            elif selected_ind in wash_indicators_health:
                selected_ind_parent = 'WASH_HEALTHCARE_FACILITY'
            elif selected_ind == 'ECD_CHLD_36-59M_LMPSL':
                selected_ind_parent = 'ECD'
            elif selected_ind == 'C040202':
                selected_ind_parent == 'SDG_PROG_ASSESSMENT'
                
            df = query_indicator(selected_ind_code, selected_ind_parent)
            datasets[selected_ind_code] = format_dataframe(df, cl_ref_areas)
            
        except Exception as e: 
            print(f'####################################')
            print(f'error en {selected_ind}')
            print(e)
            print(f'####################################')
            errores += [selected_ind_code]
    
    # Turn codelist in stata labels (dictionary to pass into to_stata method)
    cl_indicators = get_indicators_description()
    labels_dict = cl_indicators['name'].to_dict()
    labels_dict = {f'i_{k.replace("-","_")}':v[:80] for k,v in labels_dict.items() if k in datasets.keys()}
    
    # Concatenate all datasets and save to stata
    df = pd.concat(list(datasets.values()))
    df['INDICATOR'] = 'i_' + df['INDICATOR'] # Agrego _i para simplificar el stata

    # Keep only the last observation per year
    df['TIME_PERIOD'] = pd.to_datetime(df.TIME_PERIOD)
    df = df.sort_values(by=['REF_AREA', 'INDICATOR','SEX', 'TIME_PERIOD'])
    df['TIME_PERIOD'] = df['TIME_PERIOD'].dt.year
    df = df.drop_duplicates(['REF_AREA', 'INDICATOR','SEX', 'TIME_PERIOD'], keep='last')

    # Pivot the dataframe
    df = df.pivot(index=['REF_AREA', 'COUNTRY', 'TIME_PERIOD', 'SEX'], columns='INDICATOR', values='value').reset_index()

    # Export
    df.columns = df.columns.str.replace('-','_')
    
    new_file = rf'{data_raw}\UNICEF_api_{date}.dta'
    df.to_stata(new_file, write_index=False, variable_labels=labels_dict)
    print(f"UNICEF API access finished. {new_file} was created.")