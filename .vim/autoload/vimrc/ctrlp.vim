vim9script

var timer = 0

def Esc(s: string): string
  return '\c' .. substitute(tolower(s), '.', '\0[^\0]\\{-}', 'g')
enddef

export def Matcher(items: list<string>,
    userstr: string, limit: number, mmode: string,
    ispath: bool, crfile: string, regex: bool): list<string>

  var str = userstr

  const use_migemo = !regex && (str[0] == '!')
  if use_migemo
    str = str[1 :]
  endif

  if empty(str)
    clearmatches()
    return items[ : &lines]
  endif

  const pat = regex ? str : (use_migemo ? kensaku#query(str) : Esc(str))
  timer_stop(timer)
  timer = timer_start(10, (t) => {
    clearmatches()
    matchadd('CtrlPMatch', pat)
    if hlexists('CtrlPLinePre')
      matchadd('CtrlPLinePre', '^>')
    endif
    redraw
  }, {repeat: 0})

  if regex
    return filter(copy(items), (_, val) => val =~ str)
  elseif use_migemo
    return filter(copy(items), (_, val) => val =~ pat)
  else
    return matchfuzzy(items, str, {limit: &lines})
  endif
enddef

#defcompile
# vim: set et ts=2 sts=2 sw=2:
