
import pandasdmx as sdmx
import pandas as pd

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

    print("andó")