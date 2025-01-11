function! s:opfunc(filterfunc, motion_wise)
  let save_reg_0 = [@0, getregtype('0')]
  let v = operator#user#visual_command_from_wise_name(a:motion_wise)
  execute 'normal!' '`[' .. v .. '`]"0y'
  let @0 = function(a:filterfunc)(@0)
  execute 'normal!' '`[' .. v .. '`]"0P`['
  call setreg('0', save_reg_0[0], save_reg_0[1])
endfunction

function! vimrc#opfunc#SlashToBackslash(motion_wise)
  return function('s:opfunc', ['vimrc#filterfunc#SlashToBackslash'])(a:motion_wise)
endfunction

function! vimrc#opfunc#BackslashToSlash(motion_wise)
  return function('s:opfunc', ['vimrc#filterfunc#BackslashToSlash'])(a:motion_wise)
endfunction

function! vimrc#opfunc#CR2LF(motion_wise)
  return function('s:opfunc', ['vimrc#filterfunc#CR2LF'])(a:motion_wise)
endfunction

function! vimrc#opfunc#decodeURI(motion_wise)
  return function('s:opfunc', ['vimrc#filterfunc#decodeURI'])(a:motion_wise)
endfunction

function! vimrc#opfunc#encodeURI(motion_wise)
  return function('s:opfunc', ['vimrc#filterfunc#encodeURI'])(a:motion_wise)
endfunction
