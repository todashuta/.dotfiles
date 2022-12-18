""" packinit.vim

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

function s:add(name, ...)
  let l:opt = extend(copy(get(a:000, 0, {})), {'type': 'opt'}, 'keep')
  return minpac#add(a:name, l:opt)
endfunction
" }}}

call s:add('k-takata/minpac')

call s:add('ctrlpvim/ctrlp.vim')
call s:add('mattn/ctrlp-launcher')
call s:add('mattn/emmet-vim')
call s:add('previm/previm')
call s:add('mattn/sonictemplate-vim')
call s:add('mattn/vim-molder', {'rev': '2577531'})
call s:add('rbtnn/vimconsole.vim')
call s:add('ynkdir/vim-diff')
call s:add('jonathanfilip/vim-lucius')
call s:add('kana/vim-niceblock', {'rev': 'fd90673'})
call s:add('PProvost/vim-ps1')
call s:add('thinca/vim-quickrun')
call s:add('thinca/vim-qfreplace')
call s:add('tyru/open-browser.vim')
call s:add('mhinz/vim-signify')
call s:add('vim-jp/syntax-vim-ex')
call s:add('morhetz/gruvbox')
call s:add('MaxMellon/vim-jsx-pretty')
call s:add('pangloss/vim-javascript')
call s:add('tpope/vim-surround')
call s:add('koron/codic-vim')
call s:add('hail2u/vim-css3-syntax')
call s:add('othree/html5.vim')
call s:add('itchyny/lightline.vim')
call s:add('AndrewRadev/switch.vim')
call s:add('tpope/vim-fugitive', {'rev': '5716e11'})
call s:add('kana/vim-operator-user')
call s:add('kana/vim-operator-replace')
call s:add('kana/vim-textobj-user')
call s:add('kana/vim-textobj-syntax')
call s:add('kana/vim-textobj-indent')
call s:add('kana/vim-textobj-line')
call s:add('kana/vim-textobj-entire')
call s:add('thinca/vim-textobj-comment')
call s:add('bps/vim-textobj-python')
call s:add('mattn/lisper-vim')
call s:add('machakann/vim-sandwich')
call s:add('thinca/vim-prettyprint')
call s:add('thinca/vim-ft-clojure')
call s:add('vim-jp/cpp-vim')
call s:add('vim-jp/vimdoc-ja')
call s:add('thinca/vim-zenspace')
call s:add('itchyny/vim-parenmatch')
call s:add('itchyny/vim-cursorword')
call s:add('Shougo/vimproc.vim', {'do': (has('win32') ? '' : {-> system('make')})})
call s:add('vim-jp/vital.vim')
call s:add('rhysd/vim-color-spring-night')
call s:add('ghifarit53/tokyonight-vim')
call s:add('prabirshrestha/async.vim')
call s:add('prabirshrestha/asyncomplete.vim')
call s:add('prabirshrestha/asyncomplete-lsp.vim')
call s:add('prabirshrestha/vim-lsp')
call s:add('mattn/vim-lsp-settings')
call s:add('itchyny/vim-gitbranch')
call s:add('cespare/vim-toml')
call s:add('hrsh7th/vim-vsnip')
call s:add('hrsh7th/vim-vsnip-integ')
call s:add('mattn/vim-lsp-icons')
call s:add('halkn/lightline-lsp')
call s:add('mattn/vim-findroot')
call s:add('todashuta/vim-toggle-split-orientation')
call s:add('cocopon/iceberg.vim')
call s:add('mattn/vim-notification')
call s:add('vimwiki/vimwiki')
call s:add('ziglang/zig.vim')
call s:add('t9md/vim-quickhl')
call s:add('raimon49/requirements.txt.vim')
call s:add('jeetsukumaran/vim-buffergator')
call s:add('jeetsukumaran/vim-filebeagle')
call s:add('jeetsukumaran/vim-pythonsense')
call s:add('jeetsukumaran/vim-argwrap')
call s:add('lambdalisue/mr.vim')
call s:add('tsuyoshicho/ctrlp-mr.vim')

"" denops
call s:add('vim-denops/denops.vim')
call s:add('vim-denops/denops-helloworld.vim')
call s:add('vim-skk/skkeleton')

""" vim: set et ts=2 sts=2 sw=2 fdm=marker:
""" packinit.vim ends here
