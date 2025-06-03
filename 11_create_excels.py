### Configuration

import pandas as pd
from tqdm import tqdm
import xlwings as xw

try:
    from sfi import Macro

    portal = Macro.getGlobal("portal")
    data_raw = Macro.getGlobal("data_raw")
    data_processed = Macro.getGlobal("data_processed")
    excels = Macro.getGlobal("excels")
    date = Macro.getGlobal("date")  # Date when the full process is run
    extra = Macro.getGlobal(
        "extra"
    )  # Placeholder for testing, just add "_test" or something like that to avoid overwrite db

except:
    portal = r"D:\World Bank\Data-Portal-Brief-Generator"
    # portal = r"C:\Users\llohi\OneDrive - Universidad Torcuato Di Tella\WB\Data-Portal-Brief-Generator"
    data_raw = rf"{portal}\Data\Data_Raw"
    data_processed = rf"{portal}\Data\Data_Processed"
    data_output = rf"{portal}\Data\Data_Output"
    excels = rf"{portal}\Datasheets"
    date = "26_jul_2024"

###### Read complete_series ######
print("Loading data, this may take a while...")
df = pd.read_stata(rf"{data_output}/complete_series_wmd_{date}.dta")
df = df[
    df["rank"] > 0
]  # Drop indicators that are already included in the HCI / are not ranked

## Format complete_series ##
# Make stage_life ordered categorical
ordered_categories = [
    "Prenatal and Early Childhood",
    "School-aged Children",
    "Youth",
    "Adulthood and Elderly",
    "Across all stages",
]
df.stage_life = pd.Categorical(
    df.stage_life, categories=ordered_categories, ordered=True
)
# Replace gender with sheetnames
df.gender = df.gender.replace(
    {"Total": "HCCI", "Male": "HCCI - Male", "Female": "HCCI - Female"}
)

###### Read metadata ######
metadata = pd.read_stata(rf"{data_processed}\metadata_processed.dta")
metadata = metadata[
    metadata["rank"] > 0
]  # Drop indicators that are already included in the HCI

###### Read footnotes ######
footnotes = pd.read_excel(
    rf"{data_raw}\Country codes & metadata\Footnotes.xlsx", sheet_name="Sheet2"
)
footnotes = footnotes.set_index("wbcode")

## Format metadata ##
sources = metadata[
    [
        "stage_life",
        "dimension",
        "name",
        "description",
        "source",
        "code",
        "download_link",
    ]
]
sources.columns = [
    "Stage of life",
    "Dimension",
    "Human Capital Complementary Indicator Name",
    "Definition",
    "Source",
    "Source code (when available)",
    "Source URL",
]
sources = sources.drop_duplicates(subset=["Human Capital Complementary Indicator Name"])
sources["Dimension"] = sources["Dimension"].replace("", "Across all dimensions")
sources["Stage of life"] = sources["Stage of life"].replace("", "Across all stages")
sources["Stage of life"] = pd.Categorical(
    sources["Stage of life"], categories=ordered_categories, ordered=True
)
sources = sources.sort_values(
    ["Stage of life", "Dimension", "Human Capital Complementary Indicator Name"]
)
sources = sources.reset_index(drop=True)

print("Data loaded succesfully")

###### EXCEL GENERATOR ######


def drop_rows_until_not_nan(df):
    first_valid_row = df.first_valid_index()
    if first_valid_row is None:
        return pd.DataFrame()

    idx = df.index.get_loc(first_valid_row)
    df = df.iloc[idx:]
    return df.dropna(how="all")


# Array of countries: array of tuples (wbcode, countryname)
country_list = [
    "AUS",
    "BRN",
    "CHN",
    "FJI",
    "FSM",
    "HKG",
    "IDN",
    "JPN",
    "KHM",
    "KIR",
    "KOR",
    "LAO",
    "MAC",
    "MHL",
    "MMR",
    "MNG",
    "MYS",
    "NRU",
    "NZL",
    "PHL",
    "PLW",
    "PNG",
    "SGP",
    "SLB",
    "THA",
    "TLS",
    "TON",
    "TUV",
    "VNM",
    "VUT",
    "WSM",
    "ALB",
    "ARM",
    "AUT",
    "AZE",
    "BEL",
    "BGR",
    "BIH",
    "BLR",
    "CHE",
    "CYP",
    "CZE",
    "DEU",
    "DNK",
    "ESP",
    "EST",
    "FIN",
    "FRA",
    "GBR",
    "GEO",
    "GRC",
    "HRV",
    "HUN",
    "IRL",
    "ISL",
    "ITA",
    "KAZ",
    "KGZ",
    "LTU",
    "LUX",
    "LVA",
    "MDA",
    "MKD",
    "MNE",
    "NLD",
    "NOR",
    "POL",
    "PRT",
    "ROU",
    "RUS",
    "SRB",
    "SVK",
    "SVN",
    "SWE",
    "TJK",
    "TUR",
    "UKR",
    "UZB",
    "XKX",
    "ARG",
    "ATG",
    "BRA",
    "CHL",
    "COL",
    "CRI",
    "DMA",
    "DOM",
    "ECU",
    "GRD",
    "GTM",
    "GUY",
    "HND",
    "HTI",
    "JAM",
    "KNA",
    "LCA",
    "MEX",
    "NIC",
    "PAN",
    "PER",
    "PRY",
    "SLV",
    "TTO",
    "URY",
    "VCT",
    "ARE",
    "BHR",
    "DZA",
    "EGY",
    "IRN",
    "IRQ",
    "ISR",
    "JOR",
    "KWT",
    "LBN",
    "MAR",
    "MLT",
    "OMN",
    "PSE",
    "QAT",
    "SAU",
    "TUN",
    "YEM",
    "CAN",
    "USA",
    "AFG",
    "BGD",
    "BTN",
    "IND",
    "LKA",
    "NPL",
    "PAK",
    "AGO",
    "BDI",
    "BEN",
    "BFA",
    "BWA",
    "CAF",
    "CIV",
    "CMR",
    "COD",
    "COG",
    "COM",
    "ETH",
    "GAB",
    "GHA",
    "GIN",
    "GMB",
    "KEN",
    "LBR",
    "LSO",
    "MDG",
    "MLI",
    "MOZ",
    "MRT",
    "MUS",
    "MWI",
    "NAM",
    "NER",
    "NGA",
    "RWA",
    "SDN",
    "SEN",
    "SLE",
    "SSD",
    "SWZ",
    "SYC",
    "TCD",
    "TGO",
    "TZA",
    "UGA",
    "ZAF",
    "ZMB",
    "ZWE",
]
country_array = (
    df
    # [df.wbcode.isin(country_list)]
    [["wbcode", "wbcountryname"]]
    .drop_duplicates()
    .values
)

# Loop over every country and sheets
for wbcode, countryname in tqdm(country_array):
    hcci_dfs = {}  # Dictionary of dataframes for each sheet

    # Add the dataframes to the dictionary
    for gender in ["HCCI", "HCCI - Male", "HCCI - Female"]:
        country_df = df[(df.wbcode == wbcode) & (df.gender == gender)]
        country_df = country_df.drop_duplicates(subset=["year", "name"], keep="last")
        country_df = country_df.sort_values(by=["stage_life", "topic", "rank"])
        hcci = country_df.pivot(index="year", columns="name", values="value")
        # Format to strings
        hcci = hcci.dropna(how="all", axis=1)
        hcci = drop_rows_until_not_nan(hcci)
        hcci = hcci.round(1)
        hcci = hcci.fillna("-")
        hcci_dfs[gender] = hcci.reset_index()

    # Add the sources to the dictionary
    hcci_dfs["Sources"] = sources

    # Note: The only sheet that is not in the dictionary is the "Graphs" one, that we add at the end
    ## Write the excels and format them ##
    with pd.ExcelWriter(
        rf"{excels}/HCI_Data_September_2020_{wbcode}.xlsx", engine="xlsxwriter"
    ) as writer:
        workbook = writer.book
        # Set all diferent formats...
        sheet_format = workbook.add_format(
            {
                "bg_color": "#FFFFFF",
                "border": 0,
                # "align": "center",
                "valign": "vcenter",
            }
        )
        values_format = workbook.add_format(
            {
                "align": "center",
                "valign": "vcenter",
                "bg_color": "#FFFFFF",
                "border": 0,
            }
        )
        header_format = workbook.add_format(
            {
                "bold": True,
                "text_wrap": True,
                "align": "center",
                "valign": "vcenter",
                "bg_color": "#d9d9d9",
                "top": 2,  # border
                "bottom": 2,  # border
            }
        )
        sources_format = workbook.add_format(
            {
                "text_wrap": True,
                "align": "center",
                "valign": "vcenter",
                "bg_color": "#FFFFFF",
                "top": 1,
                "bottom": 1,
            }
        )
        index_format = workbook.add_format(
            {
                "align": "center",
                "valign": "vcenter",
                "bg_color": "#FFFFFF",
                "left": 2,  # border
                "right": 2,  # border
            }
        )
        box_format = workbook.add_format(
            {
                "border": 2,
                "bg_color": "#d9d9d9",
                "bold": True,
                "font_size": 12,
                "align": "center",
                "valign": "vcenter",
            }
        )
        footnote_format = workbook.add_format(
            {
                "bg_color": "#FFFFFF",
                "font_size": 12,
                "align": "left",
                "top": 2,
            }
        )
        superscript = workbook.add_format(
            {
                "bg_color": "#FFFFFF",
                "font_script": 1,
                "font_size": 12,
                "align": "left",
                "top": 2,
            }
        )

        title_format = workbook.add_format(
            {"align": "left", "bold": True, "font_size": 12, "bg_color": "#FFFFFF"}
        )
        text_format = workbook.add_format(
            {"align": "left", "font_size": 11, "bg_color": "#FFFFFF"}
        )

        for sheetname in ["HCCI", "HCCI - Male", "HCCI - Female", "Sources"]:
            ### Write excel with pandas and set worksheet and main parameters
            startrow = 6
            startcol = 1
            to_excel = hcci_dfs[sheetname]
            if to_excel.empty:
                print(f"\nEmpty dataframe for '{sheetname}' in {countryname}")
                continue  # If the dataframe is empty, skip it and do not create the sheet
            to_excel.to_excel(
                writer,
                sheet_name=sheetname,
                startrow=startrow,
                startcol=startcol,
                index=False,
            )

            # Params
            worksheet = writer.sheets[sheetname]
            number_of_cols = to_excel.shape[1]
            number_of_rows = to_excel.shape[0]
            first_excel_col = startcol
            last_excel_col = number_of_cols + first_excel_col
            first_excel_row = startrow
            last_excel_row = number_of_rows + first_excel_row

            ### Add title
            if sheetname == "Sources":
                title = f"Human Capital Complementary Indicators: Sources"
            elif (sheetname == "HCCI - Male") | (sheetname == "HCCI - Female"):
                gender = f'for {sheetname.split(" - ")[-1].lower()}s'  # for example: "for males"
                title = f"Human Capital Complementary Indicators: Trends {gender}"
            else:
                title = f"Human Capital Complementary Indicators: Trends"
            database_text = "Human Capital Project 2024 Data Portal"
            country_text = countryname
            worksheet.write(1, 2, title, title_format)
            worksheet.write(2, 2, f"Database: {database_text}", text_format)
            worksheet.write(3, 2, f"Country: {country_text}", text_format)

            ### Add WB logo
            worksheet.insert_image(
                "H1",
                rf"{portal}\Sources\WBG_logo.png",
                {"x_scale": 0.26, "y_scale": 0.26},
            )

            ### Format excel
            # Set background color of cells
            worksheet.set_column(
                0, number_of_cols + 10, 8.43, sheet_format
            )  # 8.43 is default width

            if sheetname == "Sources":
                # Center values inside table and set width of columns
                worksheet.set_column(first_excel_col, last_excel_col, 25, values_format)

                # Set wider width for name and definition columns
                worksheet.set_column(
                    first_excel_col + 2, first_excel_col + 2, 45, values_format
                )  # Name
                worksheet.set_column(
                    first_excel_col + 3, first_excel_col + 3, 60, values_format
                )  # definition
                worksheet.set_column(
                    last_excel_col - 1, last_excel_col - 1, 150, values_format
                )  # url

                # Overwrite both the value and the format of each header cell -- text_wrap only works with write...
                for col_num, col in enumerate(to_excel.columns):
                    worksheet.write(
                        first_excel_row, col_num + startcol, col, header_format
                    )
                    # Overwrite both the value and the format of each value cell
                    for row_num, value in enumerate(to_excel[col]):
                        worksheet.write(
                            first_excel_row + row_num + 1,
                            startcol + col_num,
                            to_excel.loc[row_num, col],
                            sources_format,
                        )

            else:
                # Center values inside table and set width of columns
                worksheet.set_column(first_excel_col, last_excel_col, 20, values_format)
                # Set borders of year column
                worksheet.set_column(first_excel_col, first_excel_col, 8, values_format)

                # Overwrite both the value and the format of each header cell -- text_wrap only works with write...
                relevant_cols = to_excel.columns.values[
                    1:
                ]  # Remove year from list of cols
                for col_num, value in enumerate(relevant_cols):
                    if sheetname == "HCCI - Male":
                        value = value.replace(", Male", "")
                    elif sheetname == "HCCI - Female":
                        value = value.replace(", Female", "")
                    worksheet.write(
                        first_excel_row, col_num + startcol + 1, value, header_format
                    )

                # Overwrite both the value and the format of each index cell
                for row_num, value in enumerate(to_excel["year"]):
                    worksheet.write(
                        row_num + startrow + 1, first_excel_col, value, index_format
                    )

                # Columna de año - vacia
                worksheet.write(first_excel_row, first_excel_col, "Year", box_format)

            # Set outside borders
            topFormat = workbook.add_format(
                {
                    "top": 2,
                    "bg_color": "#FFFFFF",
                }
            )
            leftFormat = workbook.add_format(
                {
                    "left": 2,
                    "bg_color": "#FFFFFF",
                }
            )
            rightFormat = workbook.add_format(
                {
                    "right": 2,
                    "bg_color": "#FFFFFF",
                }
            )

            for row in range(first_excel_row, last_excel_row + 1):
                if (row != first_excel_row) & (sheetname != "Sources"):
                    worksheet.set_row(row, 16, values_format)  # Also set height of rows
                elif sheetname == "Sources":
                    worksheet.write(
                        row, first_excel_col - 1, "", rightFormat
                    )  # right border of excel
                worksheet.write(
                    row, last_excel_col, "", leftFormat
                )  # right border of excel

            for col in range(first_excel_col, last_excel_col):
                worksheet.write(
                    last_excel_row + 1, col, "", topFormat
                )  # bottom border of excel

            if (sheetname == "HCCI") & (wbcode in footnotes.index):
                # Add footnote:
                worksheet.write_rich_string(
                    last_excel_row + 1,
                    first_excel_col,
                    superscript,
                    "1",
                    footnote_format,
                    f" {footnotes.loc[wbcode, 'footnote']}",
                    footnote_format,
                )

        # Graphs_HCCI sheet
        worksheet = workbook.add_worksheet("Graphs_HCCI")
        worksheet.set_column(0, 60, 8.43, sheet_format)  # 8.43 is default width
        worksheet.write(
            2, 1, "Human Capital Complementary Indicators (HCCI): Graphs", title_format
        )
        # worksheet.write(2, 16, "Human Capital Index (HCI): Graphs", title_format)

        ### Add Graphs as images
        worksheet.insert_image(
            "B5",
            rf"{portal}\Graphs\p2_{wbcode}_stages.jpg",
            {"x_scale": 0.25, "y_scale": 0.25},
        )
        # worksheet.insert_image(
        #     "Q5",
        #     rf"{portal}\Graphs\p1_{wbcode}_all.jpg",
        #     {"x_scale": 0.25, "y_scale": 0.25},
        # )

    # Add HCI sheets and protect excel
    try:
        source = (
            rf"{portal}\Data\HCI_Data\HCI_Data_September_2020_{wbcode}_original.xlsx"
        )
        destination = rf"{excels}\HCI-Data-September-2020-{wbcode}.xlsx"

        wb_source = xw.Book(source)
        wb_dest = xw.Book(destination)

        for sheet in range(2, 15):
            ws_source = wb_source.sheets(sheet)
            ws_source.api.Copy(Before=wb_dest.sheets(sheet - 1).api)

        # Put the first page at last so the excel starts with the index
        ws_source = wb_source.sheets(1)
        ws_source.api.Copy(Before=wb_dest.sheets(1).api)

        # Protect sheets
        for sheet in wb_dest.sheets:
            sheet.api.Protect()

        wb_dest.save()
        wb_dest.app.quit()

    except:
        print(f"Error while adding HCI sheets to {wbcode}")
        try:
            wb_source.app.quit()
        except:
            pass
