let s:save_cpo = &cpo
set cpo&vim

if &background ==# 'light'
  runtime autoload/lightline/colorscheme/iceberg.vim
  let g:lightline#colorscheme#iceberg_light#palette = deepcopy(g:lightline#colorscheme#iceberg#palette)
endif

let &cpo = s:save_cpo
unlet s:save_cpo
