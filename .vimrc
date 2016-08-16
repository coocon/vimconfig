" An example for a vimrc file.
"
" Maintainer:	Bram Moolenaar <Bram@vim.org>
" Last change:	2002 Sep 19
"
" To use it, copy it to
"     for Unix and OS/2:  ~/.vimrc
"	      for Amiga:  s:.vimrc
"  for MS-DOS and Win32:  $VIM\_vimrc
"	    for OpenVMS:  sys$login:.vimrc

" When started as "evim", evim.vim will already have done these settings.

set nocompatible              " be iMproved, required
filetype off                  " required
"不要临时文件
set noswapfile


filetype plugin indent on    " required


if v:progname =~? "evim"
  finish
endif



set encoding=utf-8
set fileencoding=utf-8
set fileencodings=utf-8,gbk,ucs-bom,cp936
language message zh_CN.UTF-8

" 执行pathogen 
execute pathogen#infect()

" 安装 syntastic 包含eslint等插件
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*
"提示错误 ，但是默认不显示出来 error list
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 0
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0

"开启eslint
let g:syntastic_javascript_checkers = ['eslint']

" Use Vim settings, rather then Vi settings (much better!).
" This must be first, because it changes other options as a side effect.
set nocompatible | filetype indent plugin on | syn on

" allow backspacing over everything in insert mode
set backspace=indent,eol,start

set guioptions-=m
set guioptions-=T

"map <silent> <F4> :if &guioptions =~# 'T' <Bar>
"        \set guioptions-=T <Bar>
"        \set guioptions-=m <bar>
"    \else <Bar>
"        \set guioptions+=T <Bar>
"        \set guioptions+=m <Bar>
"    \endif<CR>

set nobackup		" do not keep a backup file, use versions instead

set history=50		" keep 50 lines of command line history
set ruler		" show the cursor position all the time
set showcmd		" display incomplete commands
set incsearch		" do incremental searching

set autoindent
set expandtab
set tabstop=4
set shiftwidth=4
set softtabstop=4
set nu
set linespace=4

set autochdir
set noerrorbells

colorscheme yytextmate
set guifont=menlo:h12

"InsertMode use IME else set imdisable
"need to disable macvim'option(COMMAND+,):  Draw marked text inline
if has('mac')
    set imdisable
    set imsearch=0
    autocmd! CompleteDone  * set imdisable|set iminsert=0 "for macvim
    autocmd! InsertEnter * set noimdisable|set iminsert=0
    autocmd! InsertLeave * set imdisable|set iminsert=0
endif

nmap <S-H> :bp<CR>
nmap <S-L> :bn<CR>
nmap <F2> :nohlsearch<CR>
nmap <F3> :NERDTreeToggle<CR>
nmap <F4> :lopen<CR>
nmap <F5> :JSHint<CR>
nmap <F7> :CtrlP<CR>
nmap <F8> :TagbarToggle<CR>

let g:miniBufExplorerMoreThanOne = 0
let g:neocomplcache_enable_at_startup = 1
let g:vim_markdown_folding_disabled = 1


" For Win32 GUI: remove 't' flag from 'guioptions': no tearoff menu entries
" let &guioptions = substitute(&guioptions, "t", "", "g")

" Don't use Ex mode, use Q for formatting
map Q gq

" This is an alternative that also works in block mode, but the deleted
" text is lost and it only works for putting the current register.
"vnoremap p "_dp

" Switch syntax highlighting on, when the terminal has colors
" Also switch on highlighting the last used search pattern.
if &t_Co > 2 || has("gui_running")
  syntax on
  set hlsearch
endif

" Only do this part when compiled with support for autocommands.
if has("autocmd")

  " Enable file type detection.
  " Use the default filetype settings, so that mail gets 'tw' set to 72,
  " 'cindent' is on in C files, etc.
  " Also load indent files, to automatically do language-dependent indenting.
  filetype plugin indent on

  " Put these in an autocmd group, so that we can delete them easily.
  augroup vimrcEx
  au!

  " For all text files set 'textwidth' to 78 characters.
  " autocmd FileType text setlocal textwidth=78

  au BufRead,BufNewFile *.text set filetype=mkd

  " When editing a file, always jump to the last known cursor position.
  " Don't do it when the position is invalid or when inside an event handler
  " (happens when dropping a file on gvim).
  autocmd BufReadPost *
    \ if line("'\"") > 0 && line("'\"") <= line("$") |
    \   exe "normal g`\"" |
    \ endif

  augroup END

  " do check before save js file
  " autocmd BufWritePre,FileWritePre,FileAppendPre *.js : JSHint
  let g:user_emmet_install_global = 0
  autocmd FileType html,tpl,vm EmmetInstall

else

  set autoindent		" always set autoindenting on

endif " has("autocmd")

" beautify js
function! s:beautify()
    let cmdline = ['%!js-beautify']

    let filename = expand('%')
    let suffix = strpart(filename, stridx(filename, '.') + 1)

    if (suffix == 'css')
        call add(cmdline, ' --type css')
        call add(cmdline, ' --no-preserve-newlines')
    elseif ('html|htm|tpl' =~ suffix )
        call add(cmdline, ' --type html')
    endif

    call add(cmdline, ' -')

    silent execute join(cmdline)

endfunction

" vim-airline setting
set laststatus=2
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#whitespace#enabled = 0
let g:airline_left_sep = '»'
"let g:airline_left_sep = '▶'
let g:airline_right_sep = '«'
"let g:airline_right_sep = '◀'
if !exists('g:airline_symbols')
    let g:airline_symbols = {}
endif
"let g:airline_symbols.linenr = '␊'
"let g:airline_symbols.linenr = '␤'
let g:airline_symbols.linenr = '¶'
let g:airline_symbols.branch = '⎇'
let g:airline_symbols.paste = 'ρ'
"let g:airline_symbols.paste = 'Þ'
"let g:airline_symbols.paste = '∥'
let g:airline_symbols.whitespace = 'Ξ'

