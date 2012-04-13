" Execute file being edited with <F9>:
if MySys() == "windows"
    map <buffer> <F9> :w<CR>:!gcc -o %< %<CR>:!%<
elseif MySys() == "linux"
    map <buffer> <F9> :w<CR>:!gcc -o %< %<CR>:!./%<
endif
