function! vimrc#filterfunc#SlashToBackslash(str)
  return substitute(a:str, '/', '\', 'g')
endfunction

function! vimrc#filterfunc#BackslashToSlash(str)
  return substitute(a:str, '\', '/', 'g')
endfunction

function! vimrc#filterfunc#CR2LF(str)
  return substitute(a:str, '\r', '\n', 'g')
endfunction

function! vimrc#filterfunc#decodeURI(str)
  "return vital#vital#import('Web.URI').decode(a:str)
  return denops#request('vimrc', 'decodeURIComponent', [a:str])
endfunction

function! vimrc#filterfunc#encodeURI(str)
  "return vital#vital#import('Web.URI').encode(a:str)
  return denops#request('vimrc', 'encodeURIComponent', [a:str])
endfunction
