vim9script

export def OperatorUserTemplate(): void
  const buffers = filter(range(1, bufnr('$')), (_, v) => getbufvar(v, "myoperatorusertemplatebuf", 0))
  if empty(buffers)
    tabnew
    setfiletype vim
    b:myoperatorusertemplatebuf = 1
    Template operator_user
  else
    execute 'buffer' buffers[0]
  endif
enddef

export def ResizeInteractive(): void
  if winnr('$') == 1
    return
  endif

  while true
    const c = getcharstr()
    if     c == "\<Up>"    | wincmd +
    elseif c == "\<Down>"  | wincmd -
    elseif c == "\<Left>"  | wincmd <
    elseif c == "\<Right>" | wincmd >
    else                   | break
    endif
    redraw
  endwhile
  redraw
enddef

export def Uptime(vim_starttime: number, system: bool)
  var up = libcallnr('kernel32', 'GetTickCount64', '') / 1000
  up = up - (system ? 0 : vim_starttime)
  var parts = []
  const days = up / 86400
  up = up % 86400
  if days > 0
    call add(parts, printf('%d day%s', days, (days > 1 ? 's' : '')))
  endif
  const hours = up / 3600
  up = up % 3600
  if hours > 0
    call add(parts, printf('%d hour%s', hours, (hours > 1 ? 's' : '')))
  endif
  const minutes = up / 60
  up = up % 60
  if minutes > 0
    call add(parts, printf('%d minute%s', minutes, (minutes > 1 ? 's' : '')))
  endif
  if up > 0 || empty(parts)
    call add(parts, printf('%d seconds', up))
  endif
  echo printf('%s Uptime: %s.', (system ? 'System' : 'Vim'), join(parts, ', '))
enddef

#defcompile
# vim: set et ts=2 sts=2 sw=2:
