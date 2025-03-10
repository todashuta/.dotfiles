vim9script

import "./msg.vim"

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

export def MyPrevimOpen()
  const previm_installed = exists(':PrevimOpen') == 2
  if !previm_installed
    msg.Error('previm not installed')
    return
  endif
  if has('win32')
    g:previm_open_cmd = 'echo'
    execute 'PrevimOpen'
    job_start('cmd /c start index.html', { 'cwd': previm#make_preview_file_path('') })
  elseif has('osxdarwin')
    g:previm_open_cmd = 'open -a "Google Chrome"'
    execute 'PrevimOpen'
  else
    execute 'PrevimOpen'
  else
  endif
enddef

export def FilterEntireFile(cmd: string, trim_trailing_cr = false): void
  var result = systemlist(cmd, getline(1, '$'))
  if trim_trailing_cr
    result->map((_, v) => v->trim("\r", 2))
  endif
  if v:shell_error != 0
    for l in result
      msg.Error(l)
    endfor
    return
  endif
  const pos = getpos('.')
  deletebufline('%', 1, '$')
  setline(1, result)
  setpos('.', pos)
enddef

#defcompile
# vim: set et ts=2 sts=2 sw=2:
