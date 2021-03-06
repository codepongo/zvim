""
"@file			zuohaitao.vim
"@brief			gvim config file
"@author		zuohaitao
"@date			2011-08-28
"@version		2.0
"@details
"	Windows OS
"		1. Windows copy this file to $VIM
"		2. Edit $(VIM)/_vimrc, add "source $VIM/_zuohaitao.vim"
"	Linux
"		1. Copy this file to ~ and rename .zuohaitao.vim
"		2. Edit ~/.vimrc, add "source ~/.zuohaitao.vim"
"	enjoy it
" history
"		2015/10/10
"					compatible with mac vim 7.4
"		2012/12/17
"					the file that the name of is blog is a python file  
"		2012/12/12	
"					suport markdown format file(*.md,*.markdown)
"		2012/12/04
"					map <silent><leader>fh add c/c++ file header comment
"					map <silent><leader>fc add c/c++ function comment
"
"		2012/09/29
"					<F2> <C-F2> mark (use visualmark.vim) 
"					add ruller
"					add auto columns=100
"					add indent_guides configure
"					add python(.py) file is supported
"		2012/08/24
"					add comment to explain how to convert 'tab' to 'space'
"		2012/07/31 
"					objc(.m) file is supported
"		2011/08/28 
"					fix comment function in macvim
"		2011/08/18
"					fix tags path support jump win32 API
"					fix comment
"					recode make file header comment
"					recode make function comment
"
"		2011/08/12
"					change for mac os X
"					reconstruction
"					for support python IDE
"					fix problem show unicode file in win32 is not well
"					reconstruction map keyboard
"		2010/06/05 modify _fl porting in win32
"		2010/03/28 map _fn for function comment
"					map _fl for file header comment
"		2009/06/22 set tags comment
"		2009-06-03 
"			add auto complementation in line 132-134		
"		2009-02-28 fix in linux don't read some file in line 24 'encoding=gbk' 
"		2008/12/06 set tags 
"
"Todo:
"		test all in vim in linux 
"		test all in macvim 
"
""			
"Set character set
function! s:QfMakeConv()
	let qflist = getqflist()
	for i in qflist
		let i.text = iconv(i.text, "cp936", "utf-8")
	endfor
	call setqflist(qflist)
endfunction
function! s:win32_unicode_file()
	let fn = bufname("%") 
	if (".reg" == strpart(fn,len(fn)-4, 4))
		set encoding=utf-8
		set fileencodings=ucs-bom,utf-8,cp936,big5,latin1
		au QuickfixCmdPost make call s:QfMakeConv()
		au TabEnter make call s:QfMakeConv()
	endif
	if (".xml" == strpart(fn,len(fn)-4, 4))
		set encoding=utf-8
		set fileencodings=ucs-bom,utf-8,cp936,big5,latin1
		au QuickfixCmdPost make call s:QfMakeConv()
		au TabEnter make call s:QfMakeConv()
	endif
	if (".xaml" == strpart(fn,len(fn)-5, 5))
		set filetype=xml
		set encoding=utf-8
		set fileencodings=ucs-bom,utf-8,cp936,big5,latin1
		au QuickfixCmdPost make call s:QfMakeConv()
		au TabEnter make call s:QfMakeConv()
	endif
	if (".m" == strpart(fn,len(fn)-2, 2))
		set encoding=utf-8
		set fileencodings=ucs-bom,utf-8,cp936,big5,latin1
		au QuickfixCmdPost make call s:QfMakeConv()
		au TabEnter make call s:QfMakeConv()
	endif
	if (".sln" == strpart(fn,len(fn)-4, 4))
		set encoding=utf-8
		set fileencodings=ucs-bom,utf-8,cp936,big5,latin1
		au QuickfixCmdPost make call s:QfMakeConv()
		au TabEnter make call s:QfMakeConv()
	endif
	if (".py" == strpart(fn,len(fn)-3, 3))
		set encoding=utf-8
		set fileencodings=ucs-bom,utf-8,cp936,big5,latin1
		au QuickfixCmdPost make call s:QfMakeConv()
		au TabEnter make call s:QfMakeConv()
	endif
	if ("blog" == strpart(fn,len(fn)-3, 3))
		set encoding=utf-8
		set fileencodings=ucs-bom,utf-8,cp936,big5,latin1
		au QuickfixCmdPost make call s:QfMakeConv()
		au TabEnter make call s:QfMakeConv()
	endif
	if (".cgi" == strpart(fn,len(fn)-4, 4))
		set encoding=utf-8
		set fileencodings=ucs-bom,utf-8,cp936,big5,latin1
		au QuickfixCmdPost make call s:QfMakeConv()
		au TabEnter make call s:QfMakeConv()
	endif
	if (".utf8.txt" == strpart(fn,len(fn)-9, 9))
		set encoding=utf-8
		set fileencodings=ucs-bom,utf-8,cp936,big5,latin1
		au QuickfixCmdPost make call s:QfMakeConv()
		au TabEnter make call s:QfMakeConv()
	endif
	if ("blog" == strpart(fn,len(fn)-4, 4))
		set encoding=utf-8
		set fileencodings=ucs-bom,utf-8,cp936,big5,latin1
		au QuickfixCmdPost make call s:QfMakeConv()
		au TabEnter make call s:QfMakeConv()
	endif
	if (".md" == strpart(fn, len(fn)-3, 3))
		set encoding=utf-8
		set fileencodings=ucs-bom,utf-8,cp936,big5,latin1
		au QuickfixCmdPost make call s:QfMakeConv()
		au TabEnter make call s:QfMakeConv()
	endif
	if (".markdown" == strpart(fn, len(fn)-9, 9))
		set encoding=utf-8
		set fileencodings=ucs-bom,utf-8,cp936,big5,latin1
		au QuickfixCmdPost make call s:QfMakeConv()
		au TabEnter make call s:QfMakeConv()
	endif
