set nocompatible " must be the first line
filetype off
filetype indent on
filetype plugin on

set rtp+=/home/kuldeeps/.vim/bundle/vundle/
call vundle#begin()
Plugin 'VundleVim/Vundle.vim'
Plugin 'tpope/vim-fugitive'
Plugin 'Lokaltog/powerline', {'rtp': 'powerline/bindings/vim/'}
Bundle 'gmarik/vundle'
Plugin 'kien/ctrlp.vim'
Bundle 'jnurmine/Zenburn'
Plugin 'flazz/vim-colorschemes'
Bundle 'DavidEGx/ctrlp-smarttabs'
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'
Bundle 'edkolev/promptline.vim'
Plugin 'shougo/vimproc'
Plugin 'shougo/vimshell'
Plugin 'tomasr/molokai'
"Plugin 'wincent/terminus'
Plugin 'vim-scripts/Conque-Shell'
Bundle 'jlanzarotta/bufexplorer'
Plugin 'powerline/fonts'

"Plugin 'yegappan/lid'
"Plugin 'dkprice/vim-easygrep'
"Plugin 'vim-scripts/Gundo'
"Plugin 'fs111/pydoc.vim'
"Plugin 'xolox/vim-easytags'
"Plugin 'xolox/vim-misc'
"Plugin 'xolox/vim-session'
"Plugin 'JCLiang/vim-cscope-utils'
"Plugin 'craigemery/vim-autotag'
"Plugin 'fishy/projtags-via'
call vundle#end()

filetype plugin indent on
set laststatus=2
set ofu=syntaxcomplete#Complete
set ignorecase
syntax on


" Powerline setup
if has('gui_running')
   set guifont=DejaVu\ Sans\ Mono\ for\ Powerline\ 11
endif   


set encoding=utf-8
set fillchars+=stl:\ ,stlnc:\

" Let's press w!! for saving as root
cmap w!! %!sudo tee > /dev/null %

command Shell :set nolist | ConqueTermSplit bash
command Py :set nolist | ConqueTermSplit python

"let g:NERDTreeWinPos = "right"
"let g:NERDTreeDirArrowExpandable = '>'
"let g:NERDTreeDirArrowCollapsible = '^'
"let g:nerdtree_tabs_open_on_console_startup=1
"let g:nerdtree_tabs_smart_startup_focus=2

"autocmd VimEnter * NERDTree
"autocmd BufEnter * NERDTreeMirror

autocmd VimEnter * wincmd l
autocmd BufNew   * wincmd l

let g:ctrlp_extensions = ['smarttabs']

let g:ycm_global_ycm_extra_conf = '~/.ycm_extra_conf.py'
''


" If 1 will highlight the selected file in the tabline.
" " (Default: 1)
"
let g:ctrlp_smarttabs_reverse = 0
" " Reverse the order in which files are displayed.
" " (Default: 1)
"
"
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#fnamemod = ':t'



let g:airline_powerline_fonts = 1

"set t_Co=256
set term=xterm-256color

let g:ycm_autoclose_preview_window_after_completion=1
"map <leader>g  :YcmCompleter GoToDefinitionElseDeclaration<CR>

if has('gui_running')
   set background=dark
   colorscheme zenburn
   set cursorline
   hi CursorLine term=bold cterm=bold guibg=Grey40
else
   set background=dark
   colorscheme zenburn
   set cursorline
   hi CursorLine term=bold cterm=bold guibg=Grey40
endif

set hidden
"set term=cons25

nnoremap <Tab> :bnext<CR>
"nnoremap <F5> :GundoToggle<CR>

"nnoremap <silent> <F2> :bn<CR>
"nnoremap <silent> <S-F2> :bp<CR>

"set tags=~/code/EFC-30_v1/tags


let g:netrw_liststyle=3

let Tlist_Use_Right_Window=0
let Tlist_Auto_Open=0
let Tlist_Enable_Fold_Column=0
let Tlist_Compact_Format=0
let Tlist_WinWidth=28
let Tlist_Exit_OnlyWindow=0
let Tlist_File_Fold_Auto_Close = 0


if has('gui_running')
  set statusline+=%#warningmsg#
  set statusline+=%{SyntasticStatuslineFlag()}
  set statusline+=%*
else
  set statusline=%<%f\%h%m%r%=%-20.(line=%l\ \ col=%c%V\ \ totlin=%L%)\ \ \%h%m%r%=%-40(bytval=0x%B,%n%Y%)\%P
