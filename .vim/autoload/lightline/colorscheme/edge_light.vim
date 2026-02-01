vim9script

if &background ==# 'light'
  runtime autoload/lightline/colorscheme/edge.vim
  g:lightline#colorscheme#edge_light#palette = deepcopy(g:lightline#colorscheme#edge#palette)
endif

#defcompile
# vim: set et ts=2 sts=2 sw=2:
