" vimrc
set nocompatible
source $VIMRUNTIME/vimrc_example.vim
source $VIMRUNTIME/mswin.vim
behave mswin
" ===============================
" Vundle
" {{{
" ===============================
filetype off
if has("mac") || has("unix")
    set runtimepath+=~/.vim/bundle/vundle/
else
    set runtimepath+=$VIM/bundle/vundle/
endif
call vundle#rc()

" let Vundle manage Vundle
Bundle 'gmarik/vundle'
" }}}


" ===============================
" General
" {{{
" ===============================
" With a map leader it's possible to do extra key combinations
" like <leader>w saves the current file
let mapleader = ","
let g:mapleader = ","

" Sets how many lines of history VIM has to remember
set history=500

" Enable filetype plugins
filetype plugin on
filetype indent on

" Set to auto read when a file is changed from the outside
set autoread


" Auto load & fast open vimrc file
autocmd! BufWritePost $MYVIMRC source %
nmap <leader>vimrc :edit $MYVIMRC<cr>
" }}}


" ===============================
" User Interface
" {{{
" ===============================
set number

" Set 5 lines to the cursor - when moving vertically using j/k
set so=5

" Turn on the WiLd menu
set wildmenu

" Height of cmd bar
set cmdheight=2

" A buffer becomes hidden when it is abandoned
set hidden

" Configure backspace so it acts as it should act
set backspace=eol,start,indent
set whichwrap+=<,>,h,l

" Always show current position
set ruler

" Always show the status line
set laststatus=2

" Ignore case when searching
set ignorecase

" When searching try to be smart about cases 
set smartcase

" For regular expressions turn magic on
set magic

" Highlight search results
set hlsearch

" Makes search act like search in modern browsers
set incsearch

" Show matching brackets when text indicator is over them
set showmatch

" How many tenths of a second to blink when matching brackets
set mat=2

" Set list characters
set nolist
set listchars=tab:>-,eol:$

" Set extra options when running in GUI mode
if has("gui_running")
    set guioptions-=T
    set guioptions-=e
endif
" }}}


" ===============================
" Files, backups and undo
" {{{
" ===============================
" Set encodings
" Help file & menu bar display normal
let $LANG='zh_CN.UTF-8'
set encoding=utf-8
set fileencodings=ucs-bom,utf-8,gb2312 
set langmenu=zh_CN.UTF-8
source $VIMRUNTIME/delmenu.vim
source $VIMRUNTIME/menu.vim

" Use Unix as the standard file type
set ffs=unix,dos,mac

" Turn backup off, since most stuff is in SVN, git et.c anyway...
set nobackup
set nowb
set noswapfile

" Fold
set foldmethod=marker
set foldtext={{{,}}}

" Open spell check
set spell

" Complete
" set complete
" }}}

" ===============================
" Colors
" {{{
" ===============================
syntax enable
color desert
" }}}


" ===============================
" Text, tab and indent related
" {{{
" ===============================
" Use spaces instead of tabs
set expandtab

" Be smart when using tabs ;)
set smarttab

" 1 tab == 4 spaces
set shiftwidth=4
set tabstop=4

" Linebreak on 500 characters
set lbr
set tw=500

set autoindent
set smartindent
set wrap
" }}}


" ===============================
" Auto Complete
" ===============================

" ===============================
" Maps
" {{{
" ===============================
" Smart way to move between windows
map <C-j> <C-W>j
map <C-k> <C-W>k
map <C-h> <C-W>h
map <C-l> <C-W>l

" Close the current buffer
map <leader>bd :Bclose<cr>

" Close all the buffers
map <leader>ba :1,1000 bd!<cr>

" Useful mappings for managing tabs
map <leader>tn :tabnew<cr>
map <leader>to :tabonly<cr>
map <leader>tc :tabclose<cr>
map <leader>tm :tabmove

" Useful mappings for split windows
map <leader>vs :vsplit<cr>
map <leader>hs :split<cr>
map <leader>vn :vnew<cr>
map <leader>hn :new<cr>
" }}}


" ===============================
" Plug-in
" {{{
" ===============================
" powerline
" {{{
Bundle 'git://github.com/Lokaltog/vim-powerline.git'
set t_Co=256
let g:Powerline_symbols = 'compatible'
" }}}

" L9 library
" {{{
Bundle 'L9'
" }}}

" Fuzzyfinder
" {{{
Bundle 'FuzzyFinder'
let g:fuf_enumeratingLimit = 5000
map ,ff :FufFile!<cr>
map ,fb :FufBuffer<cr>
let g:fuf_buffer_keyDelete = '<C-d>'
" }}}

" Git Vim
" {{{
Bundle 'git://github.com/motemen/git-vim.git'
"}}}

" SuperTab continue
" {{{
Bundle 'SuperTab-continued.'
let g:SuperTabDefaultCompletionType="<C-X><C-O>"
"}}}

" }}}

" ===============================
" Functions
" {{{
" ===============================
set diffexpr=MyDiff()
function! MyDiff()
  let opt = '-a --binary '
  if &diffopt =~ 'icase' | let opt = opt . '-i ' | endif
  if &diffopt =~ 'iwhite' | let opt = opt . '-b ' | endif
  let arg1 = v:fname_in
  if arg1 =~ ' ' | let arg1 = '"' . arg1 . '"' | endif
  let arg2 = v:fname_new
  if arg2 =~ ' ' | let arg2 = '"' . arg2 . '"' | endif
  let arg3 = v:fname_out
  if arg3 =~ ' ' | let arg3 = '"' . arg3 . '"' | endif
  let eq = ''
  if $VIMRUNTIME =~ ' '
    if &sh =~ '\<cmd'
      let cmd = '""' . $VIMRUNTIME . '\diff"'
      let eq = '"'
    else
      let cmd = substitute($VIMRUNTIME, ' ', '" ', '') . '\diff"'
    endif
  else
    let cmd = $VIMRUNTIME . '\diff'
  endif
  silent execute '!' . cmd . ' ' . opt . arg1 . ' ' . arg2 . ' > ' . arg3 . eq
endfunction

" Don't close window, when deleting a buffer
command! Bclose call <SID>BufcloseCloseIt()
function! <SID>BufcloseCloseIt()
   let l:currentBufNum = bufnr("%")
   let l:alternateBufNum = bufnr("#")

   if buflisted(l:alternateBufNum)
     buffer #
   else
     bnext
   endif

   if bufnr("%") == l:currentBufNum
     new
   endif

   if buflisted(l:currentBufNum)
     execute("bdelete! ".l:currentBufNum)
   endif
endfunction
" }}}
