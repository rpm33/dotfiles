""" set svk filetype
au BufNewFile,BufRead svk-commit*.tmp setf svk

" When editing a file, always jump to the last cursor position
autocmd BufReadPost *
      \ if ! exists("g:leave_my_cursor_position_alone") |
      \     if line("'\"") > 0 && line ("'\"") <= line("$") |
      \         exe "normal g'\"" |
      \     endif |
      \ endif

""" japanese settings
" http://www.kawaz.jp/pukiwiki/?vim#content_1_7
if &encoding !=# 'utf-8'
  set encoding=japan
endif
set fileencoding=japan
if has('iconv')
  let s:enc_euc = 'euc-jp'
  let s:enc_jis = 'iso-2022-jp'
  " check iconv
  if iconv("\x87\x64\x87\x6a", 'cp932', 'euc-jisx0213') ==# "\xad\xc5\xad\xcb"
    let s:enc_euc = 'euc-jisx0213'
    let s:enc_jis = 'iso-2022-jp-3'
  endif
  " build fileencodings
  if &encoding ==# 'utf-8'
    let s:fileencodings_default = &fileencodings
    let &fileencodings = s:enc_jis .','. s:enc_euc .',cp932'
    let &fileencodings = &fileencodings .','. s:fileencodings_default
    unlet s:fileencodings_default
  else
    let &fileencodings = &fileencodings .','. s:enc_jis
    set fileencodings+=utf-8,ucs-2le,ucs-2
    if &encoding =~# '^euc-\%(jp\|jisx0213\)$'
      set fileencodings+=cp932
      set fileencodings-=euc-jp
      set fileencodings-=euc-jisx0213
      let &encoding = s:enc_euc
    else
      let &fileencodings = &fileencodings .','. s:enc_euc
    endif
  endif
  unlet s:enc_euc
  unlet s:enc_jis
endif
" when using svk, set utf-8
autocmd FileType svk :set fileencoding=utf-8

""" syntax highlite
syntax on

""" set options
set background=dark
set tabstop=4
set expandtab
set shiftwidth=4
set shiftround
set formatoptions-=ro
set hidden
set listchars=tab:>-
set list
set nobackup
set ignorecase
set smartcase
set noincsearch
set nohlsearch
set smartindent
set noautoindent
if exists('+autochdir')
  set autochdir
endif
set autoread
set scrolloff=10
"set imoptions=skk,master:/usr/share/skk/SKK-JISYO.L
"set omnifunc=syntaxcomplete#Complete

"
filetype plugin on

""" buffer key mapping
nmap <Space> :MBEbn<CR>
" GNU screen like
" http://hatena.g.hatena.ne.jp/hatenatech/20060515/1147682761
nnoremap ,n       :MBEbn<CR>
nnoremap ,p       :MBEbp<CR>
nnoremap ,c       :new<CR>
nnoremap ,k       :bd<CR>
nnoremap ,s       :IncBufSwitch<CR>
nnoremap ,<Tab>   :wincmd w<CR>
nnoremap ,Q       :only<CR>
nnoremap ,w       :ls<CR>
nnoremap ,,       :e #<CR>
nnoremap ,1   :e #1<CR>
nnoremap ,2   :e #2<CR>
nnoremap ,3   :e #3<CR>
nnoremap ,4   :e #4<CR>
nnoremap ,5   :e #5<CR>
nnoremap ,6   :e #6<CR>
nnoremap ,7   :e #7<CR>
nnoremap ,8   :e #8<CR>
nnoremap ,9   :e #9<CR>

""" completion menu color settings
hi Pmenu ctermbg=8
hi PmenuSel ctermbg=12
hi PmenuSbar ctermbg=0

""" set html template
autocmd BufNewFile *.html 0r $HOME/.vim/templates/skeleton.html

""" svncommand plugin settings
let SVNCommandEnableBufferSetup=1
let SVNCommandAutoSVK='svk'

""" str2numchar plugin settings
vmap <silent> sn :Str2NumChar<CR>
vmap <silent> sh :Str2HexLiteral<CR>

""" perl-support plugin settings
let g:Perl_AuthorName      = 'Taro FUNAKI'
let g:Perl_AuthorRef       = ''
let g:Perl_Email           = 't@33rpm.jp'
let g:Perl_Company         = ''

""" use Man command
runtime ftplugin/man.vim

""" tty mouse settings
"set mouse=a
"set ttymouse=xterm

""" for perl settings
set makeprg=perl\ -wc\ %
map ,ptv <Esc>:'<,'>! perltidy<CR>
nmap <F5> :make<CR>
nmap <F6> :!%<CR>

""" win32 settings
if has('win32')
  set directory=C:\\WINDOWS\\Temp

  let b:autoReload_disable = 1
  command! AutoReloadOFF let b:autoReload_disable = 1
  command! AutoReloadON let b:autoReload_disable = 0

  augroup AutoReload
    au!
    autocmd FileWritePost,BufWritePost * call <SID>AutoReload()
  augroup END

  function! s:AutoReload(...)
    " Check enable
    if exists('b:autoReload_disable') && b:autoReload_disable != 0
      return
    endif
    silent exe '!"C:\\Documents and Settings\\taro\\reload_firefox.ahk"'
  endfunction
endif

""" for changelog settings
if has("autocmd")
    autocmd FileType changelog
    \     map ,n :call InsertChangeLogEntry("Taro FUNAKI", "t@33rpm.jp")<CR>a
endif

function! InsertChangeLogEntry(name, mail)
    if strpart(getline(1), 0, 10) == strftime("%Y-%m-%d")
        execute "normal ggo\<CR>\<TAB>* "
    else
        let s:header = strftime("%Y-%m-%d") . "  " . a:name . "  <" . a:mail . ">"
        execute "normal ggi\<CR>\<CR>\<ESC>kki" . s:header . "\<CR>\<CR>\<TAB>* "
    endif
endfunction

"nmap ,scl :!clview --word <C-R><C-W>\|more<CR>
