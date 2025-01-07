function! vimrc#opfunc#SlashToBackslash(motion_wise)
  let save_reg_0 = [@0, getregtype('0')]
  let v = operator#user#visual_command_from_wise_name(a:motion_wise)
  execute 'normal!' '`[' . v . '`]"0y'
  let @0 = substitute(@0, '/', '\', 'g')
  execute 'normal!' '`[' . v . '`]"0P`['
  call setreg('0', save_reg_0[0], save_reg_0[1])
endfunction

function! vimrc#opfunc#BackslashToSlash(motion_wise)
  let save_reg_0 = [@0, getregtype('0')]
  let v = operator#user#visual_command_from_wise_name(a:motion_wise)
  execute 'normal!' '`[' . v . '`]"0y'
  let @0 = substitute(@0, '\', '/', 'g')
  execute 'normal!' '`[' . v . '`]"0P`['
  call setreg('0', save_reg_0[0], save_reg_0[1])
endfunction

function! vimrc#opfunc#CR2LF(motion_wise)
  let save_reg_0 = [@0, getregtype('0')]
  let v = operator#user#visual_command_from_wise_name(a:motion_wise)
  execute 'normal!' '`[' . v . '`]"0y'
  let @0 = substitute(@0, '\r', '\n', 'g')
  execute 'normal!' '`[' . v . '`]"0P`['
  call setreg('0', save_reg_0[0], save_reg_0[1])
endfunction
