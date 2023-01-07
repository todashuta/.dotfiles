let s:save_cpo = &cpo
set cpo&vim

if &background ==# 'dark'
  exe 'runtime autoload/lightline/colorscheme/edge.vim'
  let g:lightline#colorscheme#edge_dark#palette = deepcopy(g:lightline#colorscheme#edge#palette)
endif

let &cpo = s:save_cpo
unlet s:save_cpo
