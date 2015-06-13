scriptencoding utf-8

function! s:on_FileType_markdown()
  try
    call smartchr#one_of('')
  catch
    return
  endtry

  " Insert space sensibly after '-', '+', '*', '>'.
  inoremap <buffer><expr> -
        \ search('^\s*\%(-\s\)*\%#', 'bcn') ?
        \   smartchr#one_of('- ', '-') : '-'
  inoremap <buffer><expr> +
        \ search('^\s*\%(+\s\)*\%#', 'bcn') ?
        \   smartchr#one_of('+ ', '+') : '+'
  inoremap <buffer><expr> *
        \ search('^\s*\%(\*\s\)*\%#', 'bcn') ?
        \   smartchr#one_of('* ', '*') : '*'
  inoremap <buffer><expr> >
        \ search('^\s*\%(>\s\)*\%#', 'bcn') ?
        \   smartchr#one_of('> ', '>') : '>'

  " Insert space sensibly after '#', '.'.
  inoremap <buffer><expr> #
        \ search('^\s*\%(##*\s\)\?\%#', 'bcn') ?
        \   smartchr#one_of('# ', '## ') : '#'
  inoremap <buffer><expr> .
        \ search('^\s*[0-9][0-9]*\%(\.\s\)\?\%#', 'bcn') ?
        \   smartchr#one_of('. ', '.') : '.'
endfunction
call s:on_FileType_markdown()

" vim: set fdm=marker ts=2 sw=2 sts=2 et:
