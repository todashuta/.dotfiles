if exists('g:loaded_ctrlp_templatedir') && g:loaded_ctrlp_templatedir
  finish
endif
let g:loaded_ctrlp_templatedir = 1

let s:templatedir_var = {
\  'init':   'ctrlp#templatedir#init()',
\  'exit':   'ctrlp#templatedir#exit()',
\  'accept': 'ctrlp#templatedir#accept',
\  'lname':  'templatedir',
\  'sname':  'templatedir',
\  'type':   '',
\  'sort':   0,
\  'nolim':  1,
\  'opmul':  1,
\}

let s:dirs = {}
let s:list = []

if exists('g:ctrlp_ext_vars') && !empty(g:ctrlp_ext_vars)
  let g:ctrlp_ext_vars = add(g:ctrlp_ext_vars, s:templatedir_var)
else
  let g:ctrlp_ext_vars = [s:templatedir_var]
endif

function! ctrlp#templatedir#launch(bang)
  if a:bang
    let g:sonictemplate_vim_template_dir = [ expand($VIMDIR .. '/templates/_') ]
    runtime autoload/sonictemplate.vim
    PP g:sonictemplate_vim_template_dir
    return
  endif
  call ctrlp#init(ctrlp#templatedir#id())
endfunction

function! ctrlp#templatedir#init(...)
  let s:dirs = {}
  let s:list = map(glob($VIMDIR .. '/templates/[^_]*', v:true, v:true), '[fnamemodify(v:val, ":t"), v:val]')
  for i in s:list
    let s:dirs[i[0]] = i[1]
  endfor
  return map(copy(s:list), 'v:val[0]')
endfunction

function! ctrlp#templatedir#accept(mode, str)
  if !empty(ctrlp#getmarkedlist())
    let l:lines = map(copy(ctrlp#getmarkedlist()), 's:dirs[v:val]')
  else
    let l:lines = map(filter(copy(s:list), 'v:val[0] == a:str'), 'v:val[1]')
  endif
  call filter(l:lines, 'isdirectory(v:val)')
  call ctrlp#exit()
  redraw!
  let g:sonictemplate_vim_template_dir = [ expand($VIMDIR .. '/templates/_') ] + l:lines
  runtime autoload/sonictemplate.vim
  PP g:sonictemplate_vim_template_dir
endfunction

function! ctrlp#templatedir#exit()
  if exists('s:list')
    unlet! s:list
  endif
  if exists('s:dirs')
    unlet! s:dirs
  endif
endfunction

let s:id = g:ctrlp_builtins + len(g:ctrlp_ext_vars)
function! ctrlp#templatedir#id()
  return s:id
endfunction

" vim:fen:fdl=0:ts=2:sw=2:sts=2
