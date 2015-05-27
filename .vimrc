set shell=/bin/bash
set nocompatible
filetype off

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

Plugin 'gmarik/Vundle.vim'
Plugin 'kien/ctrlp.vim'

"Plugin 'marcweber/vim-addon-mw-utils'
"Plugin 'tomtom/tlib_vim'
"Plugin 'garbas/vim-snipmate'
"
Plugin 'SirVer/ultisnips'
Plugin 'honza/vim-snippets'
Plugin 'airblade/vim-gitgutter'

Plugin 'chriskempson/vim-tomorrow-theme'
Plugin 'fatih/vim-go'

Plugin 'zah/nimrod.vim'
Plugin 'davidhalter/jedi-vim'

Plugin 'Valloric/YouCompleteMe'

Plugin 'jimenezrick/vimerl'

call vundle#end()

set runtimepath+=$GOROOT/misc/vim

autocmd VimEnter,Colorscheme * :hi IndentGuidesOdd  guibg=white   ctermbg=lightblue
autocmd VimEnter,Colorscheme * :hi IndentGuidesEven guibg=lightgrey ctermbg=darkblue
autocmd BufNewFile,BufRead *.shpaml set filetype=jade

autocmd FileType go compiler go

nnoremap L :tabnext<CR>
nnoremap H :tabprevious<CR>
nnoremap <C-N> :tabnew<CR>

" colorscheme 256-jungle
colorscheme molokai

syntax on

set ruler
set modeline
set ls=2

set scrolloff=8

set noswapfile
set expandtab
set smartindent
set sw=4
set ts=4
set sts=4

set hlsearch
set incsearch

autocmd Filetype html setlocal ts=2 sts=2 sw=2
autocmd Filetype ruby setlocal ts=2 sts=2 sw=2
autocmd Filetype javascript setlocal ts=4 sts=4 sw=4
autocmd FileType go autocmd BufWritePre <buffer> GoFmt

syntax on             " Enable syntax highlighting
filetype on           " Enable filetype detection
filetype indent on    " Enable filetype-specific indenting
filetype plugin on    " Enable filetype-specific plugins

let g:ycm_global_ycm_extra_conf = '~/Workspace/.settings/.ycm_extra_conf.py'
let g:ycm_cache_omnifunc = 0
let g:ycm_confirm_extra_conf = 0

let g:ycm_key_list_select_completion = ['<C-n>', '<Down>']
let g:ycm_key_list_previous_completion = ['<C-p>', '<Up>']

let g:ConqueTerm_FastMode = 1

let g:jsx_ext_required = 0

let $VIMRUNTIME='/usr/share/vim/vim74/'

let g:syntastic_javascript_checkers = ['jsxhint']
let g:syntastic_javascript_jsxhint_exec = 'jsx-jshint-wrapper'

let g:go_fmt_command = "goimports"
vnoremap < <gv
vnoremap > >gv

"nnoremap <C-l> <C-W><C-L>
"nnoremap <C-k> <C-W><C-K>
"nnoremap <C-j> <C-W><C-J>
"nnoremap <C-h> <C-W><C-H>

vnoremap <leader>p "_dP

"inoremap <expr> <C-Space> pumvisible() \|\| &omnifunc == '' ?
"\ "\<lt>C-n>" :
"\ "\<lt>C-x>\<lt>C-o><c-r>=pumvisible() ?" .
"\ "\"\\<lt>c-n>\\<lt>c-p>\\<lt>c-n>\" :" .
"\ "\" \\<lt>bs>\\<lt>C-n>\"\<CR>"
"imap <C-@> <C-Space>


set number
set relativenumber
set backspace=indent,eol,start
set clipboard=unnamed

nnoremap K :call QuickDoc()<CR><CR>
nnoremap <F1> :cw<CR>
"nnoremap <F2> :GundoToggle<CR>
"nnoremap <F3> :Gblame<CR>
"nnoremap <F4> :Gstatus<CR>
"nnoremap <F5> :!git lg1<CR>
"nnoremap <F6> :call Show_snippets()<CR>
nnoremap <F9> :call QuickRun()<CR>


function! QuickDoc()
    if  &ft =="c" || &ft == "cpp"
        !man <C-R><C-W><CR>
    else
        :exec "!/usr/bin/zeal --query ".&ft.":".expand('<cword>')."&"
    endif

endfunction

function! QuickRun()
    if  &ft =="perl" || &ft == "python" || &ft == "ruby"
        !%:p
    elseif &ft == "c"
        !gcc % && ./a.out
    elseif  &ft == "cpp"
        !g++ % -std=c++11 && ./a.out
    elseif &ft == "lisp"
        !clisp < %:p
    elseif &ft == "go"
        !go run %
    elseif &ft == "jsx"
        !jsx --run %
    elseif &ft == "nim"
        !nim compile --run --verbosity:0 %
    endif

endfunction


nnoremap j gj
nnoremap k gk
nnoremap $ g$
nnoremap ^ g^

nnoremap g$ $
nnoremap g^ ^

vnoremap j gj
vnoremap k gk
vnoremap $ g$
vnoremap ^ g^

vnoremap g$ $
vnoremap g^ ^

"let g:ctrlp_by_filename = 1

set laststatus=2
set encoding=utf-8
set t_Co=256
let g:Powerline_symbols = 'fancy'

fun! <SID>StripTrailingWhitespaces()
    let l = line(".")
    let c = col(".")
    %s/\s\+$//e
    call cursor(l, c)
endfun

autocmd BufWritePre <buffer> :call <SID>StripTrailingWhitespaces()
let g:AutoClosePairs = "() {} []"
let g:ctrlp_custom_ignore = {
            \ 'dir': '\v[\/](\.git|node_modules)$'
            \ }

set wildignore+=*/tmp/*,*.so,*.swp,*.zip,*.class     " MacOSX/Linux

let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<tab>"

let mapleader="\\"
nnoremap <Leader>ag     :!ag <C-r><C-w><CR>
nnoremap <Leader>h      :set hlsearch! hlsearch?<CR>
nnoremap <Leader>make   :make<CR>:cw<CR>
nnoremap <leader>l      :GoLint<CR>
nnoremap <Leader>snip   :exec "e ~/.vim/custom/snippets/".&ft.".snippets"<CR>
nnoremap <Leader>buf    :CtrlPBuffer<CR>
nnoremap <leader>d    :YcmCompleter GoToDefinition<CR>

autocmd bufwritepost *.go GoErrCheck


"function Show_snippets() range
"  echo system('filter_snippets '.&ft)
"endfunction

autocmd! CursorHoldI
autocmd! CursorMovedI

set undodir=~/.vim/undodir
set undofile
set undolevels=1000 "maximum number of changes that can be undone
set undoreload=10000 "maximum number lines to save for undo on a buffer reload

set term=screen-256color
