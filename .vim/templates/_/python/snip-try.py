try:
	1/0{{_cursor_}}
except Exception:
	import traceback
	print(traceback.format_exc())
	#outputDebugString(traceback.format_exc())
finally:
	...