endif


let g:syntastic_auto_loc_list=1
let g:syntastic_loc_list_height=5


let g:session_lock_enabled = 0

"let g:session_autosave_periodic='yes'

"au VimLeavePre * call s:vim_enter_callback()

autocmd BufWritePost *.py call Flake8()
let g:flake8_show_in_file=1

let python_highlight_all=1
set expandtab
set tabstop=4
set shiftwidth=4
set ruler



" This tests to see if vim was configured with the '--enable-cscope' option
" when it was compiled.  If it wasn't, time to recompile vim... 
if has("cscope")

    """"""""""""" Standard cscope/vim boilerplate

    " use both cscope and ctag for 'ctrl-]', ':ta', and 'vim -t'
    set cscopetag

    " check cscope for definition of a symbol before checking ctags: set to 1
    " if you want the reverse search order.
    set csto=0

    " add any cscope database in current directory
    if filereadable("cscope.out")
¨        cs add cscope.out  
    " else add the database pointed to by environment variable 
    elseif $CSCOPE_DB != ""
¨        cs add $CSCOPE_DB
    endif

    " show msg when any other cscope db added
    set cscopeverbose  


    """"""""""""" My cscope/vim key mappings
    "
    " The following maps all invoke one of the following cscope search types:
    "
    "   's'   symbol: find all references to the token under cursor
    "   'g'   global: find global definition(s) of the token under cursor
    "   'c'   calls:  find all calls to the function name under cursor
    "   't'   text:   find all instances of the text under cursor
    "   'e'   egrep:  egrep search for the word under cursor
    "   'f'   file:   open the filename under cursor

    "   'i'   includes: find files that include the filename under cursor
    "   'd'   called: find functions that function under cursor calls
    "
    " Below are three sets of the maps: one set that just jumps to your
    " search result, one that splits the existing vim window horizontally and
    " diplays your search result in the new window, and one that does the same
    " thing, but does a vertical split instead (vim 6 only).
    "
    " I've used CTRL-\ and CTRL-@ as the starting keys for these maps, as it's
    " unlikely that you need their default mappings (CTRL-\'s default use is
    " as part of CTRL-\ CTRL-N typemap, which basically just does the same
    " thing as hitting 'escape': CTRL-@ doesn't seem to have any default use).
    " If you don't like using 'CTRL-@' or CTRL-\, , you can change some or all
    " of these maps to use other keys.  One likely candidate is 'CTRL-_'
    " (which also maps to CTRL-/, which is easier to type).  By default it is
    " used to switch between Hebrew and English keyboard mode.
    "
    " All of the maps involving the <cfile> macro use '^<cfile>$': this is so
    " that searches over '#include <time.h>" return only references to
    " 'time.h', and not 'sys/time.h', etc. (by default cscope will return all
    " files that contain 'time.h' as part of their name).


    " To do the first type of search, hit 'CTRL-\', followed by one of the
    " cscope search types above (s,g,c,t,e,f,i,d).  The result of your cscope
    " search will be displayed in the current window.  You can use CTRL-T to
    " go back to where you were before the search.  
    "

    nmap <F3> :cs find s <C-R>=expand("<cword>")<CR><CR>	
    nmap <f4> :cs find g <C-R>=expand("<cword>")<CR><CR>	
    nmap <C-\>c :cs find c <C-R>=expand("<cword>")<CR><CR>	
    nmap <C-\>t :cs find t <C-R>=expand("<cword>")<CR><CR>	
    nmap <C-\>e :cs find e <C-R>=expand("<cword>")<CR><CR>	
    nmap <C-\>f :cs find f <C-R>=expand("<cfile>")<CR><CR>	
    nmap <C-\>i :cs find i ^<C-R>=expand("<cfile>")<CR>$<CR>
    nmap <C-\>d :cs find d <C-R>=expand("<cword>")<CR><CR>	


    " Using 'CTRL-spacebar' (intepreted as CTRL-@ by vim) then a search type
    " makes the vim window split horizontally, with search result displayed in
    " the new window.
    "
    " (Note: earlier versions of vim may not have the :scs command, but it
    " can be simulated roughly via:
    "    nmap <C-@>s <C-W><C-S> :cs find s <C-R>=expand("<cword>")<CR><CR>	

    nmap <C-@>s :scs find s <C-R>=expand("<cword>")<CR><CR>	
    nmap <C-@>g :scs find g <C-R>=expand("<cword>")<CR><CR>	
    nmap <C-@>c :scs find c <C-R>=expand("<cword>")<CR><CR>	
    nmap <C-@>t :scs find t <C-R>=expand("<cword>")<CR><CR>	
    nmap <C-@>e :scs find e <C-R>=expand("<cword>")<CR><CR>	
    nmap <C-@>f :scs find f <C-R>=expand("<cfile>")<CR><CR>	
    nmap <C-@>i :scs find i ^<C-R>=expand("<cfile>")<CR>$<CR>	
    nmap <C-@>d :scs find d <C-R>=expand("<cword>")<CR><CR>	


    " Hitting CTRL-space *twice* before the search type does a vertical 
    " split instead of a horizontal one (vim 6 and up only)
    "
    "
    " (Note: you may wish to put a 'set splitright' in your .vimrc
    " if you prefer the new window on the right instead of the left

    nmap <C-@><C-@>s :vert scs find s <C-R>=expand("<cword>")<CR><CR>
    nmap <C-@><C-@>g :vert scs find g <C-R>=expand("<cword>")<CR><CR>
    nmap <C-@><C-@>c :vert scs find c <C-R>=expand("<cword>")<CR><CR>
    nmap <C-@><C-@>t :vert scs find t <C-R>=expand("<cword>")<CR><CR>
    nmap <C-@><C-@>e :vert scs find e <C-R>=expand("<cword>")<CR><CR>
    nmap <C-@><C-@>f :vert scs find f <C-R>=expand("<cfile>")<CR><CR>	
    nmap <C-@><C-@>i :vert scs find i ^<C-R>=expand("<cfile>")<CR>$<CR>	
    nmap <C-@><C-@>d :vert scs find d <C-R>=expand("<cword>")<CR><CR>


    """"""""""""" key map timeouts
    "
    " By default Vim will only wait 1 second for each keystroke in a mapping.
    " You may find that too short with the above typemaps.  If so, you should
    " either turn off mapping timeouts via 'notimeout'.
    "
    "set notimeout 
    "
    " Or, you can keep timeouts, by uncommenting the timeoutlen line below,
    " with your own personal favorite value (in milliseconds):
    "
    "set timeoutlen=4000
    "
    " Either way, since mapping timeout settings by default also set the
    " timeouts for multicharacter 'keys codes' (like <F1>), you should also
    " set ttimeout and ttimeoutlen: otherwise, you will experience strange
    " delays as vim waits for a keystroke after you hit ESC (it will be
    " waiting to see if the ESC is actually part of a key code like <F1>).
    "
    "set ttimeout 
    "
    " personally, I find a tenth of a second to work well for key code
    " timeouts. If you experience problems and have a slow terminal or network
    " connection, set it higher.  If you don't set ttimeoutlen, the value for
    " timeoutlent (default: 1000 = 1 second, which is sluggish) is used.
    "
    "set ttimeoutlen=100

