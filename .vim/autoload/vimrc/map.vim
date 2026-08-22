vim9script

import "./msg.vim"

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

def LoclistOpened(): bool
  return getwininfo()->filter((_, v) => v.tabnr == tabpagenr() && v.loclist)->len() > 0
enddef

def QflistOpened(): bool
  return getwininfo()->filter((_, v) => v.tabnr == tabpagenr() && v.quickfix && !v.loclist)->len() > 0
enddef

export def QFPrevious(): string
  if LoclistOpened()
    return ":\<C-u>lprevious\<CR>zz"
  elseif QflistOpened()
    return ":\<C-u>cprevious\<CR>zz"
  else
    return ''
  endif
enddef

export def QFNext(): string
  if LoclistOpened()
    return ":\<C-u>lnext\<CR>zz"
  elseif QflistOpened()
    return ":\<C-u>cnext\<CR>zz"
  else
    return ''
  endif
enddef

#defcompile
# vim: set et ts=2 sts=2 sw=2:
