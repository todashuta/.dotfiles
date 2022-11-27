def outputDebugString(obj):
    prefix = ""
    #import inspect; cf = inspect.currentframe(); prefix = f"{cf.f_back.f_code.co_filename}:{cf.f_back.f_lineno}: "
    import ctypes
    W32OutputDebugString = ctypes.windll.kernel32.OutputDebugStringW
    from pprint import pformat, pprint
    #pprint(obj)
    return W32OutputDebugString(prefix+pformat(obj))

outputDebugString({{_cursor_}}
