call plug#begin('~/.vim/plugged')

Plug 'junegunn/goyo.vim'
Plug 'airblade/vim-gitgutter'
Plug 'pangloss/vim-javascript'
Plug 'morhetz/gruvbox'
Plug 'ervandew/supertab'
Plug 'townk/vim-autoclose'
Plug 'vim-airline/vim-airline'

call plug#end()

set tabstop=2
set shiftwidth=2
set expandtab
set autoindent
set showmatch
set incsearch
set number
set nofoldenable    " disable folding
set modeline
set ls=2
set t_Co=256
set listchars=tab:▸\ ,eol:¬
set hlsearch

syntax on

set background=dark
colorscheme gruvbox
let g:gruvbox_contrast_dark='hard'

set shell=bash

" gitgutter
let g:gitgutter_enabled = 1

highlight SignColumn ctermbg=235
highlight GitGutterAdd ctermbg=235
highlight GitGutterChange ctermbg=235
highlight GitGutterDelete ctermbg=235
highlight GitGutterChangeDelete ctermbg=235

" markdown
let g:vim_markdown_folding_disabled=1

" airline
highlight ColorColumn ctermbg=255

" js
let g:javascript_plugin_flow = 1

map ,t :w\|:!mocha %
map ,tr :w\|:!browserify -t reactify -e % > foo.js && mocha foo.js
map ,p :w\|:!python %
map ,y :w\|:!node % 
map ,c :w\|:!echo % \| pbcopy \<cr>
map ,m :w\|:!make && ./bin

map ,b :w\|:!gulp bundle
map ,bw :w\|:!gulp bundle-web
map ,ba :w\|:!gulp bundle-app

map ,gb :Gblame<cr>
map ,gg :Ggrep<cr>
map ,gl :Glog<cr>

" go to last cursor postion if there was one
autocmd BufReadPost *
	\ if line("'\"") > 0 && line("'\"") <= line("$") |
	\ 	exe "normal g`\"" |
	\ endif

" don't use spaces for make files
autocmd FileType make setlocal noexpandtab

au BufNewFile,BufRead *.less set filetype=css
au BufNewFile,BufRead *.json set filetype=js
au BufNewFile,BufRead *.md set filetype=markdown

au BufNewFile,BufRead *.md Goyo

" Show syntax highlighting groups for word under cursor
nmap <C-S-P> :call <SID>SynStack()<CR>
function! <SID>SynStack()
 if !exists("*synstack")
  return
 endif
 echo map(synstack(line('.'), col('.')), 'synIDattr(v:val, "name")')
endfunc


" Quicker window movement
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-h> <C-w>h
nnoremap <C-l> <C-w>l

augroup PatchDiffHighlight
  autocmd!
  autocmd BufEnter *.patch,*.rej,*.diff syntax enable
augroup END
