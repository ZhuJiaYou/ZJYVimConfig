""""""""""""""""""""""""""""""""
"Interface
""""""""""""""""""""""""""""""""
set nu  "show line number
syntax enable "syntax highlight  
syntax on
set cc=110
set statusline=%F%m%r%h%w%=\ [TYPE=%Y]\ %{\"[ENCD=\".(&fenc==\"\"?&enc:&fenc).((exists(\"+bomb\")\ &&\ &bomb)?\"+\":\"\").\"]\"}\ [FMT=%{&ff}]\ [ASC=%03.3b]\ [HEX=%02.2B]\ [POS=%04l,%04v][%p%%]\ [LEN=%L]
set laststatus=2
""""""""""""""""""""""""""""""""
"Key command
""""""""""""""""""""""""""""""""    
set tabstop=4  "set Tab = 4
set softtabstop=4  "indent= 4
set shiftwidth=4 
""""""""""""""""""""""""""""""""
"Compile
""""""""""""""""""""""""""""""""
map <F5> :call CompileRunGcc()<CR>
func! CompileRunGcc()
    exec "w"
    if &filetype == 'c'
        exec "!clang++ % -o %<"
		exec "! ./%<"
    elseif &filetype == 'cpp'
        exec "!clang++ % -o %<"
        exec "! ./%<"
    elseif &filetype == 'java' 
        exec "!javac %" 
        exec "!java %<"
	elseif &filetype == 'python'
		exec "!time python3 %"
    elseif &filetype == 'sh'
        :!./%
    endif
endfunc

"""""""""""""""""""""""""""""""""
"Debug
"""""""""""""""""""""""""""""""""   
map <F6> :call Rungdb()<CR>
func! Rungdb()
    exec "w"
    exec "!g++ % -g -o %<"
    exec "!gdb ./%<"
endfunc

"""""""""""""""""""""""""""""""""
"Others
"""""""""""""""""""""""""""""""""
filetype plugin indent on
set autowrite               
set ruler           
set cursorline              
set magic                   
set guioptions-=T           
set guioptions-=m           
set autoindent
set cindent
set mouse=a  "always use mouse 
set backspace=indent,eol,start
"remember cursor position
if has("autocmd")
  au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
endif

""""""""""""""""""""""""""""""""""
"Config for Completor
""""""""""""""""""""""""""""""""""
let g:completor_python_binary = '/usr/bin/python3'
let g:completor_clang_binary = '/usr/bin/clang'
let g:completor_clang_disable_placeholders = 1

""""""""""""""""""""""""""""""""""
"Config for NERDTree
""""""""""""""""""""""""""""""""""
autocmd vimenter * NERDTree
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 1 && isdirectory(argv()[0]) && !exists("s:std_in") | exe 'NERDTree'	
			\ argv()[0] | wincmd p | ene | exe 'cd '.argv()[0] | endif
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
map <F3> :NERDTreeToggle<CR>
let g:NERDTreeDirArrowExpandable = '+'
let g:NERDTreeDirArrowCollapsible = '-'
autocmd VimEnter * NERDTree | wincmd p
let g:NERDTreeWinSize=25
