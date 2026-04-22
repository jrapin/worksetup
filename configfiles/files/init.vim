set nocompatible              " required
filetype off                  " required


" You should install the following packages for everything to work:
" pip install autopep8 pylint flake8 mypy pynvim

" for installing vim-plug
" sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
"        https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'

" let Vundle manage Vundle, required
call plug#begin('~/.vim/plugged')
Plug 'gmarik/Vundle.vim'
Plug 'scrooloose/nerdtree'
Plug 'honza/vim-snippets'
Plug 'w0rp/ale'
" Bundle 'python/black'
Plug 'davidhalter/jedi-vim'
Plug 'jpalardy/vim-slime'
Plug 'altercation/vim-colors-solarized'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'terryma/vim-smooth-scroll'
Plug 'tpope/vim-surround'
Plug 'easymotion/vim-easymotion'
Plug 'tpope/vim-fugitive'
Plug 'rbong/vim-vertical'
Plug 'AndrewRadev/linediff.vim'
Plug 'Vimjas/vim-python-pep8-indent'
Plug 'numirias/semshi', {'do': ':UpdateRemotePlugins'}
call plug#end()
" Make sure to call :PlugInstall and :UpdateRemotePlugins in nvim after changing the list

" YCM or Jedi-vim are similar, one is probably sufficient
" For YouCompleteMe, you must install afterwards:
" cd ~/.vim/bundle/YouCompleteMe
" git pull
" git submodule update --init --recursive
" ./install.py --clang-completer
" or on ubuntu 16:
" python3 ./install.py --clang-completer

" Add all your plugins here (note older versions of Vundle used Bundle instead of Plugin)

" not used anymore:
"Bundle 'scrooloose/syntastic'
"Bundle 'SirVer/ultisnips'
"Bundle 'Valloric/YouCompleteMe'

" All of your Plugins must be added before the following line

" call vundle#end()            " required
filetype plugin indent on    " requiredenable syntax highlighting


"Standard configuration

set nomodeline  " this is to prevent arbitrary code execution security breach

" escaping
" using using jk 
inoremap jk <esc>
inoremap kj <esc>

syntax enable

:let mapleader=" "

" encoding
set encoding=utf-8

" show line numbers
set number

" set tabs to have 4 spaces
set ts=4

" indent when moving to the next line while writing code
set autoindent

" expand tabs into spaces
set expandtab

" when using the >> or << commands, shift lines by 4 spaces
set shiftwidth=4

" show a visual line under the cursor's current line 
set cursorline

" show the matching part of the pair for [] {} and ()
set showmatch

" Ignore case for seaches
" set ignorecase

" Incremental search
set incsearch


" sec spaces
:set listchars=nbsp:·
:set list


set expandtab
set tabstop=4
set shiftwidth=4
map <F2> :retab <CR> :wq! <CR>

"Remap change split screen
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>


" shortcut for changing tab
nnoremap L gt
nnoremap H gT
" nnoremap > gt
" nnoremap < gT


au BufNewFile,BufRead *.py
    \ set tabstop=4 |
    \ set softtabstop=4 |
    \ set shiftwidth=4 |
    \ set expandtab |
    \ set autoindent |
    \ set fileformat=unix |
    \ set nowrap |


" make sure pylint is installed in the virtualenv you use!
" syntastic
"set laststatus = 2
"let g: syntastic_python_checkers = ['flake8']
" make sure pylint is installed in the virtualenv you use!

" let g:black_linelength = 140

" Check Python files with flake8 and pylint.
let g:ale_linters = {'python': ['pyre', 'mypy', 'flake8', 'pylint']}
" Fix Python files with autopep8, could add yapf, black
let g:ale_fixers = {'python': ['remove_trailing_lines', 'trim_whitespace', 'autopep8']}
" Disable warnings about trailing whitespace for Python files.
let b:ale_warn_about_trailing_whitespace=0
let g:ale_python_autopep8_options='--ignore=E402'
" bad continuation is falsely flagged
let g:ale_python_pylint_options='--disable=bad-continuation'
let g:ale_python_mypy_options='--strict --ignore-missing-imports'
" flake8 flags W503, W504 (line break before/after binary operator) which is actually not pep8
" E203 is for ':' position convention in slices (wrong in flake8) 
let g:ale_python_flake8_options='--ignore=W503,W504,E203'
" Set this variable to 1 to fix files when you save them.
let g:ale_fix_on_save=1
" check :ALEInfo for more
" the following lines could be useful
" let b:ale_python_mypy_executable = 'full path' to make it load faster
" let b:ale_python_mypy_use_global = 1  " probably to use the config in the files 
let g:ale_lint_delay = 1000
let g:ale_lint_on_text_changed = 'normal'


" configuration for nerdtree
" active tree shortcut
map <C-n> :NERDTreeToggle<CR>
" ignore tree if it is the last left
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
" ignore files in NERDTree
let NERDTreeIgnore=['\.pyc$', '\~$']


" clipboard from extern applications
set clipboard=unnamed



" C-n for completion
let g:jedi#use_tabs_not_buffers = 1

