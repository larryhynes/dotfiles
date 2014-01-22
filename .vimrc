" Set utf-8 encoding
"========================================================================
set encoding=utf-8

" Vundle
" https://github.com/gmarik/vundle
" ======================================================================
set rtp+=~/.vim/bundle/vundle/
call vundle#rc()
Bundle 'gmarik/vundle'
filetype off

" Bundles
" ======================================================================
Bundle 'gregsexton/MatchTag'
Bundle 'vim-scripts/TwitVim'
Bundle 'mattn/emmet-vim'
Bundle 'troydm/easybuffer.vim'
Bundle 'junegunn/goyo.vim'
Bundle 'bling/vim-airline'
Bundle 'kchmck/vim-coffee-script'
Bundle 'altercation/vim-colors-solarized'
Bundle 'leshill/vim-json'
Bundle 'groenewege/vim-less'
Bundle 'terryma/vim-multiple-cursors'
Bundle 'goldfeld/vim-seek'
Bundle 'tpope/vim-vinegar'
Bundle 'vimwiki/vimwiki'
Bundle 'yuratomo/w3m.vim'
Bundle 'rking/ag.vim'
Bundle 'Lokaltog/vim-easymotion'

" Remap leader from / to ,
" =======================================================================
let mapleader = ","

" Remap : to ;
" =======================================================================
nnoremap ; :

" Airline configuration
" https://github.com/bling/vim-airline
" =======================================================================
let g:airline_left_sep = ''
let g:airline_right_sep = ''
let g:airline_enable_branch = 1

" Use the system clipboard by default
" =======================================================================
set clipboard=unnamed

" basic settings, mostly from Steve Losh
" http://stevelosh.com/blog/2010/09/coming-home-to-vim/
" =======================================================================
set nocompatible
syntax enable
set background=dark
colorscheme solarized
set backspace=2
set history=1000
set ruler
set laststatus=2
set number
set relativenumber
set t_co=256
set guifont=Source\ Code\ Pro:h13
set wrap
set textwidth=0
set wrapmargin=0
set linebreak
set nolist
set showmode
set showcmd

" Indentation settings
" =======================================================================
set tabstop=4 "Sets display width of tabs
set shiftwidth=4 "Sets indentation width
set autoindent "Turns on auto-indenting
filetype plugin indent on

" Expand tabs to spaces
" =======================================================================
set expandtab

" Smarter indentation management regardless of tabs/spaces
" =======================================================================
set smarttab

" Show matching brackets
" =======================================================================
set showmatch

" Search settings
" =======================================================================
set hlsearch
set ignorecase
set smartcase
set incsearch
nmap <leader>q :nohlsearch<CR>

" Remap j and k to move through rows as opposed to lines or paragraphs.
" =======================================================================
:nmap j gj
:nmap k gk

" Map <leader>b to call Easy Buffer
" =======================================================================
map <leader>b :EasyBuffer<CR>

" Some stuff for tabs and buffers from http://amix.dk/vim/vimrc.html
" =======================================================================

" Useful mappings for managing tabs
map <leader>tn :tabnew<cr>
map <leader>to :tabonly<cr>
map <leader>tc :tabclose<cr>
map <leader>tm :tabmove

" Opens a new tab with the current buffer's path
map <leader>te :tabedit <c-r>=expand("%:p:h")<cr>/

" Switch CWD to the directory of the open buffer
map <leader>cd :cd %:p:h<cr>:pwd<cr>

" Return to last edit position when opening files (You want this!)
autocmd BufReadPost *
     \ if line("'\"") > 0 && line("'\"") <= line("$") |
     \   exe "normal! g`\"" |
     \ endif

" Remember info about open buffers on close
set viminfo^=%

" Autowrite buffers before switching
set autowriteall

" Toggle paste mode on and off
map <leader>pp :setlocal paste!<cr>

" Pressing ,ss will toggle and untoggle spell checking
map <leader>ss :setlocal spell!<cr>

" When you press <leader>r you can search and replace the selected text
vnoremap <silent> <leader>r :call VisualSelection('replace')<CR>

" Enable wildmenu for auto completion
" =======================================================================
set wildmenu
set wildmode=longest:full,full

" Disable arrow keys, for keeping it realz
" =======================================================================
nnoremap <up> <nop>
nnoremap <down> <nop>
nnoremap <left> <nop>
nnoremap <right> <nop>
inoremap <up> <nop>
inoremap <down> <nop>
inoremap <left> <nop>
inoremap <right> <nop>

