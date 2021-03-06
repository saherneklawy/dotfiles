cabbrev W w
cabbrev Q q
cabbrev E Explore

filetype on
filetype plugin on
filetype indent on
set autoindent

set hlsearch
set ignorecase
set nosol

syntax on

" tab stop set to 4 spaces
set ts=2
set shiftwidth=2
if &filetype=='javascript'
  set ts=4
  set shiftwidth=4
endif
" replace tabs with spaces
set expandtab

set mouse=a

set wildmenu
set nowrap
set virtualedit=block " make selection better not bounded to end of lines

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
Bundle "jonathanfilip/vim-lucius"
Bundle 'kien/ctrlp.vim'
Bundle 'aaronbieber/quicktask'
Bundle 'ervandew/supertab'
Bundle 'vim-syntastic/syntastic'
Bundle 'scrooloose/nerdtree'
Bundle 'godlygeek/tabular'
Bundle 'plasticboy/vim-markdown'
Bundle 'tpope/vim-surround'
"Bundle 'bling/vim-airline'
Bundle 'yahiaelgamal/vim-airline'
Bundle 'mileszs/ack.vim'
Bundle "The-NERD-Commenter"
Bundle "tpope/vim-rails"
Bundle 'tpope/vim-fugitive'
Bundle 'bkad/CamelCaseMotion'
Bundle 'vim-scripts/Vim-R-plugin'
Bundle 'editorconfig/editorconfig-vim'
Bundle 'mattn/emmet-vim'
Bundle 'digitaltoad/vim-jade'
Bundle 'fatih/vim-go'
Bundle 'kchmck/vim-coffee-script'

filetype plugin indent on     " required!

set t_Co=256           " Tell vim that my terminal has 256 colors
"set t_AB=\[48;5;%dm
"set t_AF=\[38;5;%dm
"set t_AB=^[[48;5;%dm
"set t_AF=^[[38;5;%dm

colorscheme lucius
" LuciusLightHighContrast
LuciusWhiteHighContrast

set colorcolumn=80     " Long lines are evil
"set cursorline
"set cursorcolumn
"http://vim.wikia.com/wiki/Automatic_word_wrapping
"set tw=80
"set formatoptions+=t

" Horizontal scrolling
set sidescroll=1 " not affecting zl and zh, affecting cursor motion
noremap <Right> 10zl
noremap <Left> 10zh
noremap <Up> 10<C-y>
noremap <Down> 10<C-e>

nnoremap // :noh<cr>

map <C-left> :tabp<CR>
map <C-right> :tabn<CR>
map <C-up> :bp<CR>
map <C-down> :bn<CR>

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
let g:ctrlp_extensions = ['tag', 'line', 'mixed']
let g:ctrlp_use_caching = 1
let g:ctrlp_clear_cache_on_exit = 0

set wildignore+=*.o,*.obj,.git,.bundle,*tmp/**,*app/build/**,*data/**
set wildignore+=*app/assets/images/**,*public/cache/**,*public/mobile_cache/**
set wildignore+=*.png,*.jpg,*.jpeg,*.gif,*.swp,*.swo,*.swn
set wildignore+=*bin/**,*node_modules/**
set wildignore+=*build/**
set wildignore+=*bower_components/**
set wildignore+=*.class

let g:syntastic_ruby_checkers = ['mri', 'rubocop']
let g:syntastic_ruby_rubocop_args = "-R"

let g:syntastic_javascript_checkers = ['eslint']
" execute eslint with --fix flag
"let g:syntastic_javascript_eslint_args = ['--fix']
let g:syntastic_html_checkers = ['tidy']
let g:syntastic_css_checkers = ['csslint']

"let g:SuperTabDefaultCompletionType = "context"

let g:syntastic_mode_map = { 'mode': 'passive',
                           \ 'active_filetypes': [],
                           \ 'passive_filetypes': [] }
let g:syntastic_always_populate_loc_list = 1


au BufRead,BufNewFile *.rabl setfiletype ruby
au BufRead,BufNewFile *.angular setfiletype html

command! Wsudo write !sudo tee %
cabbrev wsudo Wsudo

command! Bda 1,500bdelete
cabbrev bda Bda

command! Adiff windo diffthis
cabbrev adiff Adiff

command! Adiffoff windo diffoff
cabbrev adiffoff Adiffoff

command! -range Bash <line1>,<line2>w !bash
cabbrev bash Bash

nnoremap ,cd :cd %:p:h<CR>:pwd<CR>
" CDC = Change to Directory of Current file
command CDC cd %:p:h
cabbrev cdc CDC

" Comment using NERDCommneter
map <C-l> <leader>c<Space>

nnoremap <C-\> :NERDTreeToggle<CR>
nnoremap \\ :NERDTreeFind<CR>

set laststatus=2
" Statusline
set statusline=%F%m%r%h%w[%L][%{&ff}]%y%{fugitive#statusline()}[%p%%][%04l,%04v]
"              | | | | |  |   |      | |                        |     |    |
"              | | | | |  |   |      | |                        |     |    + current
"              | | | | |  |   |      | |                        |     |       column
"              | | | | |  |   |      | |                        |     +-- current line
"              | | | | |  |   |      | |                        +-- current % into file
"              | | | | |  |   |      | +-- current Branch in square brackets
"              | | | | |  |   |      +-- current syntax in
"              | | | | |  |   |          square brackets
"              | | | | |  |   +-- current fileformat
"              | | | | |  +-- number of lines
"              | | | | +-- preview flag in square brackets
"              | | | +-- help flag in square brackets
"              | | +-- readonly flag in square brackets
"              | +-- modified flag in square brackets
"              +-- full path to file in the buffer

" airline config
let g:airline_left_sep=''
let g:airline_right_sep=''
let g:airline_theme='tomorrow'
let g:airline_branch_prefix = '⎇ '
let g:airline_section_a = '%n %t'
let g:airline_section_y = ''
let g:airline_section_z = '%p%%:%l:%c'

"http://vim.wikia.com/wiki/Encryption
"setlocal cm=blowfish
if has('cryptv') | set cryptmethod=blowfish | endif

let r_syntax_folding = 1
set nofoldenable
let vimrplugin_assign = 0 " make underscore not convert to ->

let g:go_fmt_command = "goimports"
let g:go_fmt_fail_silently = 0
let g:go_highlight_functions = 1
let g:go_highlight_methods = 1
let g:go_highlight_structs = 1
let g:go_highlight_interfaces = 1
let g:go_auto_type_info = 0


if &filetype=='go'
  set noexpandtab
  echo "hi"
endif

set relativenumber
