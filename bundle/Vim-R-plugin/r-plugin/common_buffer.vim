"  This program is free software; you can redistribute it and/or modify
"  it under the terms of the GNU General Public License as published by
"  the Free Software Foundation; either version 2 of the License, or
"  (at your option) any later version.
"
"  This program is distributed in the hope that it will be useful,
"  but WITHOUT ANY WARRANTY; without even the implied warranty of
"  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
"  GNU General Public License for more details.
"
"  A copy of the GNU General Public License is available at
"  http://www.r-project.org/Licenses/

"==========================================================================
" ftplugin for R files
"
" Authors: Jakson Alves de Aquino <jalvesaq@gmail.com>
"          Jose Claudio Faria
"          
"          Based on previous work by Johannes Ranke
"
" Please see doc/r-plugin.txt for usage details.
"==========================================================================


" Set completion with CTRL-X CTRL-O to autoloaded function.
if exists('&ofu')
  setlocal ofu=rcomplete#CompleteR
endif

" Automatically rebuild the file listing .GlobalEnv objects for omni
" completion if the user press <C-X><C-O> and we know that the file either was
" not created yet or is outdated.
let b:needsnewomnilist = 0

" This isn't the Object Browser running externally
let b:rplugin_extern_ob = 0

" Set the name of the Object Browser caption if not set yet
let s:tnr = tabpagenr()
if !exists("b:objbrtitle")
  if s:tnr == 1
    let b:objbrtitle = "Object_Browser"
  else
    let b:objbrtitle = "Object_Browser" . s:tnr
  endif
  unlet s:tnr
endif


" Initialize some local variables if Conque shell was already started
if exists("g:rplugin_objbrtitle")
  if g:vimrplugin_conqueplugin
    let b:conqueshell = g:rplugin_conqueshell
    let b:conque_bufname = g:rplugin_conque_bufname
  endif
  let b:objbrtitle = g:rplugin_objbrtitle
endif

" Make the file name of files to be sourced
let b:bname = expand("%:t")
let b:bname = substitute(b:bname, " ", "",  "g")
if exists("*getpid") " getpid() was introduced in Vim 7.1.142
  let b:rsource = $VIMRPLUGIN_TMPDIR . "/Rsource-" . getpid() . "-" . b:bname
else
  let b:randnbr = system("echo $RANDOM")
  let b:randnbr = substitute(b:randnbr, "\n", "", "")
  if strlen(b:randnbr) == 0
    let b:randnbr = "NoRandom"
  endif
  let b:rsource = $VIMRPLUGIN_TMPDIR . "/Rsource-" . b:randnbr . "-" . b:bname
  unlet b:randnbr
endif
unlet b:bname

" Special screenrc file
let b:scrfile = " "

if exists("g:rplugin_firstbuffer") && g:rplugin_firstbuffer == ""
    " The file global_r_plugin.vim was copied to ~/.vim/plugin
    let g:rplugin_firstbuffer = expand("%:p")
endif

let g:rplugin_lastft = &filetype

