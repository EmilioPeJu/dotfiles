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
call plug#end()

nnoremap gd :YcmCompleter GoTo<cr>
let g:ycm_global_ycm_extra_conf = '~/.vim/.ycm_extra_conf.py'

" set termguicolors
set shell=zsh

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
map f <Plug>Sneak_f
map F <Plug>Sneak_F
map t <Plug>Sneak_t
map T <Plug>Sneak_T
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

inoremap jj <ESC>
nnoremap <C-Left> 	:tabprevious<CR>
nnoremap <C-Right>	:tabnext<CR>
nnoremap <C-n>	:tabnew<CR>
nnoremap <C-x>	:tabclose<CR>
