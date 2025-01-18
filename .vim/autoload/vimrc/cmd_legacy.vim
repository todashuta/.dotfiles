function! vimrc#cmd_legacy#Uptime(vim_starttime, system) abort
  " uptime for windows
  let up = libcallnr('kernel32', 'GetTickCount64', '') / 1000
  let up = up - (a:system ? 0 : a:vim_starttime)
  let parts = []
  let [days, up] = [up / 86400, up % 86400]
  if days > 0
    call add(parts, printf('%d day%s', days, (days > 1 ? 's' : '')))
  endif
  let [hours, up] = [up / 3600, up % 3600]
  if hours > 0
    call add(parts, printf('%d hour%s', hours, (hours > 1 ? 's' : '')))
  endif
  let [minutes, up] = [up / 60, up % 60]
  if minutes > 0
    call add(parts, printf('%d minute%s', minutes, (minutes > 1 ? 's' : '')))
  endif
  if up > 0 || empty(parts)
    call add(parts, printf('%d seconds', up))
  endif
  echo printf('%s Uptime: %s.', (a:system ? 'System' : 'Vim'), join(parts, ', '))
endfunction

" vim: set et ts=2 sts=2 sw=2:
