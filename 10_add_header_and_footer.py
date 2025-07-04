import argparse

try:
    from sfi import Macro

    root = Macro.getGlobal("root")
    data_raw = Macro.getGlobal("data_raw")
    data_processed = Macro.getGlobal("data_processed")
    data_output = Macro.getGlobal("data_output")
    excels = Macro.getGlobal("excels")
    date = Macro.getGlobal("date")  # Date when the full process is run
    extra = Macro.getGlobal(
        "extra"
    )  # Placeholder for testing, just add "_test" or something like that to avoid overwrite db

except:
    root = r"D:\World Bank\Data-Portal-Brief-Generator"
    # portal = r"C:\Users\llohi\OneDrive - Universidad Torcuato Di Tella\WB\Data-Portal-Brief-Generator"
    data_raw = rf"{root}\Data\Data_Raw"
    data_processed = rf"{root}\Data\Data_Processed"
    data_output = rf"{root}\Data\Data_Output"
    extra = ""

sources = rf"{root}\Sources"
briefs = rf"{root}\Briefs"
excels = rf"{root}\Datasheets"

import os
import pandas as pd
from tqdm import tqdm
import fitz 

# Parse args to ensure if it 1 page or two pages
parser = argparse.ArgumentParser(description="Add header and footer to PDF")
parser.add_argument("--two-pages", action="store_true", help="Indicate if the PDF has two pages")
args = parser.parse_args()
two_pages = args.two_pages

if two_pages:
    footer_path = [
        os.path.join(sources, "Footer Images", "p1 footer.png"),
        os.path.join(sources, "Footer Images", "p2 footer.png")
    ]
    
else:
    footer_path = [os.path.join(sources, "Footer Images", "Footer - QR HC Data Portal.png")]

def fix_dataportal_country_names(name):
    ''' IT guys changed some of the briefs original names. This function transforms the original names to the new ones. '''
    
    # Democratic rep of congo	Congo,-Dem.-Rep.
    # Republic of Congo	Congo,-Rep.
    # Cote d'ivoire	Cote-d'Ivoire
    # The-Gambia	Gambia,-The
    # Hong Kong	Hong-Kong-SAR,-China
    # Iran	Iran,-Islamic-Rep.
    # Korea rep	Korea,-Rep.
    # Lao	Lao-PDR
    # Macao	Macao-SAR,-China
    # Fed states of micronesia	Micronesia,-Fed.-Sts.
    # Kitts and nevis	St.-Kitts-and-Nevis
    # St lucia	St.-Lucia
    # St vincent and the grenadines	St.-Vincent-and-the-Grenadines
    # Turkiye	Turkiye
    # Vietnam	Viet-Nam
    # Yemen 	Yemen,-Rep.
    
    # Remove .pdf from the name
    name = name.strip()
    
    if name == "Democratic Republic of Congo":
        return "Congo,-Dem.-Rep."
    elif name == "Republic of Congo":
        return "Congo,-Rep."
    elif name == "Côte d’Ivoire":
        return "Cote-d'Ivoire"
    elif name == "The Gambia":
        return "Gambia,-The"
    elif name == "Hong Kong":
        return "Hong Kong SAR, China"
    elif name == "Islamic Republic of Iran":
        return "Iran,-Islamic-Rep."
    elif name == "Republic of Korea":
        return "Korea,-Rep."
    elif name == "Lao People's Democratic Republic":
        return "Lao-PDR"
    elif name == "Macao SAR, China":
        return "Macao-SAR,-China"
    elif name == "Federated States of Micronesia":
        return "Micronesia,-Fed.-Sts."
    elif name == "St. Kitts and Nevis":
        return "St.-Kitts-and-Nevis"
    elif name == "St. Lucia":
        return "St.-Lucia"
    elif name == "St. Vincent and the Grenadines":
        return "St.-Vincent-and-the-Grenadines"
    elif name == "Türkiye":
        return "Turkiye"
    elif name == "Vietnam":
        return "Viet-Nam"
    elif name == "Republic of Yemen":
        return "Yemen,-Rep."
    else:
        return name

def list_files_in_directory(folder_path):
    file_list = []
    for root, _, files in os.walk(folder_path):
        for file in files:
            file_list.append(os.path.join(root, file))
    return file_list

def add_header_and_footer(doc_path, header_path, out_path, two_pages=False):

    # Open the existing PDF
    doc = fitz.open(doc_path)
    
    if two_pages:
        page_numbers = range(0, 2)
    else:
        page_numbers = [0]
    
    for page_number in page_numbers:

        # Get the dimensions of the image
        header = fitz.open(header_path[page_number])
        header_width, header_height = header[0].rect.width, header[0].rect.height
        header.close()

        footer = fitz.open(footer_path[page_number])
        footer_width, footer_height = footer[0].rect.width, footer[0].rect.height
        footer.close()
        
        page = doc[page_number]
        # Get the page dimensions
        page_width = page.rect.width
        page_height = page.rect.height

        # Calculate the rectangle where the image will be placed
        # This example scales the image to fit the width of the page
        header_rect = fitz.Rect(
            0,  # x0: left side of the page
            0,  # y0: top of the page
            page_width,  # x1: right side of the page
            header_height * (page_width / header_width)  # y1: maintain aspect ratio
        )
        footer_rect = fitz.Rect(
            0,  # x0: left side of the page
            page_height - footer_height * (page_width / footer_width),  # y0: bottom
            page_width,  # x1: right side of the page
            page_height  # y1: maintain aspect ratio
        )

        # Insert the image into the page
        page.insert_image(header_rect, filename=header_path[page_number])
        page.insert_image(footer_rect, filename=footer_path[page_number])

    # Save the modified PDF to a new file
    doc.ez_save(out_path)


df = pd.read_stata(rf"{data_output}\ordered_text.dta")
df = df.sort_values(by=["wbregion", "wbcode"])
df = df[df.wbcode.isin(["KEN"])]

os.makedirs(rf"{briefs}\For Print", exist_ok=True)
headers = list_files_in_directory(rf"{sources}\\Header Images\\Headers pngs")
for country_data in tqdm(df[["wbcode", "wbcountryname", "wbregion"]].itertuples(), total=df.shape[0]):
    try:
        wbcode = country_data[1]
        wbcountryname = country_data[2]
        wbregion = country_data[3]

        if wbcode == "BIH":
            wbcode = "BIS"

        # try:
        brief_path = rf"{briefs}\{wbcountryname}\{wbcountryname}{extra}.pdf"
        header_path = [header for header in headers if f"HCCB-{wbcode}" in header]
        if two_pages is False:
            header_path = [header_path[0]]
            
        out_folder = rf"{briefs}\For print\{wbregion}"
        os.makedirs(out_folder, exist_ok=True)
        outname = fix_dataportal_country_names(wbcountryname)
        out_path = rf"{out_folder}\{outname}{extra}.pdf"

        add_header_and_footer(brief_path, header_path, out_path, two_pages=two_pages)

    except Exception as exception:
        print(f"Error with {wbcode}: {exception}")