# FIXME: This code requires like 20GB of RAM to run, so it's not really usable by anyone else. I'll have to find a way to make it more efficient.

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

footer_path = os.path.join(sources, "Footer Images", "Footer - QR HC Data Portal.png")

def list_files_in_directory(folder_path):
    file_list = []
    for root, _, files in os.walk(folder_path):
        for file in files:
            file_list.append(os.path.join(root, file))
    return file_list

def add_header_and_footer(doc_path, header_path, out_path):

    # Open the existing PDF
    doc = fitz.open(doc_path)

    # Get the dimensions of the image
    header = fitz.open(header_path)
    header_width, header_height = header[0].rect.width, header[0].rect.height
    header.close()

    footer = fitz.open(footer_path)
    footer_width, footer_height = footer[0].rect.width, footer[0].rect.height
    footer.close()


    page = doc[0]
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
    page.insert_image(header_rect, filename=header_path)
    page.insert_image(footer_rect, filename=footer_path)

    # Save the modified PDF to a new file
    doc.ez_save(out_path)


df = pd.read_stata(rf"{data_output}\ordered_text.dta")
df = df.sort_values(by=["wbregion", "wbcode"])
# df = df[df.wbcode.isin(["AUS", "ARG", "AFG", "ETH", "CAN", "JPN"])]

## REMOVE LATER
os.makedirs(rf"{briefs}\For Print", exist_ok=True)
done = os.listdir(rf"{root}\Briefs\For Print")
done_ctrys = [ctry.split(".")[0] for ctry in done]
#####

headers = list_files_in_directory(rf"{sources}\\Header Images\\Headers pngs")
images = {k: [] for k in df.wbregion.unique()}
for country_data in tqdm(df[["wbcode", "wbcountryname", "wbregion"]].itertuples(), total=df.shape[0]):
    # try:
    wbcode = country_data[1]
    wbcountryname = country_data[2]
    wbregion = country_data[3]


    if wbcountryname in done_ctrys:
        continue

    if wbcode == "BIH":
        wbcode = "BIS"

    brief_path = rf"{briefs}\{wbcountryname}\{wbcountryname}{extra}.pdf"
    header_path = [header for header in headers if f"1-HCCB-{wbcode}" in header][0]
    out_folder = rf"{briefs}\For print\{wbregion}"
    os.makedirs(out_folder, exist_ok=True)
    out_path = rf"{out_folder}\{wbcountryname}{extra}.pdf"

    add_header_and_footer(brief_path, header_path, out_path)

    # except Exception as exception:
    #     print(f"Error with {wbcode}: {exception}")