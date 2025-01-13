vim9script

import "./filterfunc.vim"

def Opfunc(Filterfunc: func, motion_wise: string)
  const save_reg_0 = [@0, getregtype('0')]
  const v = operator#user#visual_command_from_wise_name(motion_wise)
  execute $'normal! `[{v}`]"0y'
  @0 = Filterfunc(@0)
  execute $'normal! `[{v}`]"0P`['
  setreg('0', save_reg_0[0], save_reg_0[1])
enddef

export def SlashToBackslash(motion_wise: string)
  Opfunc(filterfunc.SlashToBackslash, motion_wise)
enddef

export def BackslashToSlash(motion_wise: string)
  Opfunc(filterfunc.BackslashToSlash, motion_wise)
enddef

export def CR2LF(motion_wise: string)
  Opfunc(filterfunc.CR2LF, motion_wise)
enddef

export def DecodeURI(motion_wise: string)
  Opfunc(filterfunc.DecodeURI, motion_wise)
enddef

export def EncodeURI(motion_wise: string)
  Opfunc(filterfunc.EncodeURI, motion_wise)
enddef

#defcompile
