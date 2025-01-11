function! OperatorUserExample(motion_wise)  " FIXME
  let save_reg_0 = [@0, getregtype('0')]
  let v = operator#user#visual_command_from_wise_name(a:motion_wise)
  execute 'normal!' '`[' . v . '`]"0y'
  let @0 = @0  " FIXME
  execute 'normal!' '`[' . v . '`]"0P`['
  call setreg('0', save_reg_0[0], save_reg_0[1])
endfunction
call operator#user#define('example', 'OperatorUserExample')  " FIXME
"map s/  <Plug>(operator-example)
{{_cursor_}}
