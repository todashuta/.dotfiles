vim9script

import "./msg.vim"

export def ToggleQuickfixWindow(): void
  const numwin = winnr('$')
  cclose
  if numwin == winnr('$')
    botright cwindow
    wincmd p
  endif
enddef

export def QFPrevious(): void
  if getwininfo(win_getid())[0].quickfix
    msg.Warn('QFPrevious NOOP')
    return
  endif
  const xs = filter(copy(getwininfo()), 'v:val.tabnr == tabpagenr()')
  if len(filter(copy(xs), 'v:val.loclist')) > 0
    try
      lprevious
      normal! zz
    catch /^Vim\%((\a\+)\)\=:E553:/
      msg.Warn('No more items')
    endtry
  elseif len(filter(copy(xs), 'v:val.quickfix')) > 0
    try
      cprevious
      normal! zz
    catch /^Vim\%((\a\+)\)\=:E553:/
      msg.Warn('No more items')
    endtry
  else
    msg.Warn('QFPrevious NOOP')
  endif
enddef

export def QFNext(): void
  if getwininfo(win_getid())[0].quickfix
    msg.Warn('QFNext NOOP')
    return
  endif
  const xs = filter(copy(getwininfo()), 'v:val.tabnr == tabpagenr()')
  if len(filter(copy(xs), 'v:val.loclist')) > 0
    try
      lnext
      normal! zz
    catch /^Vim\%((\a\+)\)\=:E553:/
      msg.Warn('No more items')
    endtry
  elseif len(filter(copy(xs), 'v:val.quickfix')) > 0
    try
      cnext
      normal! zz
    catch /^Vim\%((\a\+)\)\=:E553:/
      msg.Warn('No more items')
    endtry
  else
    msg.Warn('QFNext NOOP')
  endif
enddef

#defcompile
# vim: set et ts=2 sts=2 sw=2:
