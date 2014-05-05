"###########################
"   xatier's vimrc
"###########################

"###########################################################################
" multi-encoding setting
"###########################################################################

if has("multi_byte")
"set bomb
set fileencodings=ucs-bom,utf-8,cp936,big5,euc-jp,euc-kr,latin1
" CJK environment detection and corresponding setting
if v:lang =~ "^zh_CN"
" Use cp936 to support GBK, euc-cn == gb2312
set encoding=cp936
set termencoding=cp936
set fileencoding=cp936
elseif v:lang =~ "^zh_TW"
" cp950, big5 or euc-tw
" Are they equal to each other?
set encoding=big5
set termencoding=big5
set fileencoding=big5
elseif v:lang =~ "^ko"
" Copied from someone's dotfile, untested
set encoding=euc-kr
set termencoding=euc-kr
set fileencoding=euc-kr
elseif v:lang =~ "^ja_JP"
" Copied from someone's dotfile, untested
set encoding=euc-jp
set termencoding=euc-jp
set fileencoding=euc-jp
endif
" Detect UTF-8 locale, and replace CJK setting if needed
if v:lang =~ "utf8$" || v:lang =~ "UTF-8$"
set encoding=utf-8
set termencoding=utf-8
set fileencoding=utf-8
endif
else
echoerr "Sorry, this version of (g)vim was not compiled with multi_byte"
endif

set ambiwidth=double


"###########################################################################
" General settings
"###########################################################################

" syntax highlighting
syntax enable


" line number
"set number


" make tab = four spaces
set expandtab
set tabstop=4
set shiftwidth=4


" highlight search results and ignore case
set hlsearch
set ignorecase
set smartcase
set incsearch


" make < and  > as a pair, useful in C++
set matchpairs+=<:>


" don't do auto indent while pasting
"set paste


" automatically read the file again when it changed outside vim
set autoread


" always show current position (replace this with statusline)
"set ruler


set showmode
set autoindent
set smartindent

" keep virtual mode in
vnoremap > >gv
vnoremap < <gv

filetype plugin indent on

" no bells
set noerrorbells
set novisualbell

" (?)
set showmatch

"###########################################################################
" color settings
"###########################################################################

" colorscheme
colo ron
" using ':colo [tab]' to change colorscheme



" number of colors 256
set t_Co=256


" change line (?)
set colorcolumn=80
hi ColorColumn ctermbg=red

set bg=dark



"###########################################################################
" statusline and cursorline
"###########################################################################

set laststatus=2
set statusline=\ %F%m%r%y[%{strlen(&fenc)?&fenc:&enc}]%h%w%=[%l,%3v]\ --%p%%--\ \  
hi  statusline ctermfg=green ctermbg=darkblue
set wildmenu
set wildignorecase


set cursorline
set cursorcolumn
hi CursorLine term=none cterm=none ctermbg=none ctermbg=none
hi CursorColumn term=none cterm=none ctermbg=none ctermbg=none
au InsertEnter * hi CursorLine term=none cterm=underline
au InsertLeave * hi CursorLine term=none cterm=none ctermbg=none
au InsertEnter * hi CursorColumn term=none ctermbg=darkblue
au InsertLeave * hi CursorColumn term=none cterm=none ctermbg=none


" fix markdown filetype in vim
"  details in /usr/share/vim/vim74/filetype.vim
au BufNewFile,BufRead *.md set filetype=markdown


" highlight trailing whitespaces and spaces before a tab
hi ExtraWhitespace ctermbg=red guibg=red
match ExtraWhitespace /\s\+$\| \+\ze\t/



"###########################################################################
" key mappings
"###########################################################################

" F7 to close syntax high-lighting
map <F7> :if exists("syntax_on") <BAR>
\ syntax off <BAR><CR>
\ else <BAR>
\ syntax enable <BAR>
\ endif <CR>


" for C/C++ files
" F9 to compile, F8 to run, F5 to build
au FileType c map <F9> :!gcc -std=c11 -Wall -Wextra -pedantic -Ofast % -lm -o %:r<CR>
au FileType cpp map <F9> :!g++ -std=c++11 -Wall -Wextra -pedantic -Ofast % -lm -o %:r<CR>
au FileType c,cpp map <F8> :!./%:r<CR>
au FileType c,cpp map <F5> :w<CR> :make<CR>


" K to lookup current word in documentations
" for Perl files
au FileType perl nmap K :!perldoc <cword> <bar><bar> perldoc -f <cword><CR><CR>
" for Python files
au FileType python nmap K :!pydoc <cword> <bar><bar> pydoc -k <cword><CR><CR>
" for Ruby files
au FileType ruby nmap K :!ri <cword><CR><CR>

" set no expandtab in Makefiles
au FileType make setlocal noet

" set spell in Markdown notes
au FileType markdown setlocal spell

" set spell while git committing
au BufNewFile,BufRead COMMIT_EDITMSG setlocal spell


" F5 to run a script
map <F5> :!./%<CR>

" no highlight search
nnoremap <silent><c-l> :nohl<cr><c-l>


" remove trailing whitespaces before saving codes
fun! <SID>StripTrailingWhitespaces()
    let l = line(".")
    let c = col(".")
    %s/\s\+$//e
    call cursor(l, c)
endfun

au FileType c,perl,python,cpp,ruby au BufWritePre <buffer> :call <SID>StripTrailingWhitespaces()

" ctags
set tags=./tags;/