endif


let g:ctrlp_prompt_mappings = {
    \ 'PrtExit()': ['<c-c>', '<c-g>'],
    \ }
let g:ctrlp_show_hidden = 1

if has("gui_running")
  set lines=999 columns=999
  set guioptions-=T
  set guioptions-=M
endif

set ttimeoutlen=50
if has("gui_running")
   let g:airline_theme = 'powerlineish'
else
   let g:airline_theme = 'powerlineish'
"  let g:airline_theme = 'molokai'
endif
let g:airline#extensions#hunks#enabled=0
let g:airline#extensions#branch#enabled=1

if !exists('g:airline_symbols')
      let g:airline_symbols = {}
  endif
let g:airline_symbols.space = "\ua0"
se paste
let g:TerminusMouse=1

" Diable gundo. advanced do/undo plugin
"let g:gundo_disable=0

" Enable cscope util logging 
"let g:cscope_utils_verbosity = 1

let session_autoload = 'no'

"set tags+=/home/public/linkdir/connector_code/tags
"set tags+=/home/public/linkdir/python2.7_code/tags

"let g:ProjTags = [["/home/public/linkdir/connector_code/*", "/home/public/linkdir/connector_code/tags"]]
"let g:ProjTags+= [["/home/public/linkdir/python2.7_code/*", "/home/public/linkdir/python2.7_code/tags"]]
