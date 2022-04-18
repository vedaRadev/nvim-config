" The following environment variables need to be defined:
" $VIM_PLUGINS_DIR    - path to directory containing vim plugin installations
" $PYTHON3_HOST_PROG  - path to python3 executable

" Setting $HOME seems to only be necessary for windows machines
if (has('win32'))
  let $HOME = $USERPROFILE
endif

" Note that plugins are loaded in the order they're specified
call plug#begin(fnameescape($VIM_PLUGINS_DIR))
" Unused
" Plug 'gcmt/wildfire.vim'
" Plug 'prettier/vim-prettier', {'do': 'npm install'}
" Plug 'yuttie/comfortable-motion.vim'
" Plug 'othree/yajs.vim'

" Active
Plug 'andrewradev/splitjoin.vim'
" Plug 'ctrlpvim/ctrlp.vim'
Plug 'godlygeek/tabular'
Plug 'junegunn/goyo.vim'
Plug 'junegunn/vim-peekaboo'
Plug 'ludovicchabant/vim-gutentags'
Plug 'mbbill/undotree'
Plug 'nathanaelkane/vim-indent-guides'

if (has('nvim'))
  Plug 'neoclide/coc.nvim', {'branch': 'release'}
  "Plug 'neoclide/coc.nvim', {'branch': 'master', 'do': 'yarn install --frozen-lockfile'}
endif

Plug 'scrooloose/nerdtree'
Plug 'sheerun/vim-polyglot'
Plug 't9md/vim-choosewin'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-surround'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
" Plug 'voldikss/vim-floaterm'
Plug 'wesq3/vim-windowswap'

Plug 'ayu-theme/ayu-vim'
Plug 'kadekillary/Turtles'
Plug 'srcery-colors/srcery-vim'
Plug 'tyrannicaltoucan/vim-deep-space'
call plug#end()

syntax on
set fileformats=unix,dos " remove this for DOS-style line endings
set autoindent
set backspace=eol,indent,start
set breakindent
set cursorline
set encoding=utf-8
set linebreak
set mouse-=a
set noerrorbells
set nohlsearch
set number
set relativenumber
set expandtab
set smarttab
set ts=2
set shiftwidth=0
set sts=0
set smartindent
set textwidth=120
set wrap
set termguicolors
set bdir=$HOME/AppData/Local/nvim-data/backup
set shell=cmd
" set shell=wsl

let ayucolor="dark"
color ayu
" color turtles
" color deep-space
" Adding more contrasting colors so that stuff is more visible on screen
hi normal guibg=black
hi linenr guifg=slategrey
hi cursorline guibg=#292929
hi cursorlinenr guifg=hotpink
hi CocFadeOut guifg=dimgrey

command! W w
command! Q q
command! Qa qa
command! -nargs=0 Prettier :CocCommand prettier.formatFile