endfunction

if (has("linux")||has("mac"))
	set encoding=utf-8
	set fileencodings=ucs-bom,utf-8,cp936,big5,latin1
	set ambiwidth=double
elseif has("win32")
	call s:win32_unicode_file()
	set encoding=utf-8
endif

"Set shell to be bash
if (has("unix")||has("mac"))
	set shell=bash
elseif has("win32")
	"use default shell because set shell=cmd will be cause confilict with taglist 
	"more than see taglist.vim in line 2268
	"set shell=cmd
endif
"set For All (Linux & Windows & mac)
set showmode "set current mode
syntax on "syntax highlight
set tabstop=4 shiftwidth=4 sts=4 "tab=4 byte
set ai "autoindent
set noexpandtab "close replace tab to 4 byte blank
set nocompatible	"set normal ,use vim feature
set hlsearch "rearch result is highlight
set helplang=cn " set help file is chinese
set cindent " C indent format
set backspace=indent,eol,start " backspace is indent, eol, start
set linespace=5	"linespace
set number	"line number
set imcmdline	"the Input Method is always	
set laststatus=2 "always a status line
set list
if has("gui_running")
	set cc=80 "ruller
endif
set columns=100
if has("mac")
	set macmeta
endif

"color style
if has("gui_running")
	colorscheme pablo	
endif
"backup
if (has("mac")||has("linux"))
	set backupdir=/tmp
elseif has("win32")
	set backupdir=c:\tmp "save template directory
endif
"undo
if (version >= 703)
	set undofile
	if (has("mac")||has("linux"))
		set undodir=~/.undo
	elseif has("win32")
		set undodir=C:\undo
	endif
	set cryptmethod=blowfish
endif
"Set mapleader repleace \xx to ,xx
let mapleader = ","

""""""""""""""""""""""""""""""
"Plugin Setting 
""""""""""""""""""""""""""""""

"ctags.exe path
if has("win32")                "set ctags path in windows OS
	let Tlist_Ctags_Cmd="\"".$VIM."\\ctags.exe\""
elseif has("linux")              "set ctags path in linux OS
	let Tlist_Ctags_Cmd = '/usr/bin/ctags'
elseif has("mac")
	let Tlist_Ctags_Cmd = '/usr/local/bin/ctags'
endif
"set ctags
if (has("mac")|| has("linux"))
	"$>cd /usr/include
	"$>sudo ctags -R .
	set tags+=/usr/include/tags
elseif (has("win32"))
	"cd $VIM
	"ctag -R C:\Program Files\Microsoft Visual Studio 9.0\VC
	"ctag -R C:\Program Files\Microsoft SDKs
	let $T = $VIM
	let $T = substitute($T, " ", "\\\\\\\\\\\\ ", "")
	let $T = $VIM."\\tags"
	set tags+=$T
endif

"tagbar
nmap <silent><F1> :TagbarToggle<CR>

"comment
function! s:comment()
	if (s:cmfmt == "")
		echo "file type dose not support comment."
		return
	endif
	let l = getline(".")
	let l = substitute(l, "^", s:cmfmt, "")
	call setline(".", l)
endfunction
function! s:uncomment()
	let l = getline(".")
	let i = 0
	while ( i < strlen(l))
		let c = strpart(l, i, 1)
		if ((" " == c) || ("\t" == c))
			let i = i + 1
			continue
		else
			let c = strpart(l, i, strlen(s:cmfmt))
			if (s:cmfmt == c)
				let l = substitute(l, s:cmfmt, "", "")
				call setline(".", l)
			endif
			break
		endif
	endwhile
