" Execute file being edited with <Shift> + r:
"map <buffer> <S-r> :w<CR>:pyfile % <CR>
"there is an error of pyfile when the program needed input
map <buffer> <S-r> :w<CR>:!python % 
