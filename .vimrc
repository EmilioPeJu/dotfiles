set clipboard=unnamedplus
let mapleader = ","

" change backup dir
set backupdir-=.
set backupdir^=~/tmp,/tmp

call plug#begin()
Plug 'SirVer/ultisnips'
Plug 'justinmk/vim-sneak'
Plug 'tpope/vim-surround'
Plug 'kien/ctrlp.vim'
Plug 'tpope/vim-commentary'
Plug 'scrooloose/nerdtree'
" Plug 'Valloric/YouCompleteMe'
Plug 'python-mode/python-mode'
Plug 'majutsushi/tagbar'
Plug 'milkypostman/vim-togglelist'
call plug#end()

nnoremap gd :YcmCompleter GoTo<cr>
let g:ycm_global_ycm_extra_conf = '~/.vim/.ycm_extra_conf.py'

" set termguicolors
set shell=bash

set number
set ruler

let mapleader = ","
nnoremap <silent> <M-p> :Buffers<cr>

"=====[ ultisnips ]===========================================================
let g:UltiSnipsExpandTrigger="<c-l>"
let g:UltiSnipsJumpForwardTrigger="<c-l>"
let g:UltiSnipsJumpBackwardTrigger="<c-h>"


" Sneak
let g:sneak#label = 1
map <leader>o :BufExplorer<cr>

" buffer
nmap <leader>d :bd!<CR>
nnoremap <leader><leader> <c-^>
nnoremap <C-j> <C-W>j
nnoremap <C-k> <C-W>k
nnoremap <C-h> <C-W>h
nnoremap <C-l> <C-W>l

" Saving and exit
nmap <leader>q :wqa!<CR>
nmap <leader>w :w!<CR>
nmap <leader><Esc> :q!<CR>

set background=dark                         " Use dark background

" Terminal
" tnoremap <esc> <c-\><c-n>
" tnoremap jj <c-\><c-n>

" Tabs
nnoremap <C-Left> 	:tabprevious<CR>
nnoremap <C-Right>	:tabnext<CR>
nnoremap <C-n>	:tabnew<CR>
nnoremap <C-x>	:tabclose<CR>

" vimdiff
nmap <leader>r :diffg RE<CR>
nmap <leader>b :diffg BA<CR>
nmap <leader>l :diffg LO<CR>

" folding
set foldclose=all


" Stuff from mga83
"
set list listchars=tab:»¯,trail:°,extends:»,precedes:«
" When working with wrapped lines (:set wrap) configure line wrap char:
set showbreak=···

highlight SpecialKey ctermfg=Red
highlight Ignore     ctermfg=Grey
highlight NonText    ctermfg=DarkRed

" Tab control
set tabstop=8           " Display hard tabs on 8 space stops
set softtabstop=4       " Treat <Tab> key as four spaces
set shiftwidth=4        " Amount indentation changes on indent commands
set expandtab           " Convert tabs to spaces on insertion
set smarttab            "
set textwidth=80
set colorcolumn=80

" General display settings
set hidden              " Allow switching buffers without writing to disk
set ruler               " Always show cursor position
set title               " Set terminal title to filename
set laststatus=2        " Always show status line
set incsearch           " Incremental search
set wrap                " Show wrapped lines by default

set clipboard=unnamed

" ranger file chooser
function! RangeChooser()
    let temp = tempname()
    " The option "--choosefiles" was added in ranger 1.5.1. Use the next line
    " with ranger 1.4.2 through 1.5.0 instead.
    let ranger = $RANGER
    if ranger == ""
        let ranger = "ranger"
    endif
    exec 'silent !' . ranger . ' --choosefiles=' . shellescape(temp)
    if !filereadable(temp)
        redraw!
        " Nothing to read.
        return
    endif
    let names = readfile(temp)
    if empty(names)
        redraw!
        " Nothing to open.
        return
    endif
    " Edit the first item.
    exec 'edit ' . fnameescape(names[0])
    " Add any remaning items to the arg list/buffer list.
    for name in names[1:]
        exec 'argadd ' . fnameescape(name)
    endfor
    redraw!
endfunction
command! -bar RangerChooser call RangeChooser()
nnoremap <leader>r :<C-U>RangerChooser<CR>

nmap <F8> :TagbarToggle<CR>
nmap <F2> :NERDTreeToggle<CR>

set tags=./.git/tags,.git/tags;