endfunction
let s:cmfmt=""
au BufNewFile,BufRead, *.py	let s:cmfmt="#"
au BufNewFile,BufRead, blog	let s:cmfmt="#"
au BufNewFile,BufRead, *.c,*.cpp,*.h,*.m	let s:cmfmt="//"
au BufNewFile,BufRead, *.vim let s:cmfmt="\""
au BufNewFile,BufRead, *.bat let s:cmfmt="REM "
au BufNewFile,BufRead, *.sh let s:cmfmt="#"
"comment keyboard map
if has("win32")
	map <silent><C-K><C-C>	:call s:comment()<CR>
	map <silent><C-K><C-U>	:call s:uncomment()<CR>
elseif has("mac")
	map <M-k><M-c> :call s:comment()<CR>
	map <M-k><M-u> :call s:uncomment()<CR>
endif
function! s:cfh()
"comment file header ONLY support for C filetype!
	let c = "/**"
	call append(0, c)
	let c = " @file\t\t".bufname("%")
	call append(1, c)
	let c = " @brief\t\t"
	call append(2, c)
	let c = " @details\t"
	call append(3, c)
	let c = " @author\tzuohaitao"
	call append(4, c)
	let c = " @date\t\t".strftime("%Y-%m-%d")
	call append(5, c)
	let c = " warning\t"
	call append(6, c)
	let c = " bug\t\t"
	call append(7, c)
	let c = "**/"
	call append(8, c)
	let p = [0, 0, 0, -1]
	call setpos(".", p)
	let p = [0, 3, 13, -1]
	call setpos(".", p)
endfunction
map <silent><leader>fh :call s:cfh()<CR>a
function! s:cfc()
"comment function ONLY support for C filetype!
	let p = line(".") - 1
	let c = "/**"
	call append(p, c)
	let c = " @name\t".bufname("%")
	call append(p+1, c)
	let c = " @brief\t"
	call append(p+2, c)
	let c = " @param\t [I/O] -"
	call append(p+3, c)
	let c = " return\t"
	call append(p+4, c)
	let c = "**/"
	call append(p+5, c)
	let cp = [0, p, 0, -1]
	call setpos(".", p)
	let cp = [0, p+3, 8, -1]
	call setpos(".", cp)
endfunction
map <silent><leader>fc :call s:cfc()<CR>a
map <silent><leader>2h <ESC>:runtime syntax/2html.vim<ESC>:%s/\(<body.*\)/\1\r<br>\r<table width=100% bgcolor="#000000" border=1>\r<tr>\r<td><font color="#ffffff">\r<ESC>:%s/\(.*\)\(<\/body>\)/\1<\/font><\/td>\r<\/tr>\r<\/table>\r\2/<ESC>:wq<ESC>

"auto fill 
filetype plugin indent on
set completeopt=longest,menu
"ctrl+x ctrl+o

"set python ide
function! s:setting()
	set expandtab
	if has("mac")
		map <F5> <ESC>:exe "!python3 %"<cr>
	elseif has("win32")
		map <F5> <ESC>:exe "!C:\\Python32\\python.exe %"<cr>
	endif
endfunction

"cd the dir where current file is in
if "" !=bufname("%")
	cd %:h
endif
"pydiction
if has("mac")
	let g:pydiction_location=$HOME."/.vim/complete-dict"
elseif has("win32")
	let g:pydiction_location=$VIM."\\vimfiles\\complete-dict"
endif
au BufNewFile,BufRead, *.md set filetype=markdown
au BufNewFile,BufRead, *.py,blog call s:setting()
au BufNewFile,BufRead, *.m set filetype=objc
au BufNewFile,BufRead, *.json set tabstop=2 shiftwidth=2 sts=2 expandtab
au BufNewFile,BufRead, *.json let s:cmfmt="//"
au BufNewFile,BufRead, *.js set tabstop=2 shiftwidth=2 sts=2 expandtab
au BufNewFile,BufRead, *.js let s:cmfmt="//"
au BufNewFile,BufRead, *.html highlight Special guifg=#ffffff
"""""""""""""""""""
"""""some useful command"""""
"read unicode in vim set encoding=utf-8
":%!xxd :%xxd -r
"auto ident code gg=G

"del comment '88 //'
":n,m s/\/\//
":%s/\/\//
"add comment '(^- -)'
":n,m s/^/\/\/
":%s/^/\/\/
":%s/old/new/g
":%s/^\/\///g
"set fileformat=doc set fileformat=unix
"fold
"set foldmethod=marker " code fold
"zF make the fold mark
"zc make the code between the operator
"zo expand the fold code
"tabnew tabn<PageNumber>
"tab <-> space
":set expandtab
":retab!
":set noexpandtab
",fh add c file header comment
",fc add c file function comment
"set cursorline / set nocursorline highline current line
