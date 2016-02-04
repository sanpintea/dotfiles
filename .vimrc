set number
set cursorline
set laststatus=2
set showmatch
set list
set listchars=tab:▸\ ,eol:↲,extends:❯,precedes:❮
set backspace=indent,eol,start
set whichwrap=b,s,h,l,<,>,[,]
set confirm
set hidden
set nobackup
set noswapfile


" neobundle settings {{{
if has('vim_starting')
  set nocompatible
  " neobundle をインストールしていない場合は自動インストール
  if !isdirectory(expand("~/.vim/bundle/neobundle.vim/"))
    echo "install neobundle..."
    " vim からコマンド呼び出しているだけ neobundle.vim のクローン
    :call system("git clone git://github.com/Shougo/neobundle.vim ~/.vim/bundle/neobundle.vim")
  endif
  " runtimepath の追加は必須
  set runtimepath+=~/.vim/bundle/neobundle.vim/
endif
call neobundle#begin(expand('~/.vim/bundle'))
let g:neobundle_default_git_protocol='https'

" neobundle#begin - neobundle#end の間に導入するプラグインを記載します。
NeoBundleFetch 'Shougo/neobundle.vim'
" ↓こんな感じが基本の書き方
NeoBundle 'nanotech/jellybeans.vim'
NeoBundle 'Shougo/neomru.vim', {
  \ 'depends' : 'Shougo/unite.vim'
  \ }
NeoBundle 'Shougo/neocomplete.vim'
if has('lua')
	  NeoBundleLazy 'Shougo/neocomplete.vim', {
	      \ 'depends' : 'Shougo/vimproc',
	      \ 'autoload' : { 'insert' : 1,}
	      \ }
  endif

  " neocomplete {{{
  " let g:neocomplete#enable_at_startup               = 1
  " let g:neocomplete#auto_completion_start_length    = 3
  " let g:neocomplete#enable_ignore_case              = 1
  " let g:neocomplete#enable_smart_case               = 1
  " let g:neocomplete#enable_camel_case               = 1
  " let g:neocomplete#use_vimproc                     = 1
  " let g:neocomplete#sources#buffer#cache_limit_size = 1000000
  " let g:neocomplete#sources#tags#cache_limit_size   = 30000000
  " let g:neocomplete#enable_fuzzy_completion         = 1
  " let g:neocomplete#lock_buffer_name_pattern        = '\*ku\*'
  " " }}}
NeoBundle 'Shougo/vimproc'
NeoBundleLazy 'Shougo/vimshell', {
  \ 'depends' : 'Shougo/vimproc',
  \ 'autoload' : {
  \   'commands' : [{ 'name' : 'VimShell', 'complete' : 'customlist,vimshell#complete'},
  \                 'VimShellExecute', 'VimShellInteractive',
  \                 'VimShellTerminal', 'VimShellPop'],
  \   'mappings' : ['<Plug>(vimshell_switch)']
  \ }}

" vimshell {{{
" nmap <silent> vs :<C-u>VimShell<CR>
" nmap <silent> vp :<C-u>VimShellPop<CR>
" " }}}
  " vimrc に記述されたプラグインでインストールされていないものがないかチェックする
NeoBundle 'Townk/vim-autoclose'
  NeoBundleCheck
call neobundle#end()
filetype plugin indent on
" どうせだから jellybeans カラースキーマを使ってみましょう
set t_Co=256
syntax on
colorscheme jellybeans

