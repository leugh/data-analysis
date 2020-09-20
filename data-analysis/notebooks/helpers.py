def get_table_columns(result):
    table_columns = result['header']
    return table_columns


import re
def slugify(value):
    """
    Normalize string name to be able to save to disk
    
    Based on: https://stackoverflow.com/questions/295135/turn-a-string-into-a-valid-filename
    """
    value = re.sub('[^\w\s-]', '', value).strip().lower()
    value = re.sub('[^\w\s-]', '', value).strip().lower()
    value = value.replace(' ', '_')
    value = value.replace('-', '_')
    return value


import pandas as pd
def get_table_name_for_table_id(table_id):
    # holds the table_id in one column and the table_name in the other column
    mapping_table_id_table_name = pd.read_csv(
        "../data/01_raw/wiki-sql/schema_infos/mapping_table_id_table_name.csv"
        ,  sep = '\t'
    )
    
    
    # get the table_name using table_id
    table_name = list(mapping_table_id_table_name[
        mapping_table_id_table_name["table_id"]==table_id
    ]["table_name"])[0]
    
    
    return table_name



def extract_table_id_from_result(result):
    table_id = result["id"]
    return table_id