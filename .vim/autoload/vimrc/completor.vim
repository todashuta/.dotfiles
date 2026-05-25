vim9script

var cache = {}
def OmniSyntaxList(filetype: string): list<string>
  if !has_key(cache, filetype)
    cache[filetype] = syntaxcomplete#OmniSyntaxList([])->sort()->uniq() # See :h ft-syntax-omni
  endif
  return cache[filetype]
enddef

export def Syntax(opt: dict<any>, ctx: dict<any>): void
  const col = ctx['col']
  const typed = ctx['typed']

  const kw = matchstr(typed, '\v\S+$')
  const kwlen = len(kw)

  const startcol = col - kwlen

  const matches = OmniSyntaxList(&l:filetype)

  asyncomplete#complete(opt['name'], ctx, startcol, matches)
enddef

#defcompile
# vim: set et ts=2 sts=2 sw=2:
