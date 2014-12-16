set showcmd
set showmatch
set incsearch
set hlsearch
set infercase
set nojoinspaces
set autoindent
set copyindent
set smartindent
set number
set shiftwidth=2
set tabstop=2
set splitright
set softtabstop=2
set shiftround
set smarttab
set expandtab
set ruler
set title
set icon
set scrolloff=5
set showmode
set sidescroll=5
set nowrap
set cursorline

set nocompatible
syntax on
set background=dark
colorscheme solarized
filetype plugin indent on

let clj_highlight_builtins = 1

" .m files are "octave" files
augroup filetypedetect
  au! BufRead,BufNewFile *.m, set filetype=octave
augroup END

" F5 executes the octave script you are editing
autocmd FileType octave map <buffer> <f5> ggOpkg load all<esc>Gopause<esc>:w<cr>:!octave -qf %<cr>ddggdd:w<cr>
