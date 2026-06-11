set nocompatible
set termguicolors

set number
set relativenumber

set tabstop=2
set shiftwidth=2
set softtabstop=2
set expandtab

set smartindent
set autoindent

set clipboard=unnamedplus

set updatetime=250

set splitbelow
set splitright

set scrolloff=8

set ignorecase
set smartcase

set nowrap
set signcolumn=no

set hlsearch
set incsearch

set hidden
set autoread
set confirm

filetype plugin indent on
syntax on

set guicursor=n-v-c:block,i-ci-ve:ver15,r-cr:hor20,o:hor50

let mapleader = " "

nnoremap <Esc> :nohlsearch<CR>
nnoremap dd "_dd

nnoremap <C-s> :w<CR>
inoremap <C-s> <Esc>:w<CR>a

nnoremap - :Ex<CR>

nnoremap <leader>t :botright split \| terminal<CR>

nnoremap J 5j
nnoremap K 5k
nnoremap H ^
nnoremap L $

inoremap ( ()<Left>
inoremap [ []<Left>
inoremap { {}<Left>
inoremap " ""<Left>
inoremap ' ''<Left>

nnoremap n nzzzv
nnoremap N Nzzzv

inoremap <C-Space> <C-n>

inoremap <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
inoremap <C-y> <C-y>

augroup yank
autocmd!
autocmd TextYankPost * silent! call matchadd('IncSearch', '\%' . line('.') . 'l\%' . col('.') . 'c')
autocmd TextYankPost * call timer_start(120, { -> clearmatches() })
augroup END

augroup format
autocmd!
autocmd BufWritePre *.py silent !black %
autocmd BufWritePre *.c silent !clang-format -i %
autocmd BufWritePre *.cpp silent !clang-format -i %
augroup END

highlight Normal guibg=NONE ctermbg=NONE
highlight NormalFloat guibg=NONE ctermbg=NONE
highlight NonText guibg=NONE ctermbg=NONE
highlight SignColumn guibg=NONE
