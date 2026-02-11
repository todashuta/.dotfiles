vim9script

import "./msg.vim"

export def MinpacInstall(name: string, option = {}): void
  const opt = extend(copy(option), {type: 'opt'}, 'keep')
  packadd minpac
  minpac#init()
  minpac#add(name, opt)
  minpac#update('', {'do': 'call minpac#status()'})
enddef

export def MyDiffOrigToggle(): void
  const mydifforig_wins = filter(range(1, winnr('$')),
      (_, v) => getbufvar(winbufnr(v), 'mydifforigbuf', 0))
  if !empty(mydifforig_wins)
    diffoff!
    for w in mydifforig_wins
      execute $'bwipeout {winbufnr(w)}'
    endfor
  else
    vertical new
    setlocal buftype=nofile
    b:mydifforigbuf = 1
    execute $'ownsyntax {getbufvar(bufname("#"), "&filetype")}'
    read ++edit %%
    :0delete _
    diffthis
    wincmd p
    diffthis
  endif
enddef

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

export def Uptime(vim_starttime: number, system: bool): void
  var up = libcallnr('kernel32', 'GetTickCount64', '') / 1000
  up = up - (system ? 0 : vim_starttime)
  var parts = []
  const days = up / 86400
  up = up % 86400
  if days > 0
    parts->add(printf('%d day%s', days, (days > 1 ? 's' : '')))
  endif
  const hours = up / 3600
  up = up % 3600
  if hours > 0
    parts->add(printf('%d hour%s', hours, (hours > 1 ? 's' : '')))
  endif
  const minutes = up / 60
  up = up % 60
  if minutes > 0
    parts->add(printf('%d minute%s', minutes, (minutes > 1 ? 's' : '')))
  endif
  if up > 0 || empty(parts)
    parts->add(printf('%d seconds', up))
  endif
  echo printf('%s Uptime: %s.', (system ? 'System' : 'Vim'), parts->join(', '))
enddef

export def MyPrevimOpen(): void
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
  elseif has('linux') && executable('firefox')
    #g:previm_open_cmd = 'xdg-open'
    g:previm_open_cmd = 'firefox'
    execute 'PrevimOpen'
  else
    msg.Error('[MyPrevimOpen] Unsupported environment')
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
  defer setpos('.', getpos('.'))
  deletebufline('%', 1, '$')
  setline(1, result)
enddef

export def JsonFormat(python_command: string, ensure_ascii: bool, indent_count: number): void
  const cmd = join([
    (python_command ?? 'python3'),
    '-m json.tool',
    (ensure_ascii ? null_string : '--no-ensure-ascii'),
    (indent_count > 0 ? $'--indent={indent_count}' : '--tab'),
  ])
  FilterEntireFile(cmd, has('win32'))
enddef

export def Update_SSH_AUTH_SOCK(): void
  if empty($TMUX)
    return
  endif
  const res = system('/bin/sh -c "tmux showenv SSH_AUTH_SOCK 2>/dev/null"')
  const sock_path = substitute(trim(res), '^SSH_AUTH_SOCK=', '', '')
  if !empty(glob(sock_path))
    $SSH_AUTH_SOCK = sock_path
  else
    unlet $SSH_AUTH_SOCK
  endif
  echo $'SSH_AUTH_SOCK={$SSH_AUTH_SOCK}'
enddef

#defcompile
# vim: set et ts=2 sts=2 sw=2:
