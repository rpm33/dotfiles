set omnifunc=rubycomplete#Complete
" * ~ end block
nmap vab 0/end<CR>%V%0
" def ~ end block
nmap vam $?\%(.*#.*def\)\@!def<CR>%V%0
" class ~ end block
nmap vac $?\%(.*#.*class\)\@!class<CR>%V%0
" module ~ end block
nmap vaM $?\%(.*#.*module\)\@!module<CR>%V%0
