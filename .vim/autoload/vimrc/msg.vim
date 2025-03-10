vim9script

export def Error(msg: string): void
  echohl ErrorMsg
  for m in msg->split("\n")
    echomsg m
  endfor
  echohl None
enddef

export def Warn(msg: string): void
  echohl WarningMsg
  for m in msg->split("\n")
    echomsg m
  endfor
  echohl None
enddef

#defcompile
# vim: set et ts=2 sts=2 sw=2:
