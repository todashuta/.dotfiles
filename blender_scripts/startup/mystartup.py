print('Hello!', __file__, 'loaded')


# See: https://docs.python.org/ja/3/library/sys.html#sys.displayhook
def _displayhook(value):
    if value is None:
        return
    import builtins, mathutils
    builtins._ = None
    text = str(value) if isinstance(value, mathutils.Matrix) else repr(value)
    import sys
    try:
        sys.stdout.write(text)
    except UnicodeEncodeError:
        bytes = text.encode(sys.stdout.encoding, 'backslashreplace')
        if hasattr(sys.stdout, 'buffer'):
            sys.stdout.buffer.write(bytes)
        else:
            text = bytes.decode(sys.stdout.encoding, 'strict')
            sys.stdout.write(text)
    sys.stdout.write("\n")
    builtins._ = value
import sys as _sys
_save_displayhook = _sys.displayhook
#_sys.displayhook = _displayhook


def set_my_displayhook():
    _sys.displayhook = _displayhook


def restore_displayhook():
    _sys.displayhook = _save_displayhook


def register():
    pass


def unregister():
    pass
