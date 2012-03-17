" Execute file being edited with <Alt> + r:
map <buffer> <F9> :w<CR>:!gcc -o %< %<CR>:!./%<
