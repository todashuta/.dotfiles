vim9script

def Str2byte(str: string): list<number>
  return range(len(str))->map((_, v) => char2nr(strpart(str, v, 1)))
enddef

def Byte2hex(bytes: list<number>): string
  return join(copy(bytes)->map((_, v) => printf("%02X", v)), '')
enddef

export def FencB(): string
  var c = matchstr(getline('.'), '.', col('.') - 1)
  if c != ''
    c = iconv(c, &enc, &fenc)
    return Byte2hex(Str2byte(c))
  else
    return '0'
  endif
enddef

export def Filetype(): string
  var s = &l:filetype ?? 'no-ft'
  if !empty(get(w:, 'current_syntax', ''))
    s = $'{w:current_syntax}/{s}'
  endif
  return s
enddef

export def Filename(): string
  if &l:filetype ==# 'ctrlp' && get(g:lightline, 'ctrlp_numscanned', 0) > 0
    return $'{g:lightline.ctrlp_numscanned} files... (press ctrl-c to abort)'
  endif
  if &l:filetype ==# 'ctrlp' && has_key(g:lightline, 'ctrlp_item')
    const regmark = g:lightline.ctrlp_regex ? '[.*] ' : '[  ] '
    return regmark .. join([
      '<' .. g:lightline.ctrlp_prev .. '>',
      '{' .. g:lightline.ctrlp_item .. '}',
      '<' .. g:lightline.ctrlp_next .. '>',
    ], '=') .. g:lightline.ctrlp_marked
  endif
  if &l:buftype ==# 'quickfix' && !empty(get(w:, 'quickfix_title', ''))
    return w:quickfix_title
  endif
  const name = fnamemodify(@%, ':t') # expand('%:t')
  return name ?? '[No Name]'
enddef

export def Wintype(): string
  if !empty(get(b:, 'mybufnameoverride', ''))
    return $'{b:mybufnameoverride}'
  endif
  if get(b:, 'mydifforigbuf', 0)
    return 'DiffOrig'
  endif
  if &l:buftype ==# 'terminal'
    const bnr = bufnr('')
    if term_getstatus(bnr) =~# 'finished'
      return $'Terminal-exited: {job_info(term_getjob(bnr)).exitval}'
    else
      return 'Terminal'
    endif
  endif
  const cmdwintype = getcmdwintype()
  if !empty(cmdwintype)
    return cmdwintype
  endif
  const ret = get({
    '': '--',
    'ctrlp': 'CtrlP',
    'fugitive': 'Git',
    'fugitiveblame': 'Git',
    'help': 'Help',
    'qf': 'QuickFix',
  }, &l:filetype, &l:filetype)
  return &l:modifiable ? ret : $'*{ret}*'
  #let w = winnr()
  #return bufnr('').'|'.w.(w==winnr('#')?'#':'')
enddef

export def GitStatus(): string
  var xs = []
  var fugitive_status = g:FugitiveStatusline()
  if empty(fugitive_status)
    return ''
  endif
  fugitive_status = substitute(fugitive_status, '^[Git:\?', '', '')
  fugitive_status = substitute(fugitive_status, ']$', '', '')
  xs += [fugitive_status]

  #let l:gitbranchname = gitbranch#name()
  #if l:gitbranchname == ''
  #  return ''
  #endif
  #let l:is_index = get(b:, 'fugitive_type', '') ==# 'blob' && &modifiable
  #let l:xs += [(l:is_index ? '*' : '') . '(' . l:gitbranchname . ')']

  var signify_stats = sy#repo#get_stats_decorated()
  if !empty(signify_stats)
    xs += [signify_stats]
  endif

  return join(xs, ' ')
enddef

#defcompile
# vim: set et ts=2 sts=2 sw=2:
