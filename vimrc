"###########################
"   xatier's vimrc
"###########################

"###########################################################################
" General settings
"###########################################################################

" syntax highlight
syntax enable
filetype plugin indent on


" no line number
"set number


" make tab = four spaces
" auto/smart indentation
set smarttab
set expandtab
set tabstop=4
set softtabstop=4
set shiftwidth=4
set autoindent
set smartindent


" highlight search results and ignore case
set hlsearch
set ignorecase
set smartcase
set incsearch
set gdefault


" load built-in matchit plugin, % to jump between matched if-else pairs
" make < and  > as a pair, useful in C++
runtime macros/matchit.vim
set showmatch
set matchpairs+=<:>


" don't do auto indent while pasting
"set paste
set pastetoggle=<F3>


" automatically read the file again when it changed outside vim
set autoread


" tty settings, no bells
set ttyfast
set title
set noerrorbells
set novisualbell


" increase tab page max
set tabpagemax=99


" undo
set undofile
set undodir=~/.vim/undo


" include defined name or macro
set complete+=d


" better vimdiff behavior
set diffopt+=algorithm:histogram,indent-heuristic


"###########################################################################
" color settings
"###########################################################################

" colorscheme
colorscheme ron
" using ':colo [tab]' to change colorscheme


" line break
set colorcolumn=80
highlight ColorColumn ctermbg=red


" highlight trailing whitespace, [spaces]+[tab] and [tab]+[space]
au BufNewFile,BufRead * highlight ExtraWhitespace ctermbg=red
au BufNewFile,BufRead * match ExtraWhitespace /\s\+$\| \+\ze\t\|\t\+\ze /


" diff highlight
highlight DiffAdd    cterm=bold ctermfg=green ctermbg=17
highlight DiffDelete cterm=bold ctermfg=red ctermbg=17
highlight DiffChange cterm=bold ctermfg=green ctermbg=17
highlight DiffText   cterm=bold ctermfg=green ctermbg=88



"###########################################################################
" statusline and cursorline
"###########################################################################

set laststatus=2
set statusline=\ %F%m%r%y[%{strlen(&fenc)?&fenc:&enc}]%h%w%=[%l,%3v]\ --%p%%--\ \  
highlight  statusline ctermfg=darkmagenta ctermbg=darkcyan
set wildmenu
set wildignore=*.o,*~,*.pyc
set wildignorecase


set cursorline
set cursorcolumn
highlight CursorLine term=none cterm=none ctermbg=none ctermbg=none
highlight CursorColumn term=none cterm=none ctermbg=none ctermbg=none
au InsertEnter * highlight CursorLine term=none cterm=underline
au InsertEnter * highlight CursorColumn term=none ctermbg=darkblue
au InsertLeave * highlight CursorLine term=none cterm=none ctermbg=none
au InsertLeave * highlight CursorColumn term=none cterm=none ctermbg=none



"###########################################################################
" key mapping and autocmd
"###########################################################################

" allow backspacing over autoindent, EOL, and start of insert
set backspace=indent,eol,start


" F7 to close syntax high-lighting
nnoremap <F7> :if exists("syntax_on") <BAR>
\ syntax off <BAR><CR>
\ else <BAR>
\ syntax enable <BAR>
\ endif <CR>


" K to lookup current word in documentations
au FileType perl nnoremap K :!perldoc <cword> <bar><bar> perldoc -f <cword><CR><CR>
au FileType python nnoremap K :!pydoc <cword> <bar><bar> pydoc -k <cword><CR><CR>


" Ctrl-L clear search results highlighting
nnoremap <silent><c-l> :nohl<cr><c-l>


" start an external command with a single bang
nnoremap ! :!


" sudo write
cnoremap w!! w !sudo tee %


" annoying window
nnoremap q: :q


" annoying Ex mode
nnoremap Q <Nop>


" open a new tab on gf
nnoremap gf <c-w>gf


" keep virtual mode in
vnoremap > >gv
vnoremap < <gv


" open terminal on bottom right
cnoreabbrev terminal botright terminal


" set no expandtab in Makefiles and Go
au FileType make,go setlocal noexpandtab


" set spell in Markdown notes
au FileType markdown setlocal spell


" set spell while git committing
au BufNewFile,BufRead COMMIT_EDITMSG setlocal spell


" highlight tabs
au FileType c,cpp,perl,python setlocal list listchars=tab:>>


" yaml
au FileType yaml setlocal ts=2 sts=2 sw=2 expandtab


" remove trailing whitespace before saving codes
fun! <SID>StripTrailingWhitespaces()
    let l = line('.')
    let c = col('.')
    %s/\s\+$//e
    call cursor(l, c)
endfun
au FileType c,cpp,perl,python,go au BufWritePre <buffer> :call <SID>StripTrailingWhitespaces()

"###########################################################################
" multi-encoding setting
"###########################################################################

if has('multi_byte')
    set fileencodings=ucs-bom,utf-8,big5,gb2312,latin1
    set encoding=utf-8
    set termencoding=utf-8
    set fileencoding=utf-8
    set ambiwidth=double
else
    echoerr 'Sorry, this version of (g)vim was not compiled with multi_byte'
endif


"###########################################################################
" plugins
"###########################################################################
" Load all plugins now.
" Plugins need to be added to runtimepath before helptags can be generated.
packloadall
" Load all of the helptags now, after plugins have been loaded.
" All messages and errors will be ignored.
silent! helptags ALL


" run ALE manually with :lint
let g:ale_lint_on_enter = 0
cabbrev lint ALELint


" flake8 settings
au FileType python let b:ale_linters = ['flake8']
au FileType python let b:ale_python_flake8_executable = '/home/xatier/work/pip/bin/flake8'
au FileType python let b:ale_python_flake8_auto_pipenv = 1
au FileType python let b:ale_python_flake8_options = '--ignore C408,D1 --show-source --import-order-style=google'
