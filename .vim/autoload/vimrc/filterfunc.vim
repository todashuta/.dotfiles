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

export def DecodeURI(s: string): string
  #return vital#vital#import('Web.URI').decode(s)
  return denops#request('vimrc', 'decodeURIComponent', [s])
enddef

export def EncodeURI(s: string): string
  #return vital#vital#import('Web.URI').encode(s)
  return denops#request('vimrc', 'encodeURIComponent', [s])
enddef

#defcompile
