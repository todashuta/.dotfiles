""" filetype.vim

if exists('did_load_filetypes')
  finish
endif

augroup filetypedetect
  autocmd! BufRead,BufNewFile *.ms setfiletype maxscript

  "autocmd! BufRead,BufNewFile *.gltf setfiletype gltf
  autocmd! BufRead,BufNewFile *.gltf setfiletype json
augroup END

""" vim: set et ts=2 sts=2 sw=2:
""" filetype.vim ends here
