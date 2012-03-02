"behave mswin
" Sections:
"    -> General
"    -> VIM user interface
"    -> Colors and Fonts
"    -> Files and backups
"    -> Text, tab and indent related
"    -> Visual mode related
"    -> Command mode related
"    -> Moving around, tabs and buffers
"    -> Statusline
"    -> Parenthesis/bracket expanding
"    -> General Abbrevs
"    -> Editing mappings
"
"    -> Cope
"    -> Minibuffer plugin
"    -> Omni complete functions
"    -> Folding

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => General
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Sets how many lines of history VIM has to remember
set history=700
" Enable filetype plugin
filetype plugin on
filetype indent on

" Set to auto read when a file is changed from the outside
set autoread

" 自动命令
" 读文件时自动设定当前目录为刚读入文件所在的目录
autocmd BufReadPost * cd %:p:h

" With a map leader it's possible to do extra key combinations
" like <leader>w saves the current file
let mapleader = ","
let g:mapleader = ","

" Fast saving
nmap <leader>w :w!<cr>

" Fast editing of the .vimrc
map <leader>e :e! ~/vim/vimrc<cr>

" When vimrc is edited, reload it
autocmd! bufwritepost vimrc source /home/iceout/vim/vimrc
"au BufRead,BufNewFile *.c,*.cpp,*.py match Error /\%80v.\%81v./
au BufRead,BufNewFile *.c,*.cpp,*.py 2match Underlined /.\%81v/
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => VIM user interface
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"  VIM user interface {{{1
" Set 7 lines to the curors - when moving vertical..
"set so=7

set wildmenu "Turn on WiLd menu

set ruler "Always show current position

set nu

set cmdheight=2 "The commandbar height
"set hid "Change buffer - without saving

" Set backspace config
set backspace=eol,start,indent
set whichwrap+=<,>,h,l

set ignorecase "Ignore case when searching
set smartcase

set hlsearch "Highlight search things
set incsearch "Make search act like search in modern browsers
set nolazyredraw "Don't redraw while executing macros 

set magic "Set magic on, for regular expressions

set showmatch "Show matching bracets when text indicator is over them
set mat=2 "How many tenths of a second to blink

" No sound on errors
set noerrorbells
set novisualbell
set t_vb=
set tm=500
"}}}

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Colors and Fonts
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"  Colors and Fonts {{{1
syntax enable "Enable syntax hl

" Set font according to system
if MySys() == "mac"
  set gfn=Menlo:h14
  set shell=/bin/bash
elseif MySys() == "windows"
  set guifont=Courier_New:h12:cANSI
  "set guifontwide=Microsoft_YaHei_Mono:h12:cGB2312
  "set gfn=Bitstream\ Vera\ Sans\ Mono:h10
elseif MySys() == "linux"
  set gfn=Monospace\ 12
  set shell=/bin/bash
endif

if has("gui_running")
  set guioptions-=T
  set t_Co=256
  set background=dark
  "colorscheme peaksea
  "colorscheme freya
  colorscheme desert
else
  colorscheme zellner
  set background=dark

  set nonu
endif

"set encoding=utf8
"try
"    lang en_US
"catch
"endtry

set encoding=utf-8
set fileencodings=ucs-bom,utf-8,cp936,gb18030,big5,euc-jp,sjis,euc-kr,ucs-2le,latin1
"set termencoding=cp936
set fileencoding=utf-8
"set ffs=unix,dos,mac "Default file types
"}}}


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Files, backups and undo
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"  Files, backups and undo {{{1
" Turn backup off, since most stuff is in SVN, git anyway...
set nobackup
set nowritebackup 
set noswapfile

"Persistent undo
"try
"    if MySys() == "windows"
"      set undodir=C:\Windows\Temp
"    else
"      set undodir=~/.vim_runtime/undodir
"    endif
"
"    set undofile
"catch
"endtry
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Text, tab and indent related
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set expandtab  " 将 tab 键转换为空格
set shiftwidth=4
set tabstop=4
set smarttab

set lbr " linebreak
set tw=500

set ai "Auto indent
set si "Smart indet
set wrap "Wrap lines
"}}}

