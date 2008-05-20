set omnifunc=csscomplete#CompleteCSS

if (exists("b:did_ftplugin"))
  finish
endif
let b:did_ftplugin = 1

nmap gso vi{:!sortcss<CR>
vmap gso i{:!sortcss<CR>
