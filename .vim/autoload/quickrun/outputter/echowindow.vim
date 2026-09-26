let s:outputter = {}

function s:outputter.output(data, session) abort
  for line in a:data->split("\n", 1)
    echowindow line
  endfor
endfunction

function quickrun#outputter#echowindow#new() abort
  return deepcopy(s:outputter)
endfunction
