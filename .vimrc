set nocompatible
filetype off

" Use utf-8
" =============================================================================
set encoding=utf-8

" Remap leader from / to ,
" =============================================================================
let mapleader = ","

" Remap ; to :
" =============================================================================
nnoremap ; :

" Vundle
" https://github.com/gmarik/Vundle.vim
" =============================================================================
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

Plugin 'gmarik/Vundle.vim'

" Plugins for Vundle
" =============================================================================
Plugin 'altercation/vim-colors-solarized'
Plugin 'christoomey/vim-tmux-navigator'
Plugin 'csexton/jekyll.vim'
Plugin 'davidoc/taskpaper.vim'
Plugin 'dogrover/vim-pentadactyl'
Plugin 'godlygeek/tabular'
Plugin 'gregsexton/MatchTag'
Plugin 'junegunn/goyo.vim'
Plugin 'klen/python-mode'
Plugin 'ledger/vim-ledger'
Plugin 'Lokaltog/vim-easymotion'
Plugin 'mattn/calendar-vim'
Plugin 'mattn/emmet-vim'
Plugin 'mattn/gist-vim'
Plugin 'mattn/webapi-vim'
Plugin 'plasticboy/vim-markdown'
Plugin 'sheerun/vim-polyglot'
Plugin 'Shougo/neomru.vim'
Plugin 'Shougo/unite.vim'
Plugin 'sjl/gundo.vim'
Plugin 'tpope/vim-eunuch'
Plugin 'tpope/vim-fugitive'
Plugin 'tpope/vim-surround'
Plugin 'vim-scripts/TwitVim'
Plugin 'vimwiki/vimwiki'

call vundle#end()

" Use the system clipboard by default
" =============================================================================
set clipboard=unnamed

" basic settings, mostly from Steve Losh
" http://stevelosh.com/blog/2010/09/coming-home-to-vim/
" =============================================================================
syntax enable
syntax on
set background=dark
colorscheme solarized
set backspace=2
set history=1000
set ruler
set number
set relativenumber
set t_Co=256
set guifont=Source\ Code\ Pro:h13
set wrap
set textwidth=0
set wrapmargin=0
set linebreak
set nolist
set showcmd
set visualbell t_vb=
set scrolloff=6 " From https://github.com/skwp/dotfiles/blob/master/vimrc

" Indentation settings
" =============================================================================
set tabstop=4 "Sets display width of tabs
set shiftwidth=4 "Sets indentation width
set autoindent "Turns on auto-indenting
filetype plugin indent on "Allows specific filetypes to manage indents

" Expand tabs to spaces
" =============================================================================
set expandtab

" Smarter indentation management regardless of tabs/spaces
" =============================================================================
set smarttab

" Show matching brackets
" =============================================================================
set showmatch

" Search settings
" =============================================================================
set hlsearch
set ignorecase
set smartcase
set incsearch
nmap <leader>q :nohlsearch<CR>

" Remap j and k to move through rows as opposed to lines or paragraphs.
" =============================================================================
nmap j gj
nmap k gk

"Set statusline stuff and listchars
"Make sense of statuslines here:
"http://got-ravings.blogspot.com/2008/08/vim-pr0n-making-statuslines-that-own.html
" =============================================================================
set laststatus=2  " show the statusline
set ttyfast " enable smoother screen redraw
set listchars=tab:▸\ ,eol:¬,trail:. " Use the same symbols as TextMate for tabstops and EOLs

hi User1 ctermbg=0  ctermfg=yellow guibg=#657b83  guifg=black
hi User2 ctermbg=160   ctermfg=230  guibg=red   guifg=white
hi User3 ctermbg=yellow ctermfg=black   guibg=#657b83 guifg=black

