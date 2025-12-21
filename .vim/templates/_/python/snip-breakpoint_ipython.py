def breakpoint():
    import sys
    from IPython.terminal.debugger import set_trace
    set_trace(sys._getframe(1))
{{_cursor_}}
