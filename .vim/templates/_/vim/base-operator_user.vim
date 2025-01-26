vim9script

def OperatorUser{{_var_:name_capitalize}}(motion_wise: string)
  const save_reg_0 = [@0, getregtype('0')]
  const v = operator#user#visual_command_from_wise_name(motion_wise)
  execute $'normal! `[{v}`]"0y'
  @0 = @0->toupper(){{_cursor_}} # FIXME
  execute $'normal! `[{v}`]"0P`['
  call setreg('0', save_reg_0[0], save_reg_0[1])
enddef
call operator#user#define('{{_var_:name}}', function('OperatorUser{{_var_:name_capitalize}}'))
map s,  <Plug>(operator-{{_var_:name}})

defcompile
{{_define_:name:input('name: ', 'example')}}
{{_define_:name_capitalize:substitute('{{_var_:name}}', '\w\+', '\u\0', '')}}