" Make UltiSnips compatible with YouCompleteMe
function! g:UltiSnips_Complete()
    call UltiSnips#ExpandSnippet()
    if g:ulti_expand_res == 0
        if pumvisible()
            return "\<C-n>"
        else
            call UltiSnips#JumpForwards()
            if g:ulti_jump_forwards_res == 0
               return "\<TAB>"
            endif
        endif
    endif
    return ""
endfunction


" Configurations for autocomplete bundle
" only for specific files
let g:ycm_filetype_whitelist = { 'cpp': 1, 'c': 1, 'python':1 }
" autoclose and go to definition
let g:ycm_autoclose_preview_window_after_completion=1
map <leader>g  :YcmCompleter GoToDefinitionElseDeclaration<CR>
" do not forget to have leader defined
" let g:ycm_server_python_interpreter = '/usr/local/bin/python3'



" slime for sending code to ipython
let g:slime_python_ipython = 1
let g:slime_target = "tmux"
let g:slimux_select_from_current_window = 1
let g:slime_default_config = {"socket_name": "default", "target_pane": ":.1"}
let g:slime_dont_ask_default = 1
" use with tmux! or byobu
" select second pane of current window with 0.1
" useful commands:
" byobu -L <session> attach
" tmux new -s p3
" tmux attach -t p3

" for restarting ipython on left panel:
" (silent execution requires redrawing afterwards)
command IPyRestart silent execute "!byobu-tmux send-keys -t right 'ipython' enter C-l && byobu-tmux send-keys -t right 'exit' enter C-l enter C-l && byobu-tmux send-keys -t right 'ipython' enter C-l" | execute ':redraw!'
map <F10> :IPyRestart<CR>


" solarize (color pattern)
let g:solarized_termtrans = 1
colorscheme solarized 
syntax enable
set background=dark
hi LineNr ctermfg=DarkGrey guifg=#2b506e guibg=#000000
hi PmenuSel ctermfg=DarkGrey guifg=#2b506e guibg=#000000
hi TabLineSel ctermfg=Red ctermbg=DarkGrey

"Pmenu – normal item
"PmenuSel – selected item
"PmenuSbar – scrollbar
"PmenuThumb – thumb of the scrollbar

" CtrlP for opening files easily
let g:ctrlp_map = '<c-p>'
let g:ctrlp_cmd = 'CtrlP'
let g:ctrlp_working_path_mode = 'ra'
" let g:ctrlp_user_command = ['.git/', 'git ls-files --cached --others  --exclude-standard %s']
let g:ctrlp_user_command = ['.git', 'cd %s && git ls-files . -co --exclude-standard', 'find %s -type f']
" use ctrl+t to open in a new tab


" fast and smooth movements
noremap <silent> <c-u> :call smooth_scroll#up(&scroll, 0, 2)<CR>
noremap <silent> <c-d> :call smooth_scroll#down(&scroll, 0, 2)<CR>
noremap <silent> <c-b> :call smooth_scroll#up(&scroll*2, 0, 4)<CR>
noremap <silent> <c-f> :call smooth_scroll#down(&scroll*2, 0, 4)<CR>

" easymotion
map <Leader> <Plug>(easymotion-prefix)


" ZSH like menu
" When you type the first tab, it will complete as much as possible,
" the second tab hit will provide a list, the third
" and subsequent tabs will cycle through completion options
" so you can complete the file without further keys
set wildmode=longest,list,full
" Sweet zsh-like autocompletion menu
set wildmenu

" vertically look for non-empty character
" map <leader>j :Vertical f<CR>
" map <leader>k :Vertical b<CR>
noremap <silent> <c-j> :Vertical f<CR>
noremap <silent> <c-k> :Vertical b<CR>

" set paste mode
set pastetoggle=<F12>


" go to end of copy after copying
vnoremap y y']
vnoremap Y y

" Colorize line numbers in insert and visual modes
" ------------------------------------------------
function! SetCursorLineNrColorInsert(mode)
    " Insert mode: white
    if a:mode == "i"
        highlight CursorLineNr ctermfg=9 
        highlight LineNr ctermfg=9
    " Replace mode: red
    elseif a:mode == "r"
        highlight CursorLineNr ctermfg=1
        highlight LineNr ctermfg=1
    endif
endfunction

function! SetCursorLineNrColorVisual()
    set updatetime=0
    " Visual mode: green
    highlight CursorLineNr cterm=none ctermfg=2
    highlight LineNr cterm=none ctermfg=2
endfunction

function! SetCursorLineNrColorReplace()
    set updatetime=0
    " Replace mode: red
    highlight CursorLineNr cterm=none ctermfg=1
    highlight LineNr cterm=none ctermfg=1
endfunction

function! SetCursorLineNrColorScript()
    set updatetime=0
    " script mode: blue
    highlight CursorLineNr cterm=none ctermfg=4
    highlight LineNr cterm=none ctermfg=4
endfunction

function! ResetCursorLineNrColor()
    set updatetime=4000
    highlight CursorLineNr cterm=none ctermfg=3
    highlight LineNr cterm=none ctermfg=3
endfunction

augroup CursorLineNrColorSwap
    autocmd!
    autocmd InsertEnter * call SetCursorLineNrColorInsert(v:insertmode)
    autocmd InsertLeave * call ResetCursorLineNrColor()
    autocmd CursorHold * call ResetCursorLineNrColor()
augroup END

"today
inoremap <expr> dts strftime("%Y-%m-%d (%a)")
