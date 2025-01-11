def outputDebugString(*args):
    strs = [str(a) for a in args]
    #import inspect; cf = inspect.currentframe(); strs.insert(0, f"{cf.f_back.f_code.co_filename}:{cf.f_back.f_lineno}:")
    import ctypes
    W32OutputDebugString = ctypes.windll.kernel32.OutputDebugStringW
    s = " ".join(strs)
    #print(s)
    return W32OutputDebugString(s)

outputDebugString({{_cursor_}})
