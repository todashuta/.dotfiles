TEXT_BLOCK_NAME = "output.txt{{_cursor_}}"
textblock = bpy.data.texts.get(TEXT_BLOCK_NAME) or bpy.data.texts.new(TEXT_BLOCK_NAME)
#textblock.clear()
textblock.write("hello world!\n")
