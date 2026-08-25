vim9script

export def LoclistOpened(): bool
  return getwininfo()->filter((_, v) => v.tabnr == tabpagenr() && v.loclist)->len() > 0
enddef

export def QflistOpened(): bool
  return getwininfo()->filter((_, v) => v.tabnr == tabpagenr() && v.quickfix && !v.loclist)->len() > 0
enddef

#defcompile
# vim: set et ts=2 sts=2 sw=2:
