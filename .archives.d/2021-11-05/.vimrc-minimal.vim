" minimal vimrc

set laststatus=2 cmdheight=2 ruler showcmd
set cscopetag tags=tags;,./tags;
set swapfile directory=~/var/vim/swap
set list listchars=tab:>-,trail:-,nbsp:%
set pumheight=10
let &statusline = '%<%t%h%m%r [%{(&fenc==""?&enc:&fenc).(&bomb?"(BOM)":"")}:%{&ff.(&eol?"":"-noeol")}] 0x%B%= %l,%c%V %P'
let &grepprg = 'grep -rnIH'

filetype plugin indent on
syntax on

nnoremap Q      <Nop>
cnoremap <C-p>  <Up>
cnoremap <C-n>  <Down>
nnoremap s      <Nop>
nnoremap s/     :<C-u>silent grep!<Space>
nnoremap sa     :<C-u>silent grepadd!<Space>

colorscheme ron

augroup vimrc
  autocmd!
  autocmd QuickFixCmdPost [^l]* botright cwindow | redraw!
  autocmd VimEnter,WinEnter,ColorScheme * highlight MatchParen guifg=NONE guibg=NONE ctermfg=NONE ctermbg=NONE term=underline cterm=underline gui=underline
augroup END
