vim9script

if &background ==# 'light'
  runtime autoload/lightline/colorscheme/edge.vim
  g:lightline#colorscheme#edge_light#palette = deepcopy(g:lightline#colorscheme#edge#palette)
endif
