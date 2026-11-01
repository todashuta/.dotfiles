vim9script

export def SlashToBackslash(s: string): string
  return substitute(s, '/', '\', 'g')
enddef

export def BackslashToSlash(s: string): string
  return substitute(s, '\', '/', 'g')
enddef

export def CR2LF(s: string): string
  return substitute(s, '\r', '\n', 'g')
enddef

#defcompile
# vim: set et ts=2 sts=2 sw=2:
