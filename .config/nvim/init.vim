if empty(glob('~/.local/share/nvim/site/autoload/plug.vim'))
  silent !curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin('~/.local/share/nvim/plugged')
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'airblade/vim-gitgutter'
Plug 'tpope/vim-fugitive'
"Plug 'dracula/vim', { 'as': 'dracula' }
Plug 'preservim/nerdtree'
Plug 'davisdude/vim-love-docs'

call plug#end()

"set variables
    let g:airline_powerline_fonts = 1
    let g:airline_theme='base16color'
    let g:airline#extensions#tabline#enabled = 1

"syntax numbers, wildmode
    syntax on
    set ruler
    set number relativenumber
    set wildmode=longest,list,full

"Tab Config
    set expandtab   "converts tabs to spaces
    set shiftwidth=4
    set tabstop=4

"open nerd tree
map <C-n> :NERDTreeToggle<CR>

"split navigation
nnoremap  <silent>   <tab>  :if &modifiable && !&readonly && &modified <CR> :write<CR> :endif<CR>:bnext<CR>
nnoremap  <silent> <s-tab>  :if &modifiable && !&readonly && &modified <CR> :write<CR> :endif<CR>:bprevious<CR>

let vim_markdown_preview_browser='surf'
let vim_markdown_preview_use_xdg_open=1
