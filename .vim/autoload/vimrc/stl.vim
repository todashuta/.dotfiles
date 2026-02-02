vim9script

def Str2byte(str: string): list<number>
  return str->len()->range()->mapnew((_, v) => char2nr(strpart(str, v, 1)))
enddef

def Byte2hex(bytes: list<number>): string
  return join(bytes->mapnew((_, v) => printf('%02X', v)), '')
enddef

export def FencB(): string
  const c = getline('.')[charcol('.') - 1]
  if c->empty()
    return '00'
  endif
  const fencC = c->iconv(&enc, &fenc)
  const succeeded = fencC->iconv(&fenc, &enc) ==# c
  if succeeded
    return fencC->Str2byte()->Byte2hex()
  else
    return '#ERR!'
  endif
enddef

export def Filetype(): string
  const ft = &l:filetype ?? 'no-ft'
  if !empty(get(w:, 'current_syntax', ''))
    return $'{w:current_syntax}/{ft}'
  endif
  return ft
enddef

def FileBeagleInfo(): string
  if !exists('g:FileBeagleStatusLineCurrentDirInfo')
    return ''
  endif
  const currentDirInfo = g:FileBeagleStatusLineCurrentDirInfo()
  if empty(currentDirInfo)
    return ''
  endif
  const filterAndHiddenInfo = g:FileBeagleStatusLineFilterAndHiddenInfo()
  return filterAndHiddenInfo .. fnamemodify(currentDirInfo, ':~')
enddef

def CtrlPInfo(): string
  if &l:filetype != 'ctrlp'
    return ''
  endif
  if get(g:lightline, 'ctrlp_numscanned', 0) > 0
    return $'{g:lightline.ctrlp_numscanned} files... (press ctrl-c to abort)'
  endif
  if has_key(g:lightline, 'ctrlp_item')
    const regmark = g:lightline.ctrlp_regex ? '[.*] ' : '[  ] '
    return regmark .. join([
      '<' .. g:lightline.ctrlp_prev .. '>',
      '{' .. g:lightline.ctrlp_item .. '}',
      '<' .. g:lightline.ctrlp_next .. '>',
    ], '=') .. g:lightline.ctrlp_marked
  endif
  return ''
enddef

def QuickfixInfo(): string
  if &l:buftype != 'quickfix'
    return ''
  endif
  return get(w:, 'quickfix_title', '')
enddef

export def Filename(): string
  return (FileBeagleInfo() ?? CtrlPInfo() ?? QuickfixInfo() ??
      fnamemodify(@%, ':t') ?? '[No Name]')
enddef

def TerminalInfo(): string
  if &l:buftype != 'terminal'
    return ''
  endif
  const bnr = bufnr('')
  if term_getstatus(bnr) =~# 'finished'
    return $'Terminal-exited: {job_info(term_getjob(bnr)).exitval}'
  endif
  return 'Terminal'
enddef

def BufnameOverride(): string
  if !empty(get(b:, 'mybufnameoverride', ''))
    return '{' .. b:mybufnameoverride .. '}'
  endif
  return ''
enddef

def DiffOrig(): string
  if get(b:, 'mydifforigbuf', 0)
    return 'DiffOrig'
  endif
  return ''
enddef

def FiletypeEx(): string
  const ret = get({
    [null_string]: '--',
    ctrlp: 'CtrlP',
    fugitive: 'Git',
    fugitiveblame: 'Git',
    help: 'Help',
    qf: 'QuickFix',

    vim: 'Vim script',
    go: 'Go',
    python: 'Python',
    ruby: 'Ruby',
    cmake: 'CMake',
    make: 'Make',
    cuda: 'CUDA',
    cpp: 'C++',
    c: 'C',
    cs: 'C#',
    typescript: 'TS',
    javascript: 'JS',
    json: 'JSON',
  }, &l:filetype, &l:filetype)
  if &l:modifiable
    return ret
  else
    return $'*{ret}*'
  endif
enddef

export def Wintype(): string
  return BufnameOverride() ?? DiffOrig() ?? TerminalInfo() ?? getcmdwintype() ?? FiletypeEx()
  #let w = winnr()
  #return bufnr('').'|'.w.(w==winnr('#')?'#':'')
enddef

def FugitiveInfo(): string
  const stat = g:FugitiveStatusline()
  if empty(stat)
    return ''
  endif
  return (stat->substitute('^[Git:\?', '', '')
      ->substitute(']$', '', ''))
enddef

export def GitStatus(): string
  var xs = []
  const fugitiveInfo = FugitiveInfo()
  if empty(fugitiveInfo)
    return ''
  endif
  xs->add(fugitiveInfo)

  #let l:gitbranchname = gitbranch#name()
  #if l:gitbranchname == ''
  #  return ''
  #endif
  #let l:is_index = get(b:, 'fugitive_type', '') ==# 'blob' && &modifiable
  #let l:xs += [(l:is_index ? '*' : '') . '(' . l:gitbranchname . ')']

  const signify_stats = sy#repo#get_stats_decorated()
  if !empty(signify_stats)
    xs->add(signify_stats)
  endif

  return xs->join()
enddef

const fileformats = {
  dos: 'CR+LF(dos)',
  unix: 'LF(unix)',
  mac: 'CR(mac)'
}
export def Fileformat(): string
  return fileformats[&l:ff] .. (&l:eol ? '' : '-NoEOL')
enddef

export def Fileencoding(): string
  return toupper(&l:fenc ?? (&enc .. '*')) .. (&l:bomb ? '(BOM)' : '')
enddef

export def QuickRun(mark: string = "('_'*)"): string
  return quickrun#session#exists() ? mark : ''
enddef

export def CtrlP_main(focus: string, byfname: string, regex: bool,
    prev: string, item: string, next: string, marked: string): string
  g:lightline.ctrlp_prev = prev
  g:lightline.ctrlp_item = item
  g:lightline.ctrlp_next = next
  g:lightline.ctrlp_marked = marked
  g:lightline.ctrlp_regex = regex
  g:lightline.ctrlp_numscanned = 0
  return lightline#statusline(0)
enddef

export def CtrlP_progress(numscanned: number): string
  g:lightline.ctrlp_numscanned = numscanned
  return lightline#statusline(0)
enddef

#defcompile
# vim: set et ts=2 sts=2 sw=2:
