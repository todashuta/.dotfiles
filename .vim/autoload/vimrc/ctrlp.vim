vim9script

export def MigemoMatch(items: list<string>,
    str: string, limit: number, mmode: string,
    ispath: bool, crfile: string, regex: bool): list<string>
  const pat = kensaku#query(str)
  return filter(copy(items), (_, val) => val =~ pat)
enddef

#defcompile
# vim: set et ts=2 sts=2 sw=2:
