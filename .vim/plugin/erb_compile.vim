if v:version < 700 || (exists('g:loaded_erb_compile') && g:loaded_erb_compile || &cp)
  finish
endif
let g:loaded_erb_compile = 1

if !exists('g:erb_compile_ruby')
  let g:erb_compile_ruby = '/usr/bin/env ruby'
endif

if !exists('g:erb_compile_prefix_name')
  let g:erb_compile_prefix_name = 'prerb'
endif

function! s:AfterSaveCompile()
  let filename = expand('%:p')
  let output_filename = substitute(filename, '\.' . g:erb_compile_prefix_name . '\(\..\+\)$', '\1', '')
  call g:ErbCompile(filename, output_filename)
endfunction

function! g:ErbCompile(filename, output_filename)
  call system(g:erb_compile_ruby . ' -r erb -e "puts ERB.new(ARGF.read).result" ' . a:filename . ' > ' . a:output_filename)
endfunction

exe 'autocmd BufWritePost *.' . g:erb_compile_prefix_name . '.* call s:AfterSaveCompile()'
