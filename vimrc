" based on http://github.com/jferris/config_files/blob/master/vimrc

call pathogen#runtime_append_all_bundles()
call pathogen#helptags()

" Basic conf
set nocompatible       " Use Vim settings instead of Vi settings. Must be first
set number             " Display line numbers
set numberwidth=5      " Use 5 char line number area
set scrolloff=3        " Always display 3 lines above/below cursor when scrolling
set nowrap             " Never wrap lines
set title              " Display filename as window title
set ruler              " Show the cursor position all the time
set showcmd            " Display incomplete commands as you type in statusbar
set laststatus=2       " Always display the status line
set visualbell         " Disable annoying bell sound on error
set mouse=a            " Enable mouse support
set ff=unix,dos        " Prefer unix line endings
let mapleader = "\\"   " \ is the leader character
let g:mapleader = "\\"

let g:zenburn_high_Contrast=1
colorscheme zenburn     " HighContrast version of the zenburn Color scheme

" Display extra whitespace
set list
set listchars=tab:>.,trail:.,extends:#,nbsp:.

" Support tab completion when writing commands
set wildmode=list:longest,list:full

" Search behaviour
set ignorecase         " Ignore case in regex search
set smartcase          " Do not ignore case when regex has upper case letters
set hlsearch           " Highlight search terms
set incsearch          " Do incremental searching
nnoremap <CR> :noh<CR><CR>

" Tab behaviour
set smartindent
set tabstop=2
set shiftwidth=2
set expandtab

" Persistent undo
try
  set undodir=~/.vim/undodir
  set undofile
  set undolevels=1000  " maximum number of changes that can be undone
  set undoreload=10000 " maximum number of lines to save for undo on buffer reload
catch
endtry

" Intuitive backspacing in insert mode
set backspace=indent,eol,start

" Backup, temporary and swap file behaviour
set nobackup
set nowritebackup
set backupdir=$TEMP,$TMP,.
set directory=$TEMP,$TMP,.

" File type highlighting and configuration.
syntax on
filetype off    " For pathogen to work properly.
filetype plugin indent on

" Only do this part when compiled with support for autocommands.
if has("autocmd")
  " Put these in an autocmd group
  augroup vimrcEx
    " Remove all autocommands (support reloading vimrc)
    autocmd!

    " Set File types based on extension
    autocmd BufNewFile,BufRead *.txt setfiletype text
    autocmd BufNewFile,BufRead *.less setfiletype less

    " Apply custom settings for file types
    autocmd FileType text,markdown,html,xhtml,eruby setlocal wrap linebreak nolist
    autocmd FileType javascript set softtabstop=2|set shiftwidth=2|set expandtab
    autocmd FileType html,xml set listchars-=tab:>.

    " When editing a file, always jump to the last known cursor position.
    " Don't do it when the position is invalid or when inside an event handler
    " (happens when dropping a file on gvim).
    autocmd BufReadPost *
      \ if line("'\"") > 0 && line("'\"") <= line("$") |
      \   exe "normal g`\"" |
      \ endif

    " Automatically load .vimrc source when saved
    autocmd BufWritePost .vimrc source $MYVIMRC
  augroup END
endif

if has("gui_running")
  if has("gui_gtk2")
    set guifont=Courier\ New\ 11
  elseif has("gui_photon")
    set guifont=Courier\ New:s11
  elseif has("gui_kde")
    set guifont=Courier\ New/11/-1/5/50/0/0/0/1/0
  elseif has("x11")
    set guifont=-*-courier-medium-r-normal-*-*-180-*-*-m-*-*
  else
    set guifont=Courier_New:h11:cDEFAULT
  endif
endif
set encoding=utf-8
setglobal nobomb

" Opens an edit command with the path of the currently edited file filled in
" Normal mode: <Leader>e
map <Leader>e :e <C-R>=expand("%:p:h") . "/" <CR>

map <F5> :NERDTreeToggle<CR>
map <F6> :TlistToggle<CR>

" Tab/shift-tab for indenting
vmap <Tab> >gv
vmap <S-Tab> <gv
imap <S-Tab> <C-o><<

" Shortcuts to save and close buffer
nmap ss :w<CR>
map qq :q<CR>

nmap . .`[

" Inserts the path of the currently edited file into a command
" Command mode: Ctrl+P
cmap <C-P> <C-R>=expand("%:p:h") . "/" <CR>

" Press Shift+P while in visual mode to replace the selection without
" overwriting the default register
vmap P p :call setreg('"', getreg('0')) <CR>

" Press ^F from insert mode to paste the default register
inoremap <C-F> <C-R>"

" Navigate location list, f.ex. after Ggrep
map <C-J> :cn<CR>
map <C-K> :cp<CR>

" vmap <C-C> :!~/.bin/coffee2js<CR>
" nmap <C-C> V:!~/.bin/coffee2js<CR>

map <C-c> "+y<CR>
map <C-v> "+gP<CR>

" Rename token in file
nnoremap gr gD:%s/<C-R>///gc<left><left><left>

" Ignore filters for miscellaneous plugins.
let NERDTreeIgnore=['\.pyc$','\.class$','\.sock']
set wildignore+=*.pyc,*.class,*.sock,node_modules

" Tags
let g:Tlist_Ctags_Cmd="ctags --exclude='*.js'"
set tags=./tags;
noremap <Leader>ptags :! ~/Code/tools/ptags.py **/*.py<CR>

"Enable and disable mouse support using F12
nnoremap <F12> :call ToggleMouse()<CR>
function! ToggleMouse()
  if &mouse == 'a'
    set mouse=
    set nonumber
    echo "Mouse usage disabled"
  else
    set mouse=a
    set number
    echo "Mouse usage enabled"
  endif
endfunction

" Local config
if filereadable(".vimrc.local")
  source .vimrc.local
endif
