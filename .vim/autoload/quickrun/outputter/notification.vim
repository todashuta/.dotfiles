let s:outputter = {}

function s:outputter.validate() abort
  if len(globpath(&rtp, 'autoload/notification.vim', 0, 1)) == 0
    throw 'Needs mattn/vim-notification plugin.'
  endif
endfunction

function s:outputter.output(data, session) abort
  call notification#show(a:data)
endfunction

function quickrun#outputter#notification#new() abort
  return deepcopy(s:outputter)
endfunction
