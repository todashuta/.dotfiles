" packinit.vim

" {{{
if exists(':packadd') != 2
  echom "`:packadd` is not available.  Please use latest version of Vim."
  finish
endif

silent! packadd minpac

try
  call minpac#init()
catch
  if !executable('git')
    echom "`git` command is not available.  Please install Git client."
    finish
  endif
  execute '!git clone https://github.com/k-takata/minpac '.expand($VIMDIR).'/pack/minpac/opt/minpac'
  packadd minpac
  call minpac#init()
endtry
" }}}

call minpac#add('k-takata/minpac',            {'type': 'opt'})

call minpac#add('ctrlpvim/ctrlp.vim',         {'type': 'opt'})
call minpac#add('mattn/emmet-vim',            {'type': 'opt'})
call minpac#add('previm/previm',              {'type': 'opt'})
call minpac#add('mattn/sonictemplate-vim',    {'type': 'opt'})
call minpac#add('rbtnn/vimconsole.vim',       {'type': 'opt'})
call minpac#add('ynkdir/vim-diff',            {'type': 'opt'})
call minpac#add('jonathanfilip/vim-lucius',   {'type': 'opt'})
call minpac#add('kana/vim-niceblock',         {'type': 'opt', 'rev': 'fd90673'})
call minpac#add('PProvost/vim-ps1',           {'type': 'opt'})
call minpac#add('thinca/vim-quickrun',        {'type': 'opt'})
call minpac#add('tyru/open-browser.vim',      {'type': 'opt'})
call minpac#add('mhinz/vim-signify',          {'type': 'opt'})
call minpac#add('vim-jp/syntax-vim-ex',       {'type': 'opt'})
call minpac#add('morhetz/gruvbox',            {'type': 'opt'})
call minpac#add('MaxMellon/vim-jsx-pretty',   {'type': 'opt'})
call minpac#add('pangloss/vim-javascript',    {'type': 'opt'})
call minpac#add('tpope/vim-surround',         {'type': 'opt'})
call minpac#add('koron/codic-vim',            {'type': 'opt'})
call minpac#add('hail2u/vim-css3-syntax',     {'type': 'opt'})
call minpac#add('othree/html5.vim',           {'type': 'opt'})
call minpac#add('itchyny/lightline.vim',      {'type': 'opt'})
call minpac#add('AndrewRadev/switch.vim',     {'type': 'opt'})
call minpac#add('tpope/vim-fugitive',         {'type': 'opt'})
call minpac#add('kana/vim-textobj-user',      {'type': 'opt'})
call minpac#add('kana/vim-textobj-indent',    {'type': 'opt'})
call minpac#add('kana/vim-textobj-line',      {'type': 'opt'})
call minpac#add('kana/vim-textobj-entire',    {'type': 'opt'})
call minpac#add('thinca/vim-textobj-comment', {'type': 'opt'})
call minpac#add('mattn/lisper-vim',           {'type': 'opt'})
call minpac#add('thinca/vim-prettyprint',     {'type': 'opt'})
call minpac#add('thinca/vim-ft-clojure',      {'type': 'opt'})
call minpac#add('vim-jp/cpp-vim',             {'type': 'opt'})
call minpac#add('vim-jp/vimdoc-ja',           {'type': 'opt'})
call minpac#add('thinca/vim-zenspace',        {'type': 'opt'})
call minpac#add('itchyny/vim-parenmatch',     {'type': 'opt'})
call minpac#add('Shougo/vimproc.vim',         {'type': 'opt', 'do': (has('win32') ? '' : {-> system('make')})})
call minpac#add('vim-jp/vital.vim',           {'type': 'opt'})
call minpac#add('rhysd/vim-color-spring-night',{'type': 'opt'})
call minpac#add('ghifarit53/tokyonight-vim',  {'type': 'opt'})
call minpac#add('prabirshrestha/async.vim',   {'type': 'opt'})
call minpac#add('prabirshrestha/asyncomplete.vim', {'type': 'opt'})
call minpac#add('prabirshrestha/asyncomplete-lsp.vim', {'type': 'opt'})
call minpac#add('prabirshrestha/vim-lsp',     {'type': 'opt'})
call minpac#add('mattn/vim-lsp-settings',     {'type': 'opt'})
call minpac#add('itchyny/vim-gitbranch',      {'type': 'opt'})
call minpac#add('cespare/vim-toml',           {'type': 'opt'})
call minpac#add('hrsh7th/vim-vsnip',          {'type': 'opt'})
call minpac#add('hrsh7th/vim-vsnip-integ',    {'type': 'opt'})
call minpac#add('mattn/vim-lsp-icons',        {'type': 'opt'})

" vim: set et ts=2 sts=2 sw=2 fdm=marker :