"""""""""""""""""""""""""""""""
"" => Visual mode related
"""""""""""""""""""""""""""""""
""  Visual mode related {{{1
"" Really useful!
""  In visual mode when you press * or # to search for the current selection
"vnoremap <silent> * :call VisualSearch('f')<CR>
"vnoremap <silent> # :call VisualSearch('b')<CR>
"
"" When you press gv you vimgrep after the selected text
"vnoremap <silent> gv :call VisualSearch('gv')<CR>
"map <leader>g :vimgrep // **/*.<left><left><left><left><left><left><left>
"
"
"function! CmdLine(str)
"    exe "menu Foo.Bar :" . a:str
"    emenu Foo.Bar
"    unmenu Foo
"endfunction
"
"" From an idea by Michael Naumann
"function! VisualSearch(direction) range
"    let l:saved_reg = @"
"    execute "normal! vgvy"
"
"    let l:pattern = escape(@", '\\/.*$^~[]')
"    let l:pattern = substitute(l:pattern, "\n$", "", "")
"
"    if a:direction == 'b'
"        execute "normal ?" . l:pattern . "^M"
"    elseif a:direction == 'gv'
"        call CmdLine("vimgrep " . '/'. l:pattern . '/' . ' **/*.')
"    elseif a:direction == 'f'
"        execute "normal /" . l:pattern . "^M"
"    endif
"
"    let @/ = l:pattern
"    let @" = l:saved_reg
"endfunction
"}}}

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Moving around, tabs and buffers
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"  Moving around, tabs and buffers {{{1
" Map space to / (search) and c-space to ? (backgwards search)
"map <space> /
"map <c-space> ?
map <silent> <leader><cr> :noh<cr>

" Smart way to move btw. windows
" <C-J> conflict with imaps(used by latex), so change imaps to <C-M>
map <C-k> <C-W>k
map <C-h> <C-W>h
map <C-l> <C-W>l
map <C-j> <C-W>j

" Close the current buffer
map <leader>bd :Bclose<cr>

" Close all the buffers
map <leader>ba :1,300 bd!<cr>

" Use the arrows to something usefull
map <right> :bn<cr>
map <left> :bp<cr>

" Tab configuration
map <leader>tn :tabnew<cr>
map <leader>te :tabedit
map <leader>tc :tabclose<cr>
map <leader>tm :tabmove

" When pressing <leader>cd switch to the directory of the open buffer
map <leader>cd :cd %:p:h<cr>


command! Bclose call <SID>BufcloseCloseIt()
function! <SID>BufcloseCloseIt()
   let l:currentBufNum = bufnr("%")
   let l:alternateBufNum = bufnr("#")

   if buflisted(l:alternateBufNum)
     buffer #
   else
     bnext
   endif

   if bufnr("%") == l:currentBufNum
     new
   endif

   if buflisted(l:currentBufNum)
     execute("bdelete! ".l:currentBufNum)
   endif
endfunction

" Specify the behavior when switching between buffers 
try
  set switchbuf=usetab
  set stal=2
catch
endtry
"}}}

""""""""""""""""""""""""""""""
" => Statusline
""""""""""""""""""""""""""""""
"  Statusline {{{1
" Always hide the statusline
set laststatus=2    " 显示状态栏 (默认值为 1, 无法显示状态栏)


" Format the statusline
set statusline=\ %{HasPaste()}%F%m%r%h\ %w\ \ CWD:\ %{CurDir()}\ %r%{&fileformat}%h\ \ \ Line:\ %l/%L:%c
"set statusline=\ %{HasPaste()}%F%m%r%h\ %w\ \ CWD:\ %r%{CurDir()}%h\ \ \ Line:\ %l/%L:%c


function! CurDir()
    if MySys() == "windows"
        let curdir = substitute(getcwd(), 'c:\\Users\\Tech2\\', "~/", "g")
    elseif MySys() == "linux"
        let curdir = substitute(getcwd(), '/home/iceout/', "~/", "g")
    endif
    return curdir
endfunction

function! HasPaste()
    if &paste
        return 'PASTE MODE  '
    else
        return ''
    endif
endfunction

""set statusline=%F%m%r,%Y,%{&fileformat}\ \ ASCII=\%b,HEX=\%B\ \ %l,%c\ %p%%\ \ [\ %L\ lines\ in\ all\ ]
                            " 设置在状态行显示的信息如下：
                            " %F    当前文件名
                            " %m    当前文件修改状态
                            " %r    当前文件是否只读
                            " %Y    当前文件类型
                            " %{&fileformat}
                            "       当前文件编码
                            " %b    当前光标处字符的 ASCII 码值
                            " %B    当前光标处字符的十六进制值
                            " %l    当前光标行号
                            " %c    当前光标列号
                            " %V    当前光标虚拟列号 (根据字符所占字节数计算)
                            " %p    当前行占总行数的百分比
                            " %%    百分号
                            " %L    当前文件总行数
"}}}

""""""""""""""""""""""""""""""
" => bufExplorer plugin
""""""""""""""""""""""""""""""
" bufExplorer plugin {{{1
let g:bufExplorerDefaultHelp=0
let g:bufExplorerShowRelativePath=1
map <leader>o :BufExplorer<cr>
"}}}

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Omni complete functions
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Omni{{{1
set completeopt+=longest
"set ofu=syntaxcomplete#Complete
autocmd FileType python set omnifunc=pythoncomplete#Complete
autocmd FileType javascript set omnifunc=javascriptcomplete#CompleteJS
autocmd FileType html set omnifunc=htmlcomplete#CompleteTags
autocmd FileType css set omnifunc=csscomplete#CompleteCSS
autocmd FileType xml set omnifunc=xmlcomplete#CompleteTags
autocmd FileType java set omnifunc=javacomplete#Complet
"}}}


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Folding 
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Folding {{{1
"折叠相关的快捷键
"zR 打开所有的折叠
"za Open/Close (toggle) a folded group of lines.
"zA Open a Closed fold or close and open fold recursively.
"zi 全部 展开/关闭 折叠
"zo 打开 (open) 在光标下的折叠
"zc 关闭 (close) 在光标下的折叠
"zC 循环关闭 (Close) 在光标下的所有折叠
"zM 关闭所有可折叠区域
set foldenable
" 设置语法折叠
" manual  手工定义折叠
" indent  更多的缩进表示更高级别的折叠
" expr    用表达式来定义折叠
" syntax  用语法高亮来定义折叠
" diff    对没有更改的文本进行折叠
" marker  对文中的标志折叠
set foldmethod=marker
" 设置折叠层数为
"set foldlevel=0
" 设置折叠区域的宽度
set foldcolumn=0
" 新建的文件，刚打开的文件不折叠
"autocmd! BufNewFile,BufRead * setlocal nofoldenable
" }}}

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => snipMate 
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" snipMate {{{1
let g:snips_author='iceout'
let g:snips_email='ice.404.out@gmail.com'
"}}}

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => WinManager
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:winManagerWindowLayout='FileExplorer|TagList'
nmap wm :WMToggle<cr>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Uncomment the following to have Vim jump to the 
" last position when reopening a file
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
if has("autocmd")
  au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
endif

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => vim cycle
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"{{{1
    let g:cycle_default_groups = [
          \   [['true', 'false']],
          \   [['yes', 'no']],
          \   [['on', 'off']],
          \   [['+', '-']],
          \   [['>', '<']],
          \   [['"', "'"]],
          \   [['==', '!=']],
          \   [['0', '1']],
          \   [['and', 'or']],
          \   [["in", "out"]],
          \   [["up", "down"]],
          \   [["min", "max"]],
          \   [["get", "set"]],
          \   [["add", "remove"]],
          \   [["to", "from"]],
          \   [["read", "write"]],
          \   [["only", "except"]],
          \   [['without', 'with']],
          \   [["exclude", "include"]],
          \   [["asc", "desc"]],
          \   [['是', '否']],
          \   [['{:}', '[:]', '(:)'], 'sub_pairs'],
          \   [['（:）', '「:」', '『:』'], 'sub_pairs'],
          \   [['Sunday', 'Monday', 'Tuesday', 'Wednesday', 'Thursday',
          \     'Friday', 'Saturday'], 'hard_case', {'name': 'Days'}],
          \ ]
"}}}

au VimEnter * RainbowParenthesesToggle

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" cscope setting 
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" cscope {{{1
if has("cscope") && executable("cscope")
" 设置 {{{2
  set csto=1
  set cst
  set cscopequickfix=s-,c-,d-,i-,t-,e-

" add any database in current directory
  function! Lilydjwg_csadd()
    set nocsverb
    if filereadable("cscope.out")
      cs add cscope.out
    endif
    set csverb
  endfunction

  autocmd BufRead *.c,*.cpp,*.h call Lilydjwg_csadd()

" 映射 {{{2
" 查找C语言符号，即查找函数名、宏、枚举值等出现的地方
  nmap css :cs find s <C-R>=expand("<cword>")<CR><CR>
" 查找函数、宏、枚举等定义的位置，类似ctags所提供的功能
  nmap csg :cs find g <C-R>=expand("<cword>")<CR><CR>
" 查找本函数调用的函数
  nmap csd :cs find d <C-R>=expand("<cword>")<CR><CR>
" 查找调用本函数的函数
  nmap csc :cs find c <C-R>=expand("<cword>")<CR><CR>
" 查找指定的字符串
  nmap cst :cs find t <C-R>=expand("<cword>")<CR><CR>
" 查找egrep模式，相当于egrep功能，但查找速度快多了
  nmap cse :cs find e <C-R>=expand("<cword>")<CR><CR>
" 查找并打开文件，类似vim的find功能
  nmap csf :cs find f <C-R>=expand("<cfile>")<CR><CR>
" 查找包含本文件的文件
  nmap csi :cs find i ^<C-R>=expand("<cfile>")<CR>$<CR>
" 生成新的数据库
  nmap csn :lcd %:p:h<CR>:!my_cscope<CR>
" 自己来输入命令
  nmap cs<Space> :cs find
endif
"}}}1


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" latex
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" REQUIRED. This makes vim invoke Latex-Suite when you open a tex file.
"filetype plugin on

" IMPORTANT: win32 users will need to have 'shellslash' set so that latex
" can be called correctly.
set shellslash

" IMPORTANT: grep will sometimes skip displaying the file name if you
" search in a singe file. This will confuse Latex-Suite. Set your grep
" program to always generate a file-name.
set grepprg=grep\ -nH\ $*

" OPTIONAL: This enables automatic indentation as you type.
"filetype indent on

" OPTIONAL: Starting with Vim 7, the filetype of empty .tex files defaults to
" 'plaintex' instead of 'tex', which results in vim-latex not being loaded.
" The following changes the default filetype back to 'tex':
let g:tex_flavor='latex'
