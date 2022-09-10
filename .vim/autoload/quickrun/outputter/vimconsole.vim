let s:outputter = {
\   'config': {
\     'open_on_finish': 1,
\   }
\ }

function s:outputter.validate() abort
  if len(globpath(&rtp, 'autoload/vimconsole.vim', 0, 1)) == 0
    throw 'Needs rbtnn/vimconsole.vim plugin.'
  endif
endfunction

function s:outputter.output(data, session) abort
  call vimconsole#log(a:data)
endfunction

function s:outputter.finish(session) abort
  call vimconsole#redraw()
  if self.config.open_on_finish
    call vimconsole#winopen()
  endif
endfunction

function quickrun#outputter#vimconsole#new() abort
  return deepcopy(s:outputter)
endfunction
