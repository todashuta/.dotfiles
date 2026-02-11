vim9script

var timer = 0

export def MigemoMatch(items: list<string>,
    str: string, limit: number, mmode: string,
    ispath: bool, crfile: string, regex: bool): list<string>

  if empty(str)
    clearmatches()
    return items[ : &lines]
  endif

  const pat = regex ? str : kensaku#query(str)
  timer_stop(timer)
  timer = timer_start(10, (t) => {
    clearmatches()
    matchadd('CtrlPMatch', pat)
    if hlexists('CtrlPLinePre')
      matchadd('CtrlPLinePre', '^>')
    endif
    redraw
  }, {repeat: 0})
  return filter(copy(items), (_, val) => val =~ pat)
enddef

#defcompile
# vim: set et ts=2 sts=2 sw=2:
