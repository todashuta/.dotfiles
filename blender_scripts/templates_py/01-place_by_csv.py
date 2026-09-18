# エクスプローラーで Ctrl-Shift-C でCSVファイルのパスをコピーして
# ''' と ''' の間の行に貼り付ける（前後の"もそのままでOK）

FILEPATH = r'''
"C:\Users\user\path\to\file.csv"
'''.strip().strip('"')

COLLECTION_NAME = "Example Collection"

import bpy

def get_or_create_collection(name: str, parent=None):
    if name in bpy.data.collections:
        collection = bpy.data.collections[name]
    else:
        collection = bpy.data.collections.new(name)
        (parent or bpy.context.scene.collection).children.link(collection)
    return collection

def main(filepath, collection_name):
    target_collection = get_or_create_collection(collection_name)
    import csv
    with open(filepath, encoding="utf-8", newline="") as f:
        reader = csv.DictReader(f)
        for row in reader:
            x = float(row["x"]) # FIXME
            y = float(row["y"]) # FIXME
            name = row["example_id"] # FIXME

            obj = bpy.data.objects.new(name, None) # new empty
            target_collection.objects.link(obj)
            obj.location.x = x
            obj.location.y = y
            obj.location.z = 0
            #obj.empty_display_type = "ARROWS"
            #obj.show_name = True

if __name__ == "__main__":
    main(FILEPATH, COLLECTION_NAME)
