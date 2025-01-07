function! vimrc#cmd#ResizeInteractive()
  while 1
    let c = getchar()
    if     c == "\<Up>"    | wincmd +
    elseif c == "\<Down>"  | wincmd -
    elseif c == "\<Left>"  | wincmd <
    elseif c == "\<Right>" | wincmd >
    else                   | break
    endif
    redraw
  endwhile
  redraw
endfunction
