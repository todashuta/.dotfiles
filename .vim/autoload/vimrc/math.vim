vim9script

export const Pi = acos(-1.0)

export def DegToRad(deg: float): float
  return deg * Pi / 180.0
enddef

export def RadToDeg(rad: float): float
  return rad * 180.0 / Pi
enddef

#defcompile
# vim: set et ts=2 sts=2 sw=2:
