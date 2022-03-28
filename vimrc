"###########################
"   xatier's vimrc
"###########################

"###########################################################################
" General settings
"###########################################################################

" syntax highlight
syntax on
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
set grepprg=ag\ --vimgrep
set grepformat^=%f:%l:%c:%m
command! -nargs=+ Ag execute 'silent grep!' <q-args> | cwindow | redraw!


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

" open quickfix items into new tabs
set switchbuf+=usetab,newtab


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


augroup HighlightTrailingWhitespace
    " highlight trailing whitespace, [spaces]+[tab] and [tab]+[space]
    autocmd!
    autocmd BufNewFile,BufRead * highlight ExtraWhitespace ctermbg=red
    autocmd BufNewFile,BufRead * match ExtraWhitespace /\s\+$\| \+\ze\t\|\t\+\ze /
augroup END


"###########################################################################
" diffmode settings
"###########################################################################

if &diff
    " jump to next/previous change
    nnoremap ] ]c
    nnoremap [ [c

    " diff highlight
    highlight DiffAdd    cterm=bold ctermfg=green ctermbg=17
    highlight DiffDelete cterm=bold ctermfg=red ctermbg=17
    highlight DiffChange cterm=bold ctermfg=green ctermbg=17
    highlight DiffText   cterm=bold ctermfg=green ctermbg=88
endif


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
augroup HighlightCursorCross
    autocmd!
    autocmd InsertEnter * highlight CursorLine term=none cterm=underline
    autocmd InsertEnter * highlight CursorColumn term=none ctermbg=darkblue
    autocmd InsertLeave * highlight CursorLine term=none cterm=none ctermbg=none
    autocmd InsertLeave * highlight CursorColumn term=none cterm=none ctermbg=none
augroup END


"###########################################################################
" key mapping and autocmd
"###########################################################################

" allow backspacing over autoindent, EOL, and start of insert
set backspace=indent,eol,start


" F7 to close syntax high-lighting
nnoremap <F7> :if exists('g:syntax_on') <BAR>
\ syntax off <BAR><CR>
\ else <BAR>
\ syntax enable <BAR>
\ endif <CR>


augroup KeywordLookup
    " K to lookup current word in documentations
    autocmd!
    autocmd FileType perl nnoremap K :!perldoc <cword> <bar><bar> perldoc -f <cword><CR><CR>
    autocmd FileType python nnoremap K :!pydoc <cword> <bar><bar> pydoc -k <cword><CR><CR>
augroup END


" Ctrl-L clear search results highlighting
nnoremap <silent><c-l> :nohlsearch<CR><C-L>


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


" open Split&Explore on the left
cnoreabbrev sex Sexplore!


" remap fzf to FZF, easier to type `fzf`
cnoreabbrev fzf FZF


" search the current word
nnoremap S :Ag <cword><CR>


" open file with fzf super power
" make `enter` open in a new tab as well
let g:fzf_action = {
  \ 'enter': 'tab split',
  \ 'ctrl-t': 'tab split',
  \ 'ctrl-x': 'split',
  \ 'ctrl-v': 'vsplit' }
nnoremap <silent><C-p> :FZF<CR>


augroup SetLocal
    autocmd!
    " set no expandtab in Makefiles and Go
    autocmd FileType make,go setlocal noexpandtab

    " set spell in Markdown notes
    autocmd FileType markdown setlocal spell

    " set spell while git committing
    autocmd BufNewFile,BufRead COMMIT_EDITMSG setlocal spell

    " highlight tabs
    autocmd FileType c,cpp,perl,python setlocal list listchars=tab:>>

    " yaml
    autocmd FileType yaml setlocal tabstop=2 softtabstop=2 shiftwidth=2 expandtab
augroup END


" remove trailing whitespace before saving codes
fun! <SID>StripTrailingWhitespaces()
    let l = line('.')
    let c = col('.')
    %s/\s\+$//e
    call cursor(l, c)
endfun
augroup StripTrailingWhitespacesCmd
    autocmd!
    autocmd FileType c,cpp,perl,python,go au BufWritePre <buffer> :call <SID>StripTrailingWhitespaces()
augroup END

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

" ALE completion settings
let g:ale_completion_autoimport = 1
let g:ale_completion_enabled = 1
set omnifunc=ale#completion#OmniFunc

" ALE echo message format
let g:ale_echo_msg_error_str = 'E'
let g:ale_echo_msg_warning_str = 'W'
let g:ale_echo_msg_format = '[%linter%] %s [%severity%]'

" ALE flake8 settings
augroup Flake8Settings
    autocmd!
    autocmd FileType python let b:ale_linters = ['flake8']
    autocmd FileType python let b:ale_python_flake8_executable = '/home/xatier/work/pip/bin/flake8'
    autocmd FileType python let b:ale_python_flake8_auto_pipenv = 1
    autocmd FileType python let b:ale_python_flake8_options = '--ignore C408,D1 --show-source --import-order-style=google'
augroup END
