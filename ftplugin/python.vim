" Execute file being edited with <Shift> + r:
"map <buffer> <S-r> :w<CR>:pyfile % <CR>
"I cannot find ways of making pyfile to satisfy the situation needed input
map <buffer> <S-r> :w<CR>:!python % 

