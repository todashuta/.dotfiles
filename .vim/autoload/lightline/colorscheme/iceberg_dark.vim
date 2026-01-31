vim9script

if &background ==# 'dark'
  runtime autoload/lightline/colorscheme/iceberg.vim
  g:lightline#colorscheme#iceberg_dark#palette = deepcopy(g:lightline#colorscheme#iceberg#palette)
endif
