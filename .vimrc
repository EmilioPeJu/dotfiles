set clipboard=unnamedplus
let mapleader = ","

" change backup dir
set backupdir-=.
set backupdir^=~/tmp,/tmp

call plug#begin()
Plug 'SirVer/ultisnips'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-commentary'
Plug 'scrooloose/nerdtree'
Plug 'majutsushi/tagbar'
Plug 'milkypostman/vim-togglelist'
Plug 'rust-lang/rust.vim'
Plug 'tpope/vim-fugitive'
call plug#end()

" set termguicolors
set shell=bash

set number
set ruler

let mapleader = ","

"=====[ ultisnips ]===========================================================
let g:UltiSnipsExpandTrigger="<c-l>"
let g:UltiSnipsJumpForwardTrigger="<c-l>"
let g:UltiSnipsJumpBackwardTrigger="<c-h>"

" buffer
nmap <leader>d :bd!<CR>
nmap <leader>; :ls<CR>:b<space>
nmap <leader>n :bn<CR>
nmap <leader>p :bp<CR>

" window
nnoremap <C-j> <C-W>j
nnoremap <C-k> <C-W>k
nnoremap <C-h> <C-W>h
nnoremap <C-l> <C-W>l

" Saving and exit
nmap <leader>q :wqa!<CR>
nmap <leader>w :w!<CR>
nmap <leader><Esc> :q!<CR>

set background=dark                         " Use dark background

" Tabs
nnoremap <C-Left> 	:tabprevious<CR>
nnoremap <C-Right>	:tabnext<CR>
nnoremap <C-n>	:tabnew<CR>
nnoremap <C-x>	:tabclose<CR>

" Quickfix
nnoremap <C-Up> :cp<CR>
nnoremap <C-Down> :cn<CR>

" vimdiff
nmap <leader>r :diffg RE<CR>
nmap <leader>b :diffg BA<CR>
nmap <leader>l :diffg LO<CR>

" folding
set foldclose=all

" Stuff from mga83
"
" Work relative to current file
autocmd BufEnter * :lcd %:p:h
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
set smarttab
au Filetype cpp setl et ts=2 sw=2

" set textwidth=80
set colorcolumn=80

" General display settings
set hidden              " Allow switching buffers without writing to disk
set ruler               " Always show cursor position
set title               " Set terminal title to filename
set laststatus=2        " Always show status line
set incsearch           " Incremental search
set wrap                " Show wrapped lines by default

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

function! QuickFix_toggle()
    for i in range(1, winnr('$'))
            let bnum = winbufnr(i)
            if getbufvar(bnum, '&buftype') == 'quickfix'
                cclose
            return
            endif
        endfor

    copen
endfunction
nnoremap <F5> :call QuickFix_toggle()<cr>

nmap <F2> :NERDTreeToggle<CR>
nmap <F8> :TagbarToggle<CR>

set tags=./.git/tags,.git/tags;

nmap <leader>m :make<CR>

" Rust
let g:rustfmt_autosave = 1
