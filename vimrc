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
if v:progname =~? "evim"
  finish
endif

set encoding=utf-8
set fileencoding=utf-8
set fileencodings=utf-8,gbk,ucs-bom,cp936
language message zh_CN.UTF-8

execute pathogen#infect()

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

nmap <F2> :nohlsearch<CR>
nmap <F3> :NERDTreeToggle<CR>
nmap <F4> :JSBeautify<CR>
nmap <F5> :JSHint<CR>
nmap <F8> :TagbarToggle<CR>

let g:miniBufExplorerMoreThanOne=0

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
  autocmd FileType text setlocal textwidth=78

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

command! JSBeautify call s:beautify()
