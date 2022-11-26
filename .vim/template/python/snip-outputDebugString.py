def outputDebugString(obj):
    import ctypes
    W32OutputDebugString = ctypes.windll.kernel32.OutputDebugStringW
    from pprint import pformat, pprint
    #pprint(obj)
    return W32OutputDebugString(pformat(obj))
{{_cursor_}}
