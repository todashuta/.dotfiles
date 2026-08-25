vim9script

import "./msg.vim"
import "./qf.vim"

export def ToggleLoclistWindow(keepcursor = true): void
  var numwin = winnr('$')
  lclose
  if numwin == winnr('$')
    numwin = winnr('$')
    silent! botright lwindow
    if numwin != winnr('$')
      if keepcursor
        wincmd p
      endif
    else
      msg.Warn('no location-list items')
    endif
  endif
enddef

export def ToggleQuickfixWindow(keepcursor = true): void
  var numwin = winnr('$')
  cclose
  if numwin == winnr('$')
    numwin = winnr('$')
    botright cwindow
    if numwin != winnr('$')
      if keepcursor
        wincmd p
      endif
    else
      msg.Warn('no quickfix items')
    endif
  endif
enddef

export def QfPrevious(fallback: string = ''): string
  if qf.LoclistOpened()
    return "\<Cmd>lprevious\<CR>zz"
  elseif qf.QflistOpened()
    return "\<Cmd>cprevious\<CR>zz"
  else
    return fallback
  endif
enddef

export def QfNext(fallback: string = ''): string
  if qf.LoclistOpened()
    return "\<Cmd>lnext\<CR>zz"
  elseif qf.QflistOpened()
    return "\<Cmd>cnext\<CR>zz"
  else
    return fallback
  endif
enddef

#defcompile
# vim: set et ts=2 sts=2 sw=2:
