" Execute file being edited with <Alt> + r:
"map <buffer> <A-r> :w<CR>:pyfile % <CR>
"I cannot find ways of making pyfile to satisfy the situation needed input
map <buffer> <A-r> :w<CR>:!python % 
