set notitle
set clipboard=unnamedplus
let mapleader = ","

" change backup dir
set backupdir-=.
set backupdir^=~/tmp,/tmp
set background=dark

call plug#begin('~/.vim/plugged')
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'fannheyward/coc-pyright',
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'SirVer/ultisnips'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-commentary'
Plug 'majutsushi/tagbar'
Plug 'rust-lang/rust.vim'
Plug 'tpope/vim-fugitive'
Plug 'mhinz/vim-startify'
Plug 'rhysd/vim-clang-format'
Plug 'kyazdani42/nvim-tree.lua'
call plug#end()

set autoindent
set autoread
set copyindent
set number
set ruler
set shell=bash
set smartcase
if has('nvim')
    set termguicolors
endif

let mapleader = ","

" Function Keys
nmap <F2> :NvimTreeToggle<CR>
nnoremap <F3> :call QuickFix_toggle()<cr>
nmap <F4> :TagbarToggle<CR>
nnoremap <F5> :CocDiagnostics<CR>
" nmap <F4> :NeoDebug<CR>
" nmap <leader><F4> :NeoDebugStop<CR>

" coc
nmap <leader>gd <Plug>(coc-definition)
nmap <leader>gr <Plug>(coc-references)

" Use K to show documentation in preview window
nnoremap <silent> K :call ShowDocumentation()<CR>

function! ShowDocumentation()
  if CocAction('hasProvider', 'hover')
    call CocActionAsync('doHover')
  else
    call feedkeys('K', 'in')
  endif
endfunction

" fzf
nnoremap <C-p> :Files<CR>
nmap <leader>l :BLines<CR>
nmap <leader>L :Lines<CR>
nnoremap <leader>p :GFiles<CR>
nnoremap <leader>P :Rg<CR>

" buffer
nmap <leader><leader> :Buffers<CR>

" window
nnoremap <C-j> <C-W>j
nnoremap <C-k> <C-W>k
nnoremap <C-h> <C-W>h
nnoremap <C-l> <C-W>l

" Saving and exit
nmap <leader>q :wqa!<CR>
nmap <leader>w :w!<CR>
nmap <leader><Esc> :q!<CR>

" Tabs
nnoremap <C-Left> 	:tabprevious<CR>
nnoremap <C-Right>	:tabnext<CR>
nnoremap <C-n>	:tabnew<CR>
nnoremap <C-x>	:tabclose<CR>

" Quickfix
nnoremap <leader>[ :cp<CR>
nnoremap <leader>] :cn<CR>

" folding
set foldclose=all

" Stuff from mga83
"
" Work relative to current file
" autocmd BufEnter * :lcd %:p:h
cmap cd. lcd %:p:h

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

" Tagbar
let g:tagbar_autofocus = 1

" C/C++ Language
"
" ctags
"
" useful shortcuts: C-] to find C-x ] to autocomplete
set tags=./tags
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

" Rust
let g:rustfmt_autosave = 1

" custom commands
nmap <leader>m :make<CR>

" Terminal
if has('nvim')
    nmap <leader>t :terminal<CR>
    tnoremap <leader><ESC> <C-\><C-n>
endif

" kind of hacky but +clipboard is not usually set
vnoremap <leader>c :w !xclip -in -selection clipboard<CR><CR>
nnoremap <leader>v :r !xclip -out -selection clipboard<CR>

" Nix related
au BufNewFile,BufRead *.nix set filetype=nix

" Python related
au BufNewFile,BufRead *.py call ConfigForPython()

function ConfigForPython()
    set tabstop=4
    set softtabstop=4
    set shiftwidth=4
    set textwidth=79
    set expandtab
    set autoindent
    set fileformat=unix
    setlocal formatoptions+=cro
endfunction

" coc related
let g:coc_disable_startup_warning = 1
inoremap <silent><expr> <C-l>
      \ coc#pum#visible() ? coc#pum#next(1) :
      \ CheckBackspace() ? "\<Tab>" :
      \ coc#refresh()
inoremap <expr><c-h> coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"
inoremap <silent><expr> <CR> coc#pum#visible() ? coc#pum#confirm()
                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"
inoremap <silent><expr> <c-space> coc#refresh()
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" email
autocmd BufNewFile,BufRead /tmp/neomutt* set noautoindent filetype=mail wm=0 tw=78 nonumber digraph nolist nopaste
