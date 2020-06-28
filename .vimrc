set clipboard=unnamedplus
let mapleader = ","

" change backup dir
set backupdir-=.
set backupdir^=~/tmp,/tmp

call plug#begin('~/.vim/plugged')
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'SirVer/ultisnips'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-commentary'
Plug 'scrooloose/nerdtree'
Plug 'majutsushi/tagbar'
Plug 'rust-lang/rust.vim'
Plug 'tpope/vim-fugitive'
" Plug 'python-mode/python-mode'
call plug#end()

" set termguicolors
set shell=bash

set number
set ruler

let mapleader = ","
" coc
nmap <leader>gd <Plug>(coc-definition)
nmap <leader>gr <Plug>(coc-references)

" fzf
nnoremap <C-p> :GFiles<CR>
nnoremap <leader>p :Files<CR>

" ultisnips
let g:UltiSnipsExpandTrigger="<c-l>"
let g:UltiSnipsJumpForwardTrigger="<c-l>"
let g:UltiSnipsJumpBackwardTrigger="<c-h>"

" buffer
nmap <leader>d :bd!<CR>
nmap <leader>; :ls<CR>:b<space>

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
" autocmd BufEnter * :lcd %:p:h

" Auto generate pdf when saving tex files
autocmd BufWritePost *.tex !pdflatex -synctex=1 -interaction=nonstopmode %

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

" ctags
"
" useful shortcuts: C-] to find C-x ] to autocomplete
set tags=./.git/tags,.git/tags;
" cscope
" Extracted from cscope_maps.vim
" Symbols
nmap <C-\>s :cs find s <C-R>=expand("<cword>")<CR><CR>
" Globals
nmap <C-\>g :cs find g <C-R>=expand("<cword>")<CR><CR>
" Calls
nmap <C-\>c :cs find c <C-R>=expand("<cword>")<CR><CR>
" Text
nmap <C-\>t :cs find t <C-R>=expand("<cword>")<CR><CR>
" egrep
nmap <C-\>e :cs find e <C-R>=expand("<cword>")<CR><CR>
" file
nmap <C-\>f :cs find f <C-R>=expand("<cfile>")<CR><CR>
" include file
nmap <C-\>i :cs find i ^<C-R>=expand("<cfile>")<CR>$<CR>
" called
nmap <C-\>d :cs find d <C-R>=expand("<cword>")<CR><CR>
nmap <C-@>s :scs find s <C-R>=expand("<cword>")<CR><CR>
nmap <C-@>g :scs find g <C-R>=expand("<cword>")<CR><CR>
nmap <C-@>c :scs find c <C-R>=expand("<cword>")<CR><CR>
nmap <C-@>t :scs find t <C-R>=expand("<cword>")<CR><CR>
nmap <C-@>e :scs find e <C-R>=expand("<cword>")<CR><CR>
nmap <C-@>f :scs find f <C-R>=expand("<cfile>")<CR><CR>
nmap <C-@>i :scs find i ^<C-R>=expand("<cfile>")<CR>$<CR>
nmap <C-@>d :scs find d <C-R>=expand("<cword>")<CR><CR>
nmap <C-@><C-@>s :vert scs find s <C-R>=expand("<cword>")<CR><CR>
nmap <C-@><C-@>g :vert scs find g <C-R>=expand("<cword>")<CR><CR>
nmap <C-@><C-@>c :vert scs find c <C-R>=expand("<cword>")<CR><CR>
nmap <C-@><C-@>t :vert scs find t <C-R>=expand("<cword>")<CR><CR>
nmap <C-@><C-@>e :vert scs find e <C-R>=expand("<cword>")<CR><CR>
nmap <C-@><C-@>f :vert scs find f <C-R>=expand("<cfile>")<CR><CR>
nmap <C-@><C-@>i :vert scs find i ^<C-R>=expand("<cfile>")<CR>$<CR>
nmap <C-@><C-@>d :vert scs find d <C-R>=expand("<cword>")<CR><CR>

nmap <leader>m :make<CR>

" Rust
let g:rustfmt_autosave = 1

" kind of a hack but +clipboard is not usually set
vnoremap <leader>c :w !xclip -in -selection clipboard<CR><CR>
nnoremap <leader>v :r !xclip -out -selection clipboard<CR>
