# Usage:
# 事前にgltf出力の設定を保存しておくこと

import bpy
context = bpy.context
objects = context.selected_objects[:]
settings = context.scene["glTF2ExportSettings"].to_dict()

for ob in objects:
	bpy.ops.object.select_all(action="DESELECT")
	ob.select_set(True)
	filename = bpy.path.abspath("//glb_output") + "/" + ob.name # TODO ファイル名に使えない文字の処理
	bpy.ops.export_scene.gltf(filepath=filename, **settings)
	#print(filename)