set statusline+=%3*  "set colour User3
set statusline+=[%n]\  "buffer number
set statusline+=%F\  "show path and filename
set statusline+=%1*  "set colour User1
set statusline+=\ %{fugitive#statusline()} "show current branch
set statusline+=%h  "help file flag
set statusline+=%m  "modified flag
set statusline+=%=  "left/right separator
set statusline+=%r\  "read only flag
set statusline+=%2*  "set colour User2
set statusline+=%{StatuslineTrailingSpaceWarning()}  "warn about trailing white space (see below)
set statusline+=%3*  "set colour User3
set statusline+=\ %y "filetype
set statusline+=[%{strlen(&fenc)?&fenc:'none'}, "file encoding
set statusline+=%{&ff}]\  "file format
set statusline+=%c,  "cursor column
set statusline+=%l/%L "cursor line/total lines
set statusline+=\ %P\  "percent through file
set noshowmode  "don't show which mode we're in
" highlight ModeMsg ctermfg=white guifg=white

" Taken directly from
" http://got-ravings.blogspot.ie/2008/10/vim-pr0n-statusline-whitespace-flags.html
" recalculate the trailing whitespace warning when idle, and after saving
autocmd cursorhold,bufwritepost * unlet! b:statusline_trailing_space_warning

" return '[\s]' if trailing white space is detected
" return '' otherwise
function! StatuslineTrailingSpaceWarning()
    if !exists("b:statusline_trailing_space_warning")
        if search('\s\+$', 'nw') != 0
            let b:statusline_trailing_space_warning = '[\s]'
        else
            let b:statusline_trailing_space_warning = ''
        endif
    endif
    return b:statusline_trailing_space_warning
endfunction

" Use a blinking upright bar cursor in Insert mode, a blinking block in normal
if &term == 'xterm-256color' || &term == 'screen-256color'
    let &t_SI = "\<Esc>[5 q"
    let &t_EI = "\<Esc>[1 q"
endif

if exists('$TMUX')
    let &t_EI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=0\x7\<Esc>\\"
    let &t_SI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=1\x7\<Esc>\\"
endif

" Some stuff for tabs and buffers, mostly from http://amix.dk/vim/vimrc.html
" =============================================================================

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

" Toggle paste mode
map <leader>pp :setlocal paste!<cr>

" Always exit paste mode when leaving insert mode
au InsertLeave * set nopaste

" Leader ss to toggle spell checking
map <leader>ss :setlocal spell!<cr>
set spelllang=en_gb

" Allow buffer switching without saving
set hidden

" Enable wildmenu for auto completion
" =============================================================================
set wildmenu
set wildmode=longest:full,full

" Disable arrow keys, for keeping it realz
" =============================================================================
nnoremap <up> <nop>
nnoremap <down> <nop>
nnoremap <left> <nop>
nnoremap <right> <nop>
inoremap <up> <nop>
inoremap <down> <nop>
inoremap <left> <nop>
inoremap <right> <nop>

" Undo stuff
" =============================================================================
set undofile
set undodir=~/.vim/undo
set undolevels=1000
set undoreload=10000

" Settings for unite.vim
" https://github.com/Shougo/unite.vim
" mostly based on
" http://www.codeography.com/2013/06/17/replacing-all-the-things-with-unite-vim.html
" =============================================================================
let g:unite_source_history_yank_enable = 1
nnoremap <leader>f :<C-u>Unite -buffer-name=files file<cr>
nnoremap <leader>b :<C-u>Unite -buffer-name=buffer buffer<cr>
nnoremap <leader>r :<C-u>Unite -buffer-name=mru file_mru<cr>
nnoremap <leader>y :<C-u>Unite -buffer-name=yank history/yank<cr>

autocmd FileType unite call s:unite_settings()
function! s:unite_settings()
    " Enable navigation with control-j and control-k in insert mode
    imap <buffer> <C-j> <Plug>(unite_select_next_line)
    imap <buffer> <C-k> <Plug>(unite_select_previous_line)
endfunction

"Remap emmet (zen) autocomplete
" =============================================================================
let g:user_emmet_expandabbr_key='<C-e>'

"Convert markdown to HTML using Pandoc
" http://johnmacfarlane.net/pandoc/index.html
" =============================================================================
nnoremap <leader>md :%!pandoc -f markdown -t html5 <cr>

" Escape/unescape & < > HTML entities in range (default current line)
" =============================================================================
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

" Don't use vim's zip plugin to browse files, which bothers .docx reading
" http://vimdoc.sourceforge.net/htmldoc/pi_zip.html
" =============================================================================
let g:loaded_zipPlugin= 1
let g:loaded_zip= 1

" use docx2txt.pl to view the content of a .docx file directly.
" http://docx2txt.sourceforge.net/
" =============================================================================
autocmd BufReadPre *.docx set ro
autocmd BufRead *.docx %!docx2txt.pl

" Set no backups in /tmp files
" =============================================================================
set backupskip=/tmp/*,/private/tmp/*

" Clear Registers, using :ClearRegisters
" =============================================================================
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
" https://github.com/davidoc/taskpaper.vim
" =============================================================================
let g:task_paper_follow_move=0
let g:task_paper_styles={'overdue': 'ctermfg=37 guifg=#00afaf', 'today': 'ctermfg=166 guifg=#d75f00'}
nnoremap <buffer> <silent> <Leader>tq
            \    :<C-u>call taskpaper#add_tag('priority')<CR>
nnoremap <buffer> <silent> <Leader>tQ
            \    :<C-u>call taskpaper#delete_tag('priority', '')<CR>

" solarized colours put here for reference
" SOLARIZED HEX     16/8 TERMCOL  XTERM/HEX   L*A*B      sRGB        HSB
" --------- ------- ---- -------  ----------- ---------- ----------- -----------
" base03    #002b36  8/4 brblack  234 #1c1c1c 15 -12 -12   0  43  54 193 100  21
" base02    #073642  0/4 black    235 #262626 20 -12 -12   7  54  66 192  90  26
" base01    #586e75 10/7 brgreen  240 #4e4e4e 45 -07 -07  88 110 117 194  25  46
" base00    #657b83 11/7 bryellow 241 #585858 50 -07 -07 101 123 131 195  23  51
" base0     #839496 12/6 brblue   244 #808080 60 -06 -03 131 148 150 186  13  59
" base1     #93a1a1 14/4 brcyan   245 #8a8a8a 65 -05 -02 147 161 161 180   9  63
" base2     #eee8d5  7/7 white    254 #d7d7af 92 -00  10 238 232 213  44  11  93
" base3     #fdf6e3 15/7 brwhite  230 #ffffd7 97  00  10 253 246 227  44  10  99
" yellow    #b58900  3/3 yellow   136 #af8700 60  10  65 181 137   0  45 100  71
" orange    #cb4b16  9/3 brred    166 #d75f00 50  50  55 203  75  22  18  89  80
" red       #dc322f  1/1 red      160 #d70000 50  65  45 220  50  47   1  79  86
" magenta   #d33682  5/5 magenta  125 #af005f 50  65 -05 211  54 130 331  74  83
" violet    #6c71c4 13/5 brmagenta 61 #5f5faf 50  15 -45 108 113 196 237  45  77
" blue      #268bd2  4/4 blue      33 #0087ff 55 -10 -45  38 139 210 205  82  82
" cyan      #2aa198  6/6 cyan      37 #00afaf 60 -35 -05  42 161 152 175  74  63
" green     #859900  2/2 green     64 #5f8700 60 -20  65 133 153   0  68 100  60

"Steve Losh split window stuff
" =============================================================================
nnoremap <leader>d <C-w>v<C-w>l
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

" Steve Losh 'save on losing focus'
" =============================================================================
au FocusLost * :wa

" VimWiki options
" https://github.com/vimwiki/vimwiki
" =============================================================================
let g:vimwiki_list = [{'path': '~/vimwiki/'}]
let g:vimwiki_list = [{'path': '~/vimwiki/',
            \ 'syntax': 'markdown', 'ext': '.md'}]

" A function to execute formd and return the cursor to its original position within the buffer.
" http://drbunsen.github.io/formd/
" =============================================================================
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
nmap <leader>fr :call Formd("-r")<CR>
nmap <leader>fi :call Formd("-i")<CR>
nmap <leader>ff :call Formd("-f")<CR>

" set undo points so undo from insert mode undos in sentences, not whole paragraphs
" =============================================================================
inoremap . .<C-g>u
inoremap ! !<C-g>u
inoremap ? ?<C-g>u
inoremap : :<C-g>u

" hold selection after in- or out-denting with > and < in visual mode
" =============================================================================
xnoremap < <gv
xnoremap > >gv

" Use markdown syntax highlighting for .md files
" =============================================================================
au BufRead,BufNewFile *.md set filetype=markdown

" Use <leader>tr to remove all trailing whitespaces
" =============================================================================
nnoremap <leader>tr :%s/\s\+$//<CR>

" Use <leader>c to upload current file to cloudapp using cloudapp cli
" https://github.com/cloudapp/cloudapp.rb
" =============================================================================
nnoremap <leader>c :!cloudapp %<CR>

" Clip results from :Gist to clipboard
" https://github.com/mattn/gist-vim
" =============================================================================
let g:gist_clip_command = 'pbcopy'

" <leader>nn opens my note file
" =============================================================================
nnoremap <leader>nn :e ~/notes/tandy.txt<cr>

" Settings for twitvim
" https://github.com/vim-scripts/TwitVim
" =============================================================================
let twitvim_force_ssl = 1

" Settings for gundo
" http://sjl.bitbucket.org/gundo.vim/
" =============================================================================
nnoremap <leader>g :GundoToggle<cr>

" Call urlview on a file and list urls for launching in browser
" http://linuxcommand.org/man_pages/urlview1.html
" =============================================================================
nnoremap <leader>u :!urlview "%"<cr>

" Some settings for key speed
" http://usevim.com/2014/07/11/key-speed
" =============================================================================
set timeoutlen=2000 ttimeoutlen=0

" Use paps to pretty print a pdf and open it in Preview.app
" http://paps.sourceforge.net/
" =============================================================================
nnoremap <leader>p :!/usr/local/bin/paps --font='Source Sans Pro 10' --paper=A4 --left-margin=144 "%" \| /usr/bin/open -f -a Preview<cr>

" Support for gpg-encrypted files.
" https://github.com/drmikehenry/vimfiles/blob/9b987c0349c9b1739242369d3e2cd62deacfd28c/vimrc
" =============================================================================
augroup local_encrypted
    " First, remove all autocmds in this group.
    autocmd!
    " First make sure nothing is written to ~/.viminfo while editing
    " an encrypted file.
    autocmd BufReadPre,FileReadPre *.gpg set viminfo=
    " We don't want a swap file, as it writes unencrypted data to disk
    autocmd BufReadPre,FileReadPre *.gpg set noswapfile
    " Switch to binary mode to read the encrypted file
    autocmd BufReadPre,FileReadPre *.gpg set bin
    autocmd BufReadPre,FileReadPre *.gpg let ch_save = &ch|set ch=2
    autocmd BufReadPre,FileReadPre *.gpg let shsave=&sh
    autocmd BufReadPre,FileReadPre *.gpg let &sh='sh'
    autocmd BufReadPre,FileReadPre *.gpg let ch_save = &ch|set ch=2
    autocmd BufReadPost,FileReadPost *.gpg '[,']!gpg --decrypt
                \ --default-recipient-self 2> /dev/null
    autocmd BufReadPost,FileReadPost *.gpg let &sh=shsave
    " Switch to normal mode for editing
    autocmd BufReadPost,FileReadPost *.gpg set nobin
    autocmd BufReadPost,FileReadPost *.gpg let &ch = ch_save|
                \ unlet ch_save
    autocmd BufReadPost,FileReadPost *.gpg execute
                \ ":doautocmd BufReadPost " . expand("%:r")
    " Convert all text to encrypted text before writing
    autocmd BufWritePre,FileWritePre *.gpg set bin
    autocmd BufWritePre,FileWritePre *.gpg let shsave=&sh
    autocmd BufWritePre,FileWritePre *.gpg let &sh='sh'
    autocmd BufWritePre,FileWritePre *.gpg '[,']!gpg --encrypt
                \ --default-recipient-self 2>/dev/null
    autocmd BufWritePre,FileWritePre *.gpg let &sh=shsave
    " Undo the encryption so we are back in the normal text, directly
    " after the file has been written.
    autocmd BufWritePost,FileWritePost *.gpg silent u
    autocmd BufWritePost,FileWritePost *.gpg set nobin
augroup END

" Use blowfish for :X encryption
" https://dgl.cx/2014/10/vim-blowfish
" =============================================================================
set cryptmethod=blowfish2

" Settings for calendar-vim
" https://github.com/mattn/calendar-vim
" =============================================================================
let g:calendar_monday=1
let g:calendar_options='colorcolumn=0'

" Settings for vim-easymotion
" https://github.com/Lokaltog/vim-easymotion
" =============================================================================
let g:EasyMotion_smartcase = 1

" Remember and load folds
" http://vim.wikia.com/wiki/Make_views_automatic
" =============================================================================
au BufWinLeave * silent! mkview
au BufWinEnter * silent! loadview

" Settings for jekyll.vim
" https://github.com/csexton/jekyll.vim
" =============================================================================
let g:jekyll_path = "~/hyde"
map <Leader>jb  :JekyllBuild<CR>
map <Leader>jn  :JekyllPost<CR>
map <Leader>jl  :JekyllList<CR>

" Sum selected numbers
" https://github.com/kana/config/blob/master/vim/personal/dot.vimrc
" =============================================================================
command! -bang -bar -nargs=* -range Sum
            \ <line1>,<line2>call s:cmd_Sum(<bang>0, <f-args>)
function! s:cmd_Sum(banged_p, ...) range
    let field_number = (1 <= a:0 ? a:1 : 1)
    let field_separator = (2 <= a:0 ? a:2 : 0)
    execute a:firstline ',' a:lastline '!awk'
                \ (field_separator is 0 ? '' : '-F'.field_separator)
                \ "'"
                \ 'BEGIN {x = 0}'
                \ '{x = x + $'.field_number '}'
                \ '{if (\!' a:banged_p ') print $0}'
                \ 'END {print x}'
                \ "'"
endfunction

" Settings for vim-markdown
" https://github.com/plasticboy/vim-markdown
" =============================================================================
let g:vim_markdown_frontmatter=1
let g:vim_markdown_folding_disabled=1
