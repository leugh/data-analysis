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


def get_table_id(result):
    table_id = result["id"]
    return table_id