let mapleader = ' '
nnoremap <up> <nop>
nnoremap <right> <nop>
nnoremap <left> <nop>
nnoremap <down> <nop>
nnoremap <space> <nop>
nnoremap <bs> <nop>
nnoremap _ <c-w>_
nnoremap <c-=> <c-w>=
nnoremap <leader>= <c-w>=
nnoremap <leader>\| <c-w>\|<c-w>20<
nnoremap <c--> :ChooseWin<cr>
nnoremap <leader>- :ChooseWin<cr>
nnoremap <f1> :set rnu!<cr>
nnoremap <f2> :set hlsearch!<cr>:set hlsearch?<cr>
nnoremap <f3> :set spell!<cr>
nnoremap <f4> :CocList diagnostics<cr>
nnoremap <leader>fls mz[s1z=`z:delm z<cr>
nnoremap <leader>ig :IndentGuidesToggle<cr>
nnoremap <leader>ut :UndotreeToggle<cr>
nnoremap <leader>sp mz<c-v>ip:sort<cr>`z:delm z<cr>
nnoremap <leader>sib mz<s-v>i{:sort<cr>`z:delm z<cr>
nnoremap <leader>O :NERDTreeToggle<cr>
nnoremap <leader>ofd :NERDTreeFind<cr>
nnoremap <leader>gb :Gblame<cr>
nnoremap <leader>esd :CocDiagnostics<cr>

" nnoremap <leader>b :BlamerToggle<cr>
" nnoremap <leader>p[ :CtrlPTag<cr> "super slow with large projects atm
inoremap <Up> <nop>
inoremap <Right> <nop>
inoremap <Left>	<nop>
inoremap <Down>	<nop>
inoremap <s-cr> <esc>O
inoremap <c-cr> <esc>o
vnoremap <space> <nop>
vnoremap <leader>sp :sort<cr>
tnoremap <Esc> <C-\><C-n>

iabbr cosnt const
iabbr costn const
iabbr functino function
iabbr ipmort import

augroup CursorLine
	au!
	au VimEnter * setlocal cursorline
	au WinEnter * setlocal cursorline
	au BufWinEnter * setlocal cursorline
	au WinLeave * setlocal nocursorline
augroup END

" can probably get rid of most of the abbreviations in here
augroup JavascriptCode
	au! 
	au FileType javascript,javascriptreact :iabbr <buffer> clog console.log
	au FileType javascript,javascriptreact :cabbr <buffer> clog console.log
augroup END

augroup MarkdownFiles
  au!

  au FileType markdown :set spell
  au FileType markdown :set tw=0 " don't want auto line breaks in markdown
  au FileType markdown nnoremap <buffer> <leader>mdu- yyp<s-v>r-
  au FileType markdown nnoremap <buffer> <leader>mdu= yyp<s-v>r=
augroup END

"""""""""""""""""""" PLUGIN CONFIG
let g:python3_host_prog = fnameescape($PYTHON3_HOST_PROG)

"""""""""" AIRLINE
let g:airline_powerline_fonts = 0 " enable pretty airline with powerline fonts
let g:airline#extensions#branch#enabled = 1

""" Airline themes
" let g:airline_theme = 'durant'
let g:airline_theme = 'turtles'

let g:airline#extensions#tabline#enabled = 1 " automatically display all buffers when there's only one tab open
let g:airline_section_b = '%{strftime("%H:%M")}'

"""""""""" GUTENTAGS
let g:gutentags_ctags_exclude=['node_modules']
set statusline+=%{gutentags#statusline()}

"""""""""" CHOOSEWIN
let g:choosewin_overlay_enable = 1

"""""""""" CTRLP
let g:ctrlp_custom_ignore = 'node_modules'

"""""""""" SYNTASTIC
set statusline+=%#warningmsg#
set statusline+=%*
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0

"""""""""" NERDTREE
let g:NERDTreeAutoCenter = 0

"""""""""" VIM-PEEKABOO
let g:peekaboo_window = 'vert bo 50new'
let g:peekaboo_delay = 500

"""""""""" FLOATERM
" let g:floaterm_autoinsert = v:false

"""""""""""""""""""" FUNCTIONS
if (has('nvim'))
  function! ToNVimVersion()
    redir => s
    silent! version
    redir END
    return matchstr(s, 'NVIM v\zs[^\n]*')
  endfunction
endif

function! ShowSynStack()
  if !exists("*synstack")
    return
  endif
  echo map(synstack(line('.'), col('.')), 'synIDattr(v:val, "name")')
endfunc

function! ClearInactiveBuffers()
  " list of *all* buffer numbers
  let l:buffers = range(1, bufnr('$'))

  " what tab page are we in?
  let l:currentTab = tabpagenr()
  try
    " go through all tab pages
    let l:tab = 0
    while l:tab < tabpagenr('$')
      let l:tab += 1

      " go through all windows
      let l:win = 0
      while l:win < winnr('$')
        let l:win += 1
        " whatever buffer is in this window in this tab, remove it from
        " l:buffers list
        let l:thisbuf = winbufnr(l:win)
        call remove(l:buffers, index(l:buffers, l:thisbuf))
      endwhile
    endwhile

    " if there are any buffers left, delete them
    if len(l:buffers)
      execute 'bwipeout' join(l:buffers)
    endif
  finally
    " go back to our original tab page
    execute 'tabnext' l:currentTab
  endtry
endfunction