" Undo stuff
" =======================================================================
set undofile
set undodir=~/.vim/undo
set undolevels=1000
set undoreload=10000

"Turn on plugin & indentation support for specific filetypes
"=======================================================================
filetype plugin indent on

"Remap emmet (zen) autocomplete
"=======================================================================
let g:user_emmet_expandabbr_key='<C-e>'

"Convert markdown to HTML
"=======================================================================
nnoremap <leader>md :%!/usr/local/bin/Markdown.pl --html4tags <cr>

" Escape/unescape & < > HTML entities in range (default current line)
"=======================================================================
function! HtmlEntities(line1, line2, action)
  let search = @/
  let range = 'silent ' . a:line1 . ',' . a:line2
  if a:action == 0  " must convert &amp; last
    execute range . 'sno/&lsquo;/‘/eg'
    execute range . 'sno/&rsquo;/’/eg'
    execute range . 'sno/&ldquo;/“/eg'
    execute range . 'sno/&rdquo;/”/eg'
    execute range . 'sno/&amp;/&/eg'
  else              " must convert & first
    execute range . 'sno/&/&amp;/eg'
    execute range . 'sno/‘/&lsquo;/eg'
    execute range . 'sno/’/&rsquo;/eg'
    execute range . 'sno/“/&ldquo;/eg'
    execute range . 'sno/”/&rdquo;/eg'
  endif
  nohl
  let @/ = search
endfunction
command! -range -nargs=1 Entities call HtmlEntities(<line1>, <line2>, <args>)
noremap <silent> <leader>h :Entities 0<CR>
noremap <silent> <leader>H :Entities 1<CR>

"use docx2txt.pl to view the content of a .docx file directly.
"=======================================================================
autocmd BufReadPre *.docx set ro
autocmd BufReadPost *.docx %!docx2txt.pl

"Set no backups in /tmp files
"=======================================================================
set backupskip=/tmp/*,/private/tmp/*

"Set status line stuff
"=======================================================================
set ttyfast " enable smoother screen redraw
set listchars=tab:▸\ ,eol:¬ " Use the same symbols as TextMate for tabstops and EOLs

" Clear Registers, using :ClearRegisters
" =======================================================================
function! ClearRegisters()
    let regs='abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789/-="*+'
    let i=0
    while (i<strlen(regs))
        exec 'let @'.regs[i].'=""'
        let i=i+1
    endwhile
endfunction

command! ClearRegisters call ClearRegisters()

" Settings for Taspaper-Vim
" =======================================================================
let g:task_paper_follow_move=0

"Steve Losh split window stuff
" =======================================================================
nnoremap <leader>d <C-w>v<C-w>l
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

"Steve Losh 'save on losing focus'
" =======================================================================
au FocusLost * :wa

"VimWiki, set path and use markdown
" =======================================================================
let g:vimwiki_list = [{'path': '~/Desktop/Dropbox/vimwiki/'}]
let g:vimwiki_list = [{'path': '~/Desktop/Dropbox/vimwiki/',
                    \ 'syntax': 'markdown', 'ext': '.md'}]

" a function to execute formd and return the cursor
" to its original position within the buffer.
"=========================================================================
function! Formd(option)
:let save_view = winsaveview()
:let flag = a:option
:if flag == "-r"
:%! ~/bin/formd -r
:elseif flag == "-i"
:%! ~/bin/formd -i
:else
:%! ~/bin/formd -f
:endif
:call winrestview(save_view)
endfunction

" formd mappings
"=========================================================================
nmap <leader>fr :call Formd("-r")<CR>
nmap <leader>fi :call Formd("-i")<CR>
nmap <leader>ff :call Formd("-f")<CR>

" set undo points so undo from insert mode undoes in sentences, not whole
" paragraphs
" ========================================================================
inoremap . .<C-g>u
inoremap ! !<C-g>u
inoremap ? ?<C-g>u
inoremap : :<C-g>u

" hold selection after in- or out-denting with > and < in visual mode
" ========================================================================
xnoremap < <gv
xnoremap > >gv

" Use markdown syntax highlighting for .md files
" ========================================================================
au BufRead,BufNewFile *.md set filetype=markdown

" Use <leader>tt to remove all trailing whitespaces
" ========================================================================
nmap <leader>tt :%s/\s\+$//<CR>

nmap <leader>c :!cloudapp %<CR>
