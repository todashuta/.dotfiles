let s:save_cpo = &cpo
set cpo&vim

if &background ==# 'dark'
  exe 'runtime autoload/lightline/colorscheme/iceberg.vim'
  let g:lightline#colorscheme#iceberg_dark#palette = deepcopy(g:lightline#colorscheme#iceberg#palette)
endif

let &cpo = s:save_cpo
unlet s:save_cpo
