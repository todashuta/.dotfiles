vim9script

def EchohlNone(): void
  echohl None
enddef

export def Error(msg: string): void
  echohl ErrorMsg
  defer EchohlNone()
  for m in msg->split("\n")
    echomsg m
  endfor
enddef

export def Warn(msg: string): void
  echohl WarningMsg
  defer EchohlNone()
  for m in msg->split("\n")
    echomsg m
  endfor
enddef

#defcompile
# vim: set et ts=2 sts=2 sw=2:
