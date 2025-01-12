vim9script

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

#defcompile
