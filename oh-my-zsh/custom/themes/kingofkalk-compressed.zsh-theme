# vim:ft=zsh ts=2 sw=2 sts=2

PROMPT='╭[%n|%m|%D{%x}|%D{%X}|$?] %{$fg_bold[green]%}${PWD/#$HOME/~}%{$reset_color%}%{$reset_color%}$(git_prompt_info)%{$fg_bold[red]%}%{$reset_color%}
$ '

ZSH_THEME_GIT_PROMPT_PREFIX=" on %{$fg[magenta]%}⭠ "
ZSH_THEME_GIT_PROMPT_SUFFIX="%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_DIRTY="%{$fg[red]%}!"
ZSH_THEME_GIT_PROMPT_UNTRACKED="%{$fg[green]%}?"
ZSH_THEME_GIT_PROMPT_CLEAN=""
