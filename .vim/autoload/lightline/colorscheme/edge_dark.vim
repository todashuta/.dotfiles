vim9script

if &background ==# 'dark'
  runtime autoload/lightline/colorscheme/edge.vim
  g:lightline#colorscheme#edge_dark#palette = deepcopy(g:lightline#colorscheme#edge#palette)
endif
