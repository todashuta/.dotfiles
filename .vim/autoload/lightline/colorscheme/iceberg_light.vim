vim9script

if &background ==# 'light'
  runtime autoload/lightline/colorscheme/iceberg.vim
  g:lightline#colorscheme#iceberg_light#palette = deepcopy(g:lightline#colorscheme#iceberg#palette)
endif
