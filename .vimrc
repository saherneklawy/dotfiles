cabbrev W w
cabbrev Q q
cabbrev E Explore

filetype on
filetype plugin on
filetype indent on
set autoindent

set hlsearch
set ignorecase

syntax on

" tab stop set to 4 spaces
set ts=2
set shiftwidth=2
" replace tabs with spaces
set expandtab

set mouse=a

set wildmenu
set nowrap

" vundler setup
set nocompatible               " be iMproved
filetype off                   " required!
set rtp+=~/.vim/bundle/vundle/
call vundle#rc()
" let Vundle manage Vundle
" required! 
Bundle 'gmarik/vundle'

" My Bundles here:
"
" original repos on github
Bundle 'chriskempson/vim-tomorrow-theme'
Bundle 'kien/ctrlp.vim'
Bundle 'aaronbieber/quicktask'
Bundle 'ervandew/supertab'
Bundle 'scrooloose/syntastic'
Bundle 'scrooloose/nerdtree'
"Bundle 'hallison/vim-markdown'
Bundle 'plasticboy/vim-markdown'

filetype plugin indent on     " required!

set t_Co=256           " Tell vim that my terminal has 256 colors

" Horizontal scrolling
set sidescroll=1 " not affecting zl and zh, affecting cursor motion
noremap <Right> 10zl
noremap <Left> 10zh
noremap <Up> 10<C-y>
noremap <Down> 10<C-e>

" spell checker
"set spell

" enables show line numbers
"set number

" showing white spaces, to disable use ":set nolist"
:set listchars=tab:>-,trail:~,extends:>,precedes:<
:set list

" auto cd to open file dir
"set autochdir
":autocmd BufEnter * if bufname("") !~ "^\[A-Za-z0-9\]*://" | lcd %:p:h | endif

" auto save/load file state
au BufWinLeave * silent! mkview
au BufWinEnter * silent! loadview

" copy and paste
" nmap <C-V> "+gP
" imap <C-V> <ESC><C-V>i
vnoremap <C-C> "+y

if has('unnamedplus') " needs installation of gvim
  set clipboard=unnamedplus
else
  set clipboard=unnamed
endif

"" =============== python configuration start ===============================
"if !exists("autocommands_loaded")
"  let autocommands_loaded = 1
"  autocmd BufRead,BufNewFile,FileReadPost *.py source ~/.vim/python
"endif
"
"" This beauty remembers where you were the last time you edited the file, and returns to the same position.
"au BufReadPost * if line("'\"") > 0|if line("'\"") <= line("$")|exe("norm '\"")|else|exe "norm $"|endif|endif
"
"autocmd BufRead,BufNewFile *.py set foldmethod=indent
"
"" =============== python configuration end =================================
"
"" =============== zen coding config start ==============================
"let g:user_zen_settings = {
"            \    'indentation': '    '
"            \}
"" =============== zen coding config end  ==============================

" set runtimepath^=~/.vim/bundle/ctrlp.vim

let g:ctrlp_working_path_mode = 'ra'

set wildignore+=*.o,*.obj,.git,.bundle,*tmp/**,*app/assets/images/**,*.png,*.jpg,*.jpeg,*.gif,*.swp,*.swo,*.swn,*bin/**

let g:syntastic_ruby_checkers = ['mri', 'rubocop']
let g:syntastic_ruby_rubocop_args = "-R"

let g:syntastic_javascript_checkers = ['gjslint', 'jshint']
let g:syntastic_html_checkers = ['tidy']
let g:syntastic_css_checkers = ['csslint']



au BufRead,BufNewFile *.rabl setfiletype ruby
au BufRead,BufNewFile *.angular setfiletype html

command Wsudo write !sudo tee %
cabbrev wsudo Wsudo
