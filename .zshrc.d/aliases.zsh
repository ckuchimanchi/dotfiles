alias rg='rg --smart-case'
alias j='jest'
alias jw='jest --watch'
alias et='et -r "12345:12345"'
#
#
# Functions.... 
#
# find a file through fuzzy finder and open it in editor
fzf_find_edit() {
    local file=$(
      fzf --no-multi --preview 'bat --color=always --line-range :500 {}'
      )
    if [[ -n $file ]]; then
        $EDITOR $file
    fi
}

alias ffe='fzf_find_edit'

# Find File with a particular search term, preview it, and then edit with your editor and if it supports jump to that line

fzf_grep_edit(){
    if [[ $# == 0 ]]; then
        echo 'Error: search term was not provided.'
        return
    fi
    local match=$(
      rg --color=never --line-number "$1" |
        fzf --no-multi --delimiter : \
            --preview "bat --color=always --line-range {2}: {1}"
      )
    local file=$(echo "$match" | cut -d':' -f1)
    if [[ -n $file ]]; then
        $EDITOR $file +$(echo "$match" | cut -d':' -f2)
    fi
}

alias fge='fzf_grep_edit'
