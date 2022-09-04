let s:hook = {
\   'config': {
\     'enable': 0,
\     'format': "QuickRun\ntime: %g",
\   },
\ }

function s:hook.init(session) abort
endfunction

function s:hook.on_ready(session, context) abort
  let self._start = reltime()
endfunction

function s:hook.on_finish(session, context) abort
  let self._end = reltime()
  let time = str2float(reltimestr(reltime(self._start, self._end)))
  let text = printf(self.config.format, time)
  call notification#show(text)
endfunction

function quickrun#hook#time_notification#new() abort
  return deepcopy(s:hook)
endfunction
