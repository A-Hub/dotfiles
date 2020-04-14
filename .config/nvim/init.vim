"move .vim into .config/vim/
"set undodir=$XDG_DATA_HOME/vim/undo
"set directory=$XDG_DATA_HOME/vim/swap
"set backupdir=$XDG_DATA_HOME/vim/backup
"set viewdir=$XDG_DATA_HOME/vim/view
"set viminfo+='1000,n$XDG_DATA_HOME/vim/viminfo
"set runtimepath=$XDG_CONFIG_HOME/vim,$VIMRUNTIME,$XDG_CONFIG_HOME/vim/after


"if empty(glob('$XDG_DATA_HOME/vim/autoload/plug.vim'))
"  silent !curl -fLo $XDG_DATA_HOME/vim/autoload/plug.vim --create-dirs
"    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
"  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
"endif

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
Plug 'dracula/vim', { 'as': 'dracula' }
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
