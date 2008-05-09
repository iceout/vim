if !exists('g:git_command_edit')
    let g:git_command_edit = 'new'
endif

if !exists('g:git_bufhidden')
    let g:git_bufhidden = ''
endif

nnoremap <Leader>gd :GitDiff<Enter>
nnoremap <Leader>gD :GitDiff --cached<Enter>
nnoremap <Leader>gs :GitStatus<Enter>
nnoremap <Leader>gl :GitLog<Enter>
nnoremap <Leader>ga :GitAdd<Enter>
nnoremap <Leader>gA :GitAdd <cfile><Enter>
nnoremap <Leader>gc :GitCommit<Enter>

" Returns current git branch.
" Call inside 'statusline' or 'titlestring'.
function! GitBranch()
    if !exists('b:git_head_path')
        let paths = split(s:Expand('%:p:h'), '/')
        while len(paths)
            let dir = join(paths, '/')
            if filereadable(dir . '/.git/HEAD')
                let b:git_head_path = dir . '/.git/HEAD'
                break
            endif
            call remove(paths, -1)
        endwhile

        if !exists('b:git_head_path')
            let b:git_head_path = ''
        endif
    endif

    if strlen(b:git_head_path)
        let lines = readfile(b:git_head_path)
        return len(lines) ? matchstr(lines[0], '[^/]*$') : ''
    else
        return ''
    endif
endfunction

" List all git local branches.
function! ListGitBranches(arg_lead, cmd_line, cursor_pos)
    let branchs = split(system('git branch'))
    if branchs[0] == 'fatal:'
        let branches = []
    else
        let branches = filter(split(system('git branch')), 'v:val != "*"')
    endif
    return branches
endfunction

" List all git commits.
function! ListGitCommits(arg_lead, cmd_line, cursor_pos)
    let commits = split(system('git log --pretty=format:%h'))
    let commits = ['HEAD'] + ListGitBranches(a:arg_lead, a:cmd_line, a:cursor_pos) + commits

    if a:cmd_line =~ '^GitDiff'
        " GitDiff accepts <commit>..<commit>
        if a:arg_lead =~ '\.\.'
            let pre = matchstr(a:arg_lead, '.*\.\.\ze')
            let commits = map(commits, 'pre . v:val')
        endif
    endif

    return filter(commits, 'match(v:val, ''\v'' . a:arg_lead) == 0')
endfunction

" Show diff.
function! GitDiff(args)
    let git_output = system('git diff ' . a:args . ' -- ' . s:Expand('%'))
    if !strlen(git_output)
        echo "No output from git command"
        return
    endif

    call <SID>OpenGitBuffer(git_output)
    set filetype=diff
endfunction

" Show Status.
function! GitStatus()
    let git_output = system('git status')
    call <SID>OpenGitBuffer(git_output)
    set filetype=git-status
endfunction

" Show Log.
function! GitLog()
    let git_output = system('git log -- ' . s:Expand('%'))
    call <SID>OpenGitBuffer(git_output)
    set filetype=git-log
endfunction

" Add file to index.
function! GitAdd(expr)
    let file = s:Expand(strlen(a:expr) ? a:expr : '%')

    silent execute '!git add ' . file

    if !v:shell_error
        echo 'Added ' . file . ' to index'
    endif
endfunction

" Commit.
function! GitCommit()
    let git_output = system('git status')
    execute g:git_command_edit . ' `=tempname()`'
    silent put=git_output
    keepjumps 0d
    set filetype=git-status bufhidden=delete

    augroup GitCommit
        autocmd BufWritePre  <buffer> g/^#\|^\s*$/d | set fileencoding=utf-8
        autocmd BufWritePost <buffer> execute '!git commit -F %' | autocmd! GitCommit * <buffer>
    augroup END
endfunction

" Checkout.
function! GitCheckout(args)
    let git_output = system('git checkout ' . a:args)
    if v:shell_error
        echohl Error
        echo git_output
        echohl None
    else
        echo git_output
    endif
endfunction

function! s:OpenGitBuffer(content)
    if exists('b:is_git_msg_buffer') && b:is_git_msg_buffer
        enew!
    else
        execute g:git_command_edit
    endif

    set buftype=nofile
    execute 'set bufhidden=' . g:git_bufhidden

    silent put=a:content
    keepjumps 0d

    let b:is_git_msg_buffer = 1
endfunction

function! s:Expand(expr)
    if has('win32')
        return substitute(expand(a:expr), '\', '/', 'g')
    else
        return expand(a:expr)
    endif
endfunction

command! -nargs=1 -complete=customlist,ListGitCommits GitCheckout call GitCheckout(<q-args>)
command! -nargs=* -complete=customlist,ListGitCommits GitDiff     call GitDiff(<q-args>)
command!          GitStatus  call GitStatus()
command! -nargs=? GitAdd     call GitAdd(<q-args>)
command!          GitLog     call GitLog()
command!          GitCommit  call GitCommit()
