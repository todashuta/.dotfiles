""" filetype.vim

if exists('did_load_filetypes')
  finish
endif

augroup filetypedetect
  autocmd! BufRead,BufNewFile *.rviz setfiletype yaml
  autocmd! BufRead,BufNewFile *.ms setfiletype maxscript

  "autocmd! BufRead,BufNewFile *.gltf setfiletype gltf
  autocmd! BufRead,BufNewFile *.gltf setfiletype json
  autocmd! BufRead,BufNewFile *.usda setfiletype usda

  autocmd! BufRead,BufNewFile *.geojson setfiletype json
  autocmd! BufRead,BufNewFile *.czml setfiletype json
  autocmd! BufRead,BufNewFile *.uproject setfiletype json
  autocmd! BufRead,BufNewFile *.uefnproject setfiletype json
augroup END

""" vim: set et ts=2 sts=2 sw=2:
""" filetype.vim ends here
