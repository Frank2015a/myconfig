set nocp   |" set not compitable with vi

set encoding=utf-8
set fileencodings=ucs-bom,utf-8,gb2312,gb18030,gbk,cp936,big5,euc-jp,euc-kr,latin1
set fileencoding=utf-8

"text-object
onoremap af :<C-u>normal! ggVG<CR>
onoremap if :<C-u>normal! ggVG<CR>
vnoremap if :<C-u>normal! ggVG<CR>

"cpp
nnoremap ,m :<C-u>make %:t:r<CR>
nnoremap ,r :<C-u>exec '!./'.expand('%:t:r')<CR>

"buffer
nnoremap gt <C-^>
nnoremap <Space>f :set nomore<Bar>:ls<Bar>:set more<CR>:b<Space>

" below line a shortcut of two line, one for plugin, one for indent
filetype plugin indent on
syntax enable   " syn-on
"indent-option, see " fmt
set tabstop=4       |" Number of spaces that a <Tab> in the file counts for. eg, used for print.
set shiftwidth=4    |" used by '=' and '<' '>' to format indent.
set softtabstop=4   |" used by <BS> in insert mode, and <Tab> for insert tab. If 'smarttab' is on, shiftwidth is used instead.
" set smarttab        |" default off. if on use shiftwidth for <BS>, if off use softtabstop.
set expandtab       |" expand tab for both inserting <Tab> in insert mode, and '=' '>' '<' commands.
set autoindent      |" inherit indent of previous line
set shiftround      |" round space to multiple of shiftwidth
" :retab
set backspace=indent,eol,start   " Set for maximum backspace smartness

set textwidth=82
inoremap <M-s> <Esc>:up<CR>
inoremap <C-f> <Right>
inoremap <C-b> <Left>
inoremap <C-A> <C-O>^
inoremap jk <Esc>
set clipboard=unnamed

set number
set relativenumber
set hidden

" func! Run_lines_as_shell_cmd(lno, n) abort
"     let cmd = shellescape(join( getline(a:lno, a:lno + a:n - 1), "\n"),1)
"     exec "!bash -c ".cmd
" endfunc
func! Run_lines_as_shell_cmd(lno, n) abort
    let first = a:lno
    let last = a:lno + a:n - 1
    exec first.','.last.'w!~/.tmprun'
    exec '!cat ~/.tmprun && echo && bash ~/.tmprun'
endfunc
nnoremap qr :<C-u>call Run_lines_as_shell_cmd(line('.'),v:count1)<CR>

command! -range R exec join(getline(<line1>,<line2>),"\n")
func! Run_lines_as_vimscript() range abort
    " the problem & advantage is run in func scope, global variable not affected.
    exec join(getline(a:firstline, a:lastline),"\n")
endfunc

nnoremap <silent> <space>r :call Run_lines_as_vimscript()<CR>
vnoremap <silent> <space>r :call Run_lines_as_vimscript()<CR>
vnoremap <F2> :<c-u>exec join(getline("'<","'>"),"\n")<CR>
nnoremap <silent> <F2> :<C-u> exec v:count1 == 1 ? getline('.') : join(getline('.',line('.')+(v:count1-1)), "\n") <CR>

execute pathogen#infect()

"ctrlp, see " grep " ignore
" Change the default mapping and the default command to invoke CtrlP: https://github.com/ctrlpvim/ctrlp.vim#basic-options
let g:ctrlp_map = '<Space>p'
let g:ctrlp_cmd = 'CtrlPCurFile'
if executable('ag')
    " below command from https://stackoverflow.com/a/32520039/3625404
                                    " -i --ignore-case        Match case insensitively
    let g:ctrlp_user_command = 'ag %s -i --nocolor --nogroup --hidden
                \ --ignore .git
                \ --ignore .svn
                \ --ignore .hg
                \ --ignore .DS_Store
                \ --ignore "**/*.html|epub"
                \ --ignore "**/*.pyc"
                \ --depth 8
                \ -g ""'
                " --depth 8 is useful for if I accidentally hit ctrl-p while editing a file in my home folder.
    " ag is fast enough that CtrlP doesn't need to cache
    let g:ctrlp_use_caching = 1     " use caching
    let g:ctrlp_clear_cache_on_exit = 1   " enable cross session caching
endif
let g:ctrlp_by_filename = 1
let g:ctrlp_brief_prompt = 1
let g:ctrlp_tilde_homedir = 1
nnoremap ,d :CtrlPDir<CR>
nnoremap ,f :CtrlPMRUFiles<CR>
nnoremap <Space>i :CtrlPBuffer<CR>
" tag search is useful, eg, vim doc, ctags of large C/C++ project.
nnoremap ,t :CtrlPTag<CR>
" CtrlPLastMode not work if invoked via key mapping? works, but the ---dir option may depends on current buffer.
nnoremap ,, :CtrlPLastMode --dir<CR>

set ff=unix

colorscheme evening
inoremap <C-j> <down>
inoremap <C-k> <up>